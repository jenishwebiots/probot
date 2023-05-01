import '../../../config.dart';

class CvMakerScreen extends StatelessWidget {
  final cvCtrl = Get.put(CvMakerController());
  CvMakerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CvMakerController>(
      builder: (_) {
        return DirectionalityRtl(
          child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            appBar: AppAppBarCommon(title: appFonts.cvMaker,leadingOnTap: ()=> Get.back()),
            body: cvCtrl.isCvGenerate == false ? const CvMakerLayout()
             : SingleChildScrollView(
               child: Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCommon.outfitSemiBoldPrimary16(
                            text: appFonts.createACvThat),
                        const VSpace(Sizes.s15),
                        InputLayout(
                            hintText: "",
                            title: appFonts.professionalCv,
                            color: appCtrl.appTheme.white,
                            isMax: false,
                            text: cvCtrl.response,
                            responseText: cvCtrl.response
                            )
                      ]),
                  const VSpace(Sizes.s20),
                  ButtonCommon(
                      title: appFonts.endMyCv,
                      onTap: () => cvCtrl.endCvMaker())
                ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20),
             )
          ),
        );
      }
    );
  }
}
