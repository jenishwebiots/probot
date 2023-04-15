import '../../../config.dart';

class TravelScreen extends StatelessWidget {
  final travelCtrl = Get.put(TravelController());
  TravelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelController>(builder: (_) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        resizeToAvoidBottomInset: false,
        appBar: AppAppBarCommon(title: appFonts.travelHangout),
        body: Column(
          children: [
                   textCommon.outfitSemiBoldPrimary16(text: appFonts.exploreNearby),
                   Column(
                     children: travelCtrl.travelList.asMap().entries.map((e) => SocialMediaListLayout(
                         data: e.value,
                         index: e.key,
                         totalLength: travelCtrl.travelList.length -1,
                         onTap: ()=> travelCtrl.onGoPage(e.value))).toList(),
                   ).paddingSymmetric(vertical: Insets.i20,horizontal: Insets.i15).authBoxExtension()
          ],
        ).paddingSymmetric(vertical: Insets.i30,horizontal: Insets.i20),
      );
    });
  }
}
