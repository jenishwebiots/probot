

import '../../../config.dart';

class Subscription extends StatelessWidget {
  final subscribeCtrl = Get.put(SubscriptionController());

  Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.subscriptionPlan,
              actionIcon: eSvgAssets.currency,isAction: true,
              leadingOnTap: () => Get.back(),actionOnTap: ()=>subscribeCtrl.currencyListDialog(),),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ...subscribeCtrl.subscriptionLists
                    .asMap()
                    .entries
                    .map((e) => SubscriptionList(subscribeModel: e.value,onTap: ()=> subscribeCtrl.paymentDialog(e.value.price.toString()))
                .subscribeExtension()
                    .marginOnly(bottom: Insets.i20).inkWell(onTap: () {}))
                    .toList()
              ],
            ).marginSymmetric(vertical: Insets.i25, horizontal: Insets.i20),
          ));
    });
  }
}
