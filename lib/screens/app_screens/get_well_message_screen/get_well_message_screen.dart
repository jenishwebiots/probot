import '../../../config.dart';

class GetWellMessageScreen extends StatelessWidget {
  final getCtrl = Get.put(GetWellMessageController());

  GetWellMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetWellMessageController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.getWellMessage, leadingOnTap: () => Get.back()),
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: getCtrl.isWellMessageGenerated == true
                      ? Column(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textCommon.outfitSemiBoldPrimary16(
                                    text: appFonts.sendingBestWishes),
                                const VSpace(Sizes.s15),
                                InputLayout(
                                    hintText: "",
                                    title: appFonts.healthyWishes,
                                    color: appCtrl.appTheme.white,
                                    isMax: false,
                                    responseText: getCtrl.response)
                              ]),
                          const VSpace(Sizes.s20),
                          ButtonCommon(
                              title: appFonts.endWellWishes,
                              onTap: () => getCtrl.endWellWishes())
                        ]).paddingSymmetric(
                          vertical: Insets.i30, horizontal: Insets.i20)
                      : const GetWellMessageLayout()),
              if(getCtrl.isLoader == true) const LoaderLayout()
            ]
          ));
    });
  }
}
