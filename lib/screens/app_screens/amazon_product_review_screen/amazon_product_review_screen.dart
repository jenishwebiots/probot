import '../../../config.dart';

class AmazonProductReviewScreen extends StatelessWidget {
  const AmazonProductReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.bg1,
      resizeToAvoidBottomInset: false,
      appBar: AppAppBarCommon(
          title: appFonts.amazonProductReview,
          isBalanceShow: false,
          leadingOnTap: () => Get.back()),
      body: Column(
        children: [
           Column(
             children: [
               textCommon.outfitSemiBoldPrimary16(text: appFonts.giveAnOverview),
               const VSpace(Sizes.s10),
             ],
           )
        ],
      ).paddingSymmetric(horizontal: Insets.i20,vertical: Insets.i30),
    );
  }
}
