import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:probot/controllers/app_pages_controllers/top_up_controller.dart';
import 'package:probot/screens/app_screens/subscription/layouts/payment_method_list.dart';
import '../../../../config.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../../../../controllers/common_controllers/in_app_controller.dart';

class TopUpPaymentList extends StatelessWidget {
  final String? data;

  const TopUpPaymentList({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpController>(builder: (topUpCtrl) {
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
                        appCtrl.firebaseConfigModel!.isStripe! == false &&
                        appCtrl.firebaseConfigModel!.isInApp! == false)
                    ? Text(appFonts.noPaymentMethod.tr,
                            style: AppCss.outfitSemiBold16
                                .textColor(appCtrl.appTheme.error))
                        .paddingSymmetric(horizontal: Insets.i20)
                    : Column(
                        children:
                            appArray.paymentMethodList.asMap().entries.map((e) {
                        return e.value["title"] == "payPal"
                            ? appCtrl.firebaseConfigModel!.isPaypal!
                                ? PaymentMethodList(
                                    index: e.key,
                                    data: e.value,
                                    selectIndexPayment:
                                        topUpCtrl.selectIndexPayment,
                                    onTap: () {
                                      topUpCtrl.selectIndexPayment = e.key;
                                      topUpCtrl.update();
                                    })
                                : Container()
                            : e.value["title"] == "razor"
                                ? appCtrl.firebaseConfigModel!.isRazorPay!
                                    ? PaymentMethodList(
                                        index: e.key,
                                        data: e.value,
                                        selectIndexPayment:
                                            topUpCtrl.selectIndexPayment,
                                        onTap: () {
                                          topUpCtrl.selectIndexPayment = e.key;
                                          topUpCtrl.update();
                                        })
                                    : Container()
                                : e.value["title"] == "stripe"
                                    ? appCtrl.firebaseConfigModel!.isStripe!
                                        ? PaymentMethodList(
                                            index: e.key,
                                            data: e.value,
                                            selectIndexPayment:
                                                topUpCtrl.selectIndexPayment,
                                            onTap: () {
                                              topUpCtrl.selectIndexPayment =
                                                  e.key;
                                              topUpCtrl.update();
                                            })
                                        : Container()
                                    : e.value["title"] == "inApp"
                                        ? topUpCtrl.selectedPlan != 3
                                            ? appCtrl.firebaseConfigModel!
                                                    .isInApp!
                                                ? PaymentMethodList(
                                                    index: e.key,
                                                    data: e.value,
                                                    selectIndexPayment:
                                                        topUpCtrl
                                                            .selectIndexPayment,
                                                    onTap: () {
                                                      topUpCtrl
                                                              .selectIndexPayment =
                                                          e.key;
                                                      topUpCtrl.update();
                                                    })
                                                : Container()
                                            : Container()
                                        : Container();
                      }).toList()),
                const VSpace(Sizes.s35),
                (appCtrl.firebaseConfigModel!.isPaypal! == false &&
                        appCtrl.firebaseConfigModel!.isRazorPay! == false &&
                        appCtrl.firebaseConfigModel!.isStripe! == false &&
                        appCtrl.firebaseConfigModel!.isInApp! == false)
                    ? Container()
                    : Row(children: [
                        Expanded(
                            child: ButtonCommon(
                                onTap: () => Get.back(),
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
                                  if (topUpCtrl.selectIndexPayment == 0) {
                                    topUpCtrl.onPaypalPayment(
                                      amount: data!,
                                    );
                                    Get.back();
                                  } else if (topUpCtrl.selectIndexPayment ==
                                      1) {
                                    topUpCtrl.stripePayment(
                                      amount: data!,
                                      currency: 'INR',
                                    );
                                    Get.back();
                                  } else if (topUpCtrl.selectIndexPayment ==
                                      2) {
                                    topUpCtrl.openSession(amount: data);
                                    Get.back();
                                  } else if (topUpCtrl.selectIndexPayment ==
                                      3) {
                                    late PurchaseParam purchaseParam;
                                    final Map<String, PurchaseDetails>
                                        purchases = Map<String,
                                                PurchaseDetails>.fromEntries(
                                            inAppCtrl.purchases.map(
                                                (PurchaseDetails purchase) {
                                      if (purchase.pendingCompletePurchase) {
                                        inAppCtrl.inAppPurchase
                                            .completePurchase(purchase);
                                      }

                                      return MapEntry<String, PurchaseDetails>(
                                          purchase.productID, purchase);
                                    }));
                                    if (Platform.isAndroid) {
                                      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                                      // verify the latest status of you your subscription by using server side receipt validation
                                      // and update the UI accordingly. The subscription purchase status shown
                                      // inside the app may not be accurate.
                                      final GooglePlayPurchaseDetails?
                                          oldSubscription = _getOldSubscription(
                                              data == "15"
                                                  ? inAppCtrl.products[3]
                                                  : data == "35"
                                                      ? inAppCtrl.products[4]
                                                      : inAppCtrl.products[5],
                                              purchases);

                                      purchaseParam = GooglePlayPurchaseParam(
                                          productDetails: data == "15"
                                              ? inAppCtrl.products[3]
                                              : data == "35"
                                                  ? inAppCtrl.products[4]
                                                  : inAppCtrl.products[5],
                                          changeSubscriptionParam:
                                              (oldSubscription != null)
                                                  ? ChangeSubscriptionParam(
                                                      oldPurchaseDetails:
                                                          oldSubscription,
                                                    )
                                                  : null);
                                    } else {
                                      purchaseParam = PurchaseParam(
                                          productDetails: data == "15"
                                              ? inAppCtrl.products[3]
                                              : data == "35"
                                                  ? inAppCtrl.products[4]
                                                  : inAppCtrl.products[5]);
                                    }



                                    inAppCtrl.inAppPurchase.buyNonConsumable(
                                      purchaseParam: purchaseParam,);
                                    final Stream<List<PurchaseDetails>>
                                        purchaseUpdated =
                                        inAppCtrl.inAppPurchase.purchaseStream;
                                    inAppCtrl.subscription = purchaseUpdated
                                        .listen((List<PurchaseDetails>
                                            purchaseDetailsList) async {
                                      for (final PurchaseDetails purchaseDetails
                                          in purchaseDetailsList) {
                                        if (purchaseDetails.status ==
                                            PurchaseStatus.pending) {
                                          inAppCtrl.showPendingUI();
                                        } else {
                                          if (purchaseDetails.status ==
                                              PurchaseStatus.error) {
                                            inAppCtrl.handleError(
                                                purchaseDetails.error!);
                                          } else if (purchaseDetails.status ==
                                                  PurchaseStatus.purchased ||
                                              purchaseDetails.status ==
                                                  PurchaseStatus.restored) {
                                            final bool valid =
                                                await inAppCtrl.verifyPurchase(
                                                    purchaseDetails);
                                            if (valid) {
                                              inAppCtrl.deliverProduct(
                                                  purchaseDetails,
                                                  amount: data,
                                                  isSubscribe: false);
                                            } else {
                                              inAppCtrl.handleInvalidPurchase(
                                                  purchaseDetails);
                                              return;
                                            }
                                          }
                                        }
                                      }
                                    }, onDone: () {
                                      inAppCtrl.subscription.cancel();
                                    }, onError: (Object error) {
                                      // handle error here.
                                    });
                                  }
                                },
                                title: appFonts.apply))
                      ]).marginSymmetric(horizontal: Insets.i15),
                const VSpace(Sizes.s25)
              ])
              .decorated(
                  color: appCtrl.appTheme.white,
                  borderRadius: BorderRadius.circular(AppRadius.r10))
              .marginSymmetric(horizontal: Insets.i20));
    });
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;

    if (productDetails.id == topUp15 &&
        purchases[topUp15] != null) {
      oldSubscription = purchases[topUp15]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == topUp35 &&
        purchases[topUp35] != null) {
      oldSubscription = purchases[topUp35]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == topUp65 &&
        purchases[topUp65] != null) {
      oldSubscription =
          purchases[topUp65]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }
}
