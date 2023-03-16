import '../../../../config.dart';

class ChatTextBox extends StatelessWidget {
  const ChatTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(
      builder: (chatCtrl) {
        return TextFieldCommon(
          controller: chatCtrl.chatController,
          hintText: appFonts.typeHere.tr,
          fillColor: appCtrl.isTheme
              ? appCtrl.appTheme.bg
              : appCtrl.appTheme.white,
          minLines: 1,
          prefixIcon: SvgPicture.asset(eSvgAssets.smile)
              .paddingOnly(left: Insets.i18, right: Insets.i10),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(eSvgAssets.mic),
              const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.send)
                  .paddingAll(Insets.i6)
                  .decorated(
                  color: appCtrl.appTheme.primary,
                  borderRadius:
                  BorderRadius.circular(AppRadius.r6)).inkWell(onTap: ()=> chatCtrl.proccessChat()),
              const HSpace(Sizes.s8),
            ],
          ),
        ).paddingOnly(
            bottom: Insets.i20, left: Insets.i20, right: Insets.i20);
      }
    );
  }
}
