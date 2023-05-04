import 'dart:convert';
import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;
import 'package:probot/screens/app_screens/balance_top_up/layouts/top_up_payment_list.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../config.dart';

import '../../screens/app_screens/subscription/layouts/paypal_payment.dart';
import '../../screens/app_screens/subscription/layouts/paypal_services.dart';

class TopUpController extends GetxController {
  List<SubscribeModel> subscriptionLists = [];
  List currencyList = [];
  int selectedPrice =
      int.parse(appArray.topUpBalanceOption[0]["price"].toString());
  int selectIndex = 0;
  int selectedPlan = 0;
  int selectIndexPayment = 0;
  SubscribeModel? subscribeModel;
  List paymentMethods = [];
  Map<String, dynamic>? paymentIntentData;
  bool isLoading = false;
  TextEditingController txtAmount = TextEditingController();
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
  final client = http.Client();
  Razorpay razorpay = Razorpay();

  // item name, price and quantity
  String itemName = 'PROBOT SUBSCRIPTION';
  int quantity = 1;
  Function? onFinish;

  // Stripe Payment Method
  Future<void> stripePayment(
      {required String amount,
      required String currency,
      SubscribeModel? subscribe}) async {
    try {
      isLoading = true;
      paymentIntentData = await createPaymentIntent(amount, currency);

      log("paymentIntentData: $paymentIntentData");
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

        displayPaymentSheet(subscribe, "stripe",amount);
        update();
      }
    } catch (e) {
      throw Exception("$e");
    }
    update();
  }

  // Stripe Error handler
  displayPaymentSheet(subscribe, paymentMethod,amount) async {
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
                b1OnTap: () async {
                  final firebaseCtrl =
                      Get.isRegistered<SubscriptionFirebaseController>()
                          ? Get.find<SubscriptionFirebaseController>()
                          : Get.put(SubscriptionFirebaseController());
                  firebaseCtrl.subscribePlan(
                      subscribeModel: subscribe, paymentMethod: paymentMethod,isSubscribe: false,amountBalance: amount,isBack: true);
                },
                crossOnTap: () async {
                  final firebaseCtrl =
                  Get.isRegistered<SubscriptionFirebaseController>()
                      ? Get.find<SubscriptionFirebaseController>()
                      : Get.put(SubscriptionFirebaseController());
                  firebaseCtrl.subscribePlan(
                      subscribeModel: subscribe, paymentMethod: paymentMethod,isSubscribe: false,amountBalance: amount,isBack: true);
                },);
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
        'payment_method_types[]': 'card',
      };
      log("STRIPE KEY : ${appCtrl.firebaseConfigModel!.stripeKey}");
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${appCtrl.firebaseConfigModel!.stripeKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      log("jsonDecode(response.body) : ${jsonDecode(response.body)}");
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

  onPaypalPayment({required String amount, SubscribeModel? subscribe,}) async {
    try {
      log("amount : $amount");
      final transactions = getOrderParams(amount);
      log("transactions: $transactions");
      final res = await services.createPaypalPayment(transactions, accessToken);
      log("res : #$res");
      checkoutUrl = res["approvalUrl"];
      executeUrl = res["executeUrl"];
      update();
      log("RES: $res");
      log("checkoutUrl: $checkoutUrl");
      log("executeUrl: $executeUrl");
      Get.to(() => PaypalPayment(subscribe: subscribe,url: checkoutUrl,amount: int.parse(amount),isSubscribe: false,exUrl: executeUrl,));
    } catch (e) {
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

  initPayment() {
    /// Test payment gateway
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);

    ///
  }

  // Razorpay error response
  void handlePaymentErrorResponse() {
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

  // Razorpay success response
  handlePaymentSuccessResponse({SubscribeModel? subscribeModel}) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialogCommon(
              image: eImageAssets.paymentSuccess,
              bText1: appFonts.okay,
              title: appFonts.paymentSuccess,
              subtext: appFonts.congratulation,
              b1OnTap: () {
                final firebaseCtrl =
                    Get.isRegistered<SubscriptionFirebaseController>()
                        ? Get.find<SubscriptionFirebaseController>()
                        : Get.put(SubscriptionFirebaseController());
                firebaseCtrl.subscribePlan(
                    subscribeModel: subscribeModel, paymentMethod: "razor",isSubscribe: false,amountBalance: txtAmount,isBack: true);
              },
              crossOnTap: () {
                final firebaseCtrl =
                Get.isRegistered<SubscriptionFirebaseController>()
                    ? Get.find<SubscriptionFirebaseController>()
                    : Get.put(SubscriptionFirebaseController());
                firebaseCtrl.subscribePlan(
                    subscribeModel: subscribeModel, paymentMethod: "razor",isSubscribe: false,amountBalance: txtAmount,isBack: true);
              },);
        });
  }

  @override
  void onReady() async {
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
    initPayment();
    // initPayment();
    /* onPaypal(onFinish);*/
    update();
    // TODO: implement onReady
    super.onReady();
  }


  openSession({amount}) {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_yw7RdKNen8WdHE',
      'amount': int.parse(amount),
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': "test@gmail.com"},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.open(options);
  }

  // payments list
  paymentDialog(data) {
    log("appCtrl.isGuestLogin : ${appCtrl.isGuestLogin}");
    if (appCtrl.isGuestLogin) {
      Get.offAllNamed(routeName.signInScreen);
    } else {
      Get.generalDialog(
        barrierDismissible: false,
        pageBuilder: (context, anim1, anim2) {
          return Align(
            alignment: Alignment.center,
            child: TopUpPaymentList(data: data!),
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

  //currency list
  currencyListDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return  Align(
          alignment: Alignment.center,
          child: GetBuilder<SubscriptionController>(
            builder: (subCtrl) {
              return const CurrencyList();
            }
          ),
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
