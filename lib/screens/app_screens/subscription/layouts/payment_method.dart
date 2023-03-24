import 'package:probot/screens/app_screens/subscription/layouts/payment_method_list.dart';
import '../../../../config.dart';

class PaymentList extends StatelessWidget {
 final String? data;
 final SubscribeModel? subscribe;
  const PaymentList({Key? key,this.data,this.subscribe}) : super(key: key);

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
            CommonPopUpTitle(title: appFonts.payMoneyFrom),
            DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1,
                dashLength: 3,
                dashColor: appCtrl.appTheme.txt.withOpacity(.1)),
            const VSpace(Sizes.s25),
            ...appArray.paymentMethodList
                .asMap()
                .entries
                .map((e) => PaymentMethodList(index: e.key,data: e.value,))
                .toList(),
            const VSpace(Sizes.s35),
            Row(children: [
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
              Expanded(child: ButtonCommon(onTap: () {
                if (subscribeCtrl.selectIndexPayment == 0) {
                     subscribeCtrl.onPaypalPayment(amount: data!,subscribe: subscribe);
                  Get.back();
                } else {
                  subscribeCtrl.stripePayment(amount: data!, currency: 'INR', subscribe:subscribe );
                  Get.back();
                }

              }, title: appFonts.apply))
            ]).marginSymmetric(horizontal: Insets.i15),
            const VSpace(Sizes.s25)
          ]
        )
            .decorated(
            color: appCtrl.appTheme.white,
            borderRadius: BorderRadius.circular(AppRadius.r10))
            .marginSymmetric(horizontal: Insets.i20)
      );
    });
  }


}
