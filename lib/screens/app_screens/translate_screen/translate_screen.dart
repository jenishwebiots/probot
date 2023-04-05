import '../../../config.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.bg1,
      appBar: AppAppBarCommon(title: appFonts.translateAnything,leadingOnTap: ()=> Get.back()),
      body: Column(
        children: [
                 Stack(
                   alignment: Alignment.bottomRight,
                   children: [
                     SizedBox(
                       child: TextFieldCommon(hintText: appFonts.writeAnything,minLines: 8,
                         maxLines: null,
                         keyboardType: TextInputType.multiline,fillColor: appCtrl.appTheme.white)
                     ).authBoxExtension(),
                     Text(appFonts.max500,style: AppCss.outfitMedium12.textColor(appCtrl.appTheme.lightText)).paddingAll(Insets.i10)
                   ],
                 ),
          SizedBox(
            height: 40,
            child: Column(
              children: [
                IntrinsicWidth(

                  child: SizedBox(
                      width: Sizes.s18, child: VerticalDivider(thickness: 1, width: 2,color: appCtrl.appTheme.primary)),
                ),
                const SizedBox(height: 7, width: 7)
                    .decorated(color: appCtrl.appTheme.primary, shape: BoxShape.circle),
              ],
            ),
          )
        ],
      ).paddingAll(Insets.i20),
    );
  }
}
