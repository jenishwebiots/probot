import 'dart:convert';
import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:probot/screens/app_screens/subscription/layouts/currency_list.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../screens/app_screens/subscription/layouts/payment_method.dart';
import '../../screens/app_screens/subscription/layouts/payment_method_list.dart';
import '../../widgets/alert_dialog_common.dart';

class SubscriptionController extends GetxController {
  List<SubscribeModel> subscriptionLists = [];
  List currencyList = [];

  int selectIndex =0;
  int selectIndexPayment =0;
  List paymentMethods = [];
  Map<String, dynamic>? paymentIntentData;
  bool isLoading = false;


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
          context: Get.context!, builder: (context) {
        return AlertDialogCommon(
            image: eImageAssets.paymentSuccess,
            bText1: appFonts.okay,
            title: appFonts.paymentSuccess,
            subtext: appFonts.congratulation,
            b1OnTap: ()=> Get.offAllNamed(routeName.subscriptionPlan),
            crossOnTap: ()=> Get.offAllNamed(routeName.subscriptionPlan)
        );
      });
    } on Exception {
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




  @override
  void onReady() {
    paymentMethods = appArray.paymentMethodList;
    subscriptionLists = appArray.subscriptionPlan.map((e) => SubscribeModel.fromJson(e)).toList();
    currencyList = appArray.currencyList;
    dynamic arg = appCtrl.storage.read("currency") ?? appArray.currencyList[0];
    if(arg["title"] == "dollar"){
      selectIndex = 0;
    }else if(arg["title"] == "euro"){
      selectIndex =1;
    }else if(arg["title"] == "inr"){
      selectIndex =2;
    }else{
      selectIndex =3;
    }
    update();
    // TODO: implement onReady
    super.onReady();
  }



  // payments list
  paymentDialog(data) {
    Get.generalDialog(
      barrierDismissible: false,
      pageBuilder: (context, anim1, anim2) {
        return  Align(
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