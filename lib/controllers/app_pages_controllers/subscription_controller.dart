import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import '../../config.dart';

import '../../screens/app_screens/subscription/layouts/payment_method.dart';
import '../../screens/app_screens/subscription/layouts/payment_method_list.dart';
import '../../screens/app_screens/subscription/layouts/paypal_payment.dart';
import '../../screens/app_screens/subscription/layouts/paypal_services.dart';
import '../../widgets/alert_dialog_common.dart';

class SubscriptionController extends GetxController {
  List<SubscribeModel> subscriptionLists = [];
  List currencyList = [];

  int selectIndex = 0;
  int selectIndexPayment = 0;
  List paymentMethods = [];
  Map<String, dynamic>? paymentIntentData;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  PaypalServices services = PaypalServices();
  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  WebViewController controller = WebViewController();

  // item name, price and quantity
  String itemName = 'iPhone X';
  int quantity = 1;
  Function? onFinish;

  // Stripe Payment Method
  Future<void> stripePayment(
      {required String amount, required String currency}) async {
    try {
      isLoading = true;
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: 'JUSTIN',
                billingDetails: const BillingDetails(
                  email: 'email@stripe.com',
                  phone: '+60123456789',
                  address: Address(
                    city: 'Kuala Lumpur',
                    country: 'US',
                    line1: 'Concourse Level',
                    line2: '',
                    state: '',
                    postalCode: '90001',
                  ),
                ),
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret:
                    paymentIntentData!['ephemeralKey']));

        isLoading = false;
        displayPaymentSheet();
        update();
      }
    } catch (e) {
      throw Exception("$e");
    }
    update();
  }

  // Stripe Error handler
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) {
            return AlertDialogCommon(
                image: eImageAssets.paymentSuccess,
                bText1: appFonts.okay,
                title: appFonts.paymentSuccess,
                subtext: appFonts.congratulation,
                b1OnTap: () => Get.offAllNamed(routeName.subscriptionPlan),
                crossOnTap: () => Get.offAllNamed(routeName.subscriptionPlan));
          });
    } on Exception {
      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) {
            return AlertDialogCommon(
                image: eImageAssets.paymentFailed,
                bText1: appFonts.tryAgain,
                title: appFonts.paymentFailed,
                subtext: appFonts.oppsDueTo,
                b1OnTap: () => Get.back(),
                crossOnTap: () => Get.back());
          });
    }
    update();
  }

  // Stripe Create payment Method
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51MmFV9SEDxC6QpAREwfslXhtxBB4xrvCCOAmN0I6EN1nGzndtX7sr2VTBgIKpsBAtNtGrQT3voNdKSoJDXAOxteE00toeXgSE1',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception("");
    }
  }

  // Stripe amount calculate
  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  // Paypal Order create method
  Map<String, dynamic> getOrderParams(String data) {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": data,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": data,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": data,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": "$userFirstName $userLastName",
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              }
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  onPaypalPayment({required String amount}) async {
    try {
      final transactions = getOrderParams(amount);
      log("message: $transactions");
      final res = await services.createPaypalPayment(transactions, accessToken);
      checkoutUrl = res["approvalUrl"];
      executeUrl = res["executeUrl"];
      update();
      log("RES: $res");
      log("checkoutUrl: $checkoutUrl");
      log("executeUrl: $executeUrl");
      Get.to(() => const PaypalPayment());
    } catch (e) {
      showDialog(
          barrierDismissible: false,
          context: Get.context!, builder: (context) {
        return AlertDialogCommon(
            image: eImageAssets.paymentFailed,
            bText1: appFonts.tryAgain,
            title: appFonts.paymentFailed,
            subtext: appFonts.oppsDueTo,
            b1OnTap: ()=> Get.back(),
            crossOnTap: ()=> Get.back()
        );
      });
    }

    update();
  }

  @override
  void onReady() {
    paymentMethods = appArray.paymentMethodList;
    subscriptionLists = appArray.subscriptionPlan
        .map((e) => SubscribeModel.fromJson(e))
        .toList();
    currencyList = appArray.currencyList;
    dynamic arg = appCtrl.storage.read("currency") ?? appArray.currencyList[0];
    if (arg["title"] == "dollar") {
      selectIndex = 0;
    } else if (arg["title"] == "euro") {
      selectIndex = 1;
    } else if (arg["title"] == "inr") {
      selectIndex = 2;
    } else {
      selectIndex = 3;
    }

    Future.delayed(Duration.zero, () async {
      // Paypal Payment Method
      try {
        accessToken = await services.getAccessToken();
        log("accessToken: $accessToken");
      } catch (e) {
        throw Exception("exception: $e");
      }
    });
    /* onPaypal(onFinish);*/
    update();
    // TODO: implement onReady
    super.onReady();
  }

  /*onPaypal(Function? onFinish) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        if (request.url.contains(returnURL)) {
          final uri = Uri.parse(request.url);
          final payerID = uri.queryParameters['PayerID'];
          if (payerID != null) {
            services
                .executePayment(executeUrl, payerID,
                accessToken)
                .then((id) {
              onFinish!(id);
            });
          } else {
            Get.back();
          }
          Get.back();
        }
        if (request.url.contains(cancelURL)) {
          Get.back();
        }
        return NavigationDecision.navigate;
      }));
  }*/

  // payments list
  paymentDialog(data) {
    Get.generalDialog(
      barrierDismissible: false,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: PaymentList(data: data!),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  //currency list
  currencyListDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: CurrencyList(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
