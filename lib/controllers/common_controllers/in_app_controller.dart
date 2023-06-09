import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:probot/config.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../consumable_store.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart'; // import for SKPaymentQueueDelegateWrapper
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

final bool kAutoConsume = Platform.isIOS || true;

const String kConsumableId = 'basic_plan_9';
const String kUpgradeId = 'advance_plan_19';
const String kSilverSubscriptionId = 'standard_plan_29';
const String topUp15 = 'top_up_balance_15';
const String topUp35 = 'top_up_35';
const String topUp65 = 'top_up_65';
const String basicSubPlan9 = 'basic_sub_plan_9';
const String advanceSubPlan19 = 'advance_sub_plan_19';
const String advanceSubPlan29 = 'limited_sub_plan299';
const List<String> _kProductIds = <String>[
  kConsumableId,
  kUpgradeId,
  kSilverSubscriptionId,
  topUp15,
  topUp35,
  topUp65,
  basicSubPlan9,
  advanceSubPlan19,
  advanceSubPlan29
];

class InAppController extends GetxController {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<String> notFoundIds = <String>[];
  List<ProductDetails> products = <ProductDetails>[];
  List<PurchaseDetails> purchases = <PurchaseDetails>[];
  List<String> consumablesVal = <String>[];
  bool isAvailables = false;
  bool purchasePending = false;
  bool loading = true;
  String? queryProductError;

  @override
  void onReady() {
    // TODO: implement onReady
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          log("LOSY purchaseDetailsList : #$purchaseDetailsList");
          listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          subscription.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    log("subscription : ${subscription.isPaused}");
    super.onReady();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await inAppPurchase.isAvailable();
    log("isAvailable : $isAvailable");
    if (!isAvailable) {
      isAvailables = isAvailable;
      products = <ProductDetails>[];
      purchases = <PurchaseDetails>[];
      notFoundIds = <String>[];
      consumablesVal = <String>[];
      purchasePending = false;
      loading = false;
      update();
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    /* if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }*/

    final ProductDetailsResponse productDetailResponse =
    await inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      queryProductError = productDetailResponse.error!.message;
      log("========================================= ::$queryProductError");
      isAvailables = isAvailable;
      products = productDetailResponse.productDetails;
      purchases = <PurchaseDetails>[];
      notFoundIds = productDetailResponse.notFoundIDs;
      consumablesVal = <String>[];
      purchasePending = false;
      loading = false;
      update();
      return;
    }

    log("productDetailResponse : #${productDetailResponse.productDetails}");
    log("productDetailResponse : #${productDetailResponse.productDetails.isEmpty}");
    log("productDetailResponse : #{purchases");
    if (productDetailResponse.productDetails.isEmpty) {
      queryProductError = null;
      isAvailables = isAvailable;
      products = productDetailResponse.productDetails;
      purchases = <PurchaseDetails>[];
      notFoundIds = productDetailResponse.notFoundIDs;
      consumablesVal = <String>[];
      purchasePending = false;
      loading = false;
      update();
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    isAvailables = isAvailable;
    products = productDetailResponse.productDetails;
    notFoundIds = productDetailResponse.notFoundIDs;
    consumablesVal = consumables;
    purchasePending = false;
    loading = false;
    update();

    log("consumablesVal : $consumablesVal");
  }

  void showPendingUI() {
    purchasePending = true;
    update();
  }

  void handleError(IAPError error) {
    purchasePending = false;
    update();
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails,
      {subscribe, isSubscribe = true, amount = 0}) async {
    if (isSubscribe == true) {
      if (purchaseDetails.productID == kConsumableId) {
        await ConsumableStore.save(purchaseDetails.purchaseID!);
        final List<String> consumables = await ConsumableStore.load();
        purchasePending = false;
        consumablesVal = consumables;
        update();
      } else if (purchaseDetails.productID == kUpgradeId) {
        await ConsumableStore.save(purchaseDetails.purchaseID!);
        final List<String> consumables = await ConsumableStore.load();
        purchasePending = false;
        consumablesVal = consumables;
        update();
      } else {
        purchases.add(purchaseDetails);
        purchasePending = false;
        update();
      }
    } else {
      if (purchaseDetails.productID == topUp15) {
        await ConsumableStore.save(purchaseDetails.purchaseID!);
        final List<String> consumables = await ConsumableStore.load();
        purchasePending = false;
        consumablesVal = consumables;
        update();
      } else if (purchaseDetails.productID == topUp35) {
        await ConsumableStore.save(purchaseDetails.purchaseID!);
        final List<String> consumables = await ConsumableStore.load();
        purchasePending = false;
        consumablesVal = consumables;
        update();
      } else if (purchaseDetails.productID == topUp65) {
        purchases.add(purchaseDetails);
        purchasePending = false;
        update();
      }
    }

    showSuccessPayment(subscribe, true,
        isSubscribe: isSubscribe, amount: amount);
    purchases.add(purchaseDetails);

    log("purchases : ${purchases.length}");
    log("purchases : $purchases");
    purchasePending = false;
  }

  showSuccessPayment(subscribeModel, isBack,
      {isSubscribe = true, amount}) async {
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
                if (isSubscribe) {
                  firebaseCtrl.subscribePlan(
                      subscribeModel: subscribeModel,
                      paymentMethod: "inApp",
                      isBack: isBack);
                } else {
                  firebaseCtrl.subscribePlan(
                      amountBalance: amount,
                      isSubscribe: isSubscribe,
                      paymentMethod: "inApp",
                      isBack: isBack);
                }
              },
              crossOnTap: () =>
              isBack ? Get.back() : appCtrl.splashDataCheck());
        });
  }

  Future<void> listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    log("purchaseDetailsList : $purchaseDetailsList");
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      log("purchaseDetails.status : ${purchaseDetails.status}");
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            handleInvalidPurchase(purchaseDetails);
            return;
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}