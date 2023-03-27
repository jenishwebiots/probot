import 'dart:developer';

import 'package:probot/screens/app_screens/subscription/layouts/payment_method_list.dart';
import '../../../../config.dart';

class PaymentList extends StatelessWidget {
  final String? data;
  final SubscribeModel? subscribe;

  const PaymentList({Key? key, this.data, this.subscribe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscribeCtrl) {
      return Material(
          color: appCtrl.appTheme.trans,
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                CommonPopUpTitle(title: appFonts.payMoneyFrom.tr),
                DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashLength: 3,
                    dashColor: appCtrl.appTheme.txt.withOpacity(.1)),
                const VSpace(Sizes.s25),
                (appCtrl.firebaseConfigModel!.isPaypal! == false &&
                        appCtrl.firebaseConfigModel!.isRazorPay! == false &&
                        appCtrl.firebaseConfigModel!.isStripe! == false)
                    ? Text(
                        appFonts.noPaymentMethod.tr,
                        style: AppCss.outfitSemiBold16
                            .textColor(appCtrl.appTheme.error)
                      ).paddingSymmetric(horizontal: Insets.i20)
                    : Column(
                        children:
                            appArray.paymentMethodList.asMap().entries.map((e) {
                        log("paypal: ${e.value["title"]}");
                        return e.value["title"] == "payPal"
                            ? appCtrl.firebaseConfigModel!.isPaypal!
                                ? PaymentMethodList(index: e.key, data: e.value)
                                : Container()
                            : e.value["title"] == "razor"
                                ? appCtrl.firebaseConfigModel!.isRazorPay!
                                    ? PaymentMethodList(
                                        index: e.key, data: e.value)
                                    : Container()
                                : e.value["title"] == "stripe"
                                    ? appCtrl.firebaseConfigModel!.isStripe!
                                        ? PaymentMethodList(
                                            index: e.key, data: e.value)
                                        : Container()
                                    : Container();
                      }).toList()),
                const VSpace(Sizes.s35),
                    (appCtrl.firebaseConfigModel!.isPaypal! == false &&
                        appCtrl.firebaseConfigModel!.isRazorPay! == false &&
                        appCtrl.firebaseConfigModel!.isStripe! == false) ? Container() : Row(children: [
                  Expanded(
                      child: ButtonCommon(
                          onTap: () {},
                          title: appFonts.cancel,
                          isGradient: false,
                          style: AppCss.outfitMedium16
                              .textColor(appCtrl.appTheme.primary),
                          color: appCtrl.appTheme.trans,
                          borderColor: appCtrl.appTheme.primary)),
                  const HSpace(Sizes.s15),
                  Expanded(
                      child: ButtonCommon(
                          onTap: () {
                            if (subscribeCtrl.selectIndexPayment == 0) {
                              subscribeCtrl.onPaypalPayment(
                                  amount: data!, subscribe: subscribe);
                              Get.back();
                            } else if (subscribeCtrl.selectIndexPayment == 1) {
                              subscribeCtrl.stripePayment(
                                  amount: data!,
                                  currency: 'INR',
                                  subscribe: subscribe);
                              Get.back();
                            } else if (subscribeCtrl.selectIndexPayment == 2) {
                              subscribeCtrl.openSession(subscribe:subscribe);
                              Get.back();
                            }
                          },
                          title: appFonts.apply))
                ]).marginSymmetric(horizontal: Insets.i15) ,
                const VSpace(Sizes.s25)
              ])
              .decorated(
                  color: appCtrl.appTheme.white,
                  borderRadius: BorderRadius.circular(AppRadius.r10))
              .marginSymmetric(horizontal: Insets.i20));
    });
  }
}
