import '../../../../config.dart';
import 'limit_over_layout.dart';

class ChatTextBox extends StatelessWidget {
  const ChatTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return GetBuilder<AppController>(
        builder: (appCtrl) {
          return Column(
            children: [
              if(appCtrl.envConfig["chatTextCount"] != 0)
              Column(
                children: [
                  Text(appFonts.thereAreAwardLeft(appCtrl.envConfig["chatTextCount"].toString()).tr,
                      style: AppCss.outfitSemiBold14
                          .textColor(appCtrl.appTheme.lightText)),
                  const VSpace(Sizes.s10),
                ],
              ),
              if(appCtrl.envConfig["chatTextCount"] == 0)
                 LimitOverLayout(onTap: () => chatCtrl.showRewardedAd()),
              if(appCtrl.envConfig["chatTextCount"] != 0)
              TextFieldCommon(
                controller: chatCtrl.chatController,
                hintText: appFonts.typeHere.tr,
                focusNode: chatCtrl.focusNode,
                fillColor:
                    appCtrl.isTheme ? appCtrl.appTheme.bg : appCtrl.appTheme.white,
                minLines: 1,
                prefixIcon: SvgPicture.asset(eSvgAssets.smile)
                    .paddingOnly(left: Insets.i18, right: Insets.i10),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onLongPress: () {
                          chatCtrl.speechToText();
                        },
                        onLongPressEnd: (val) {
                          chatCtrl.isListening.value = false;
                          chatCtrl.speechStopMethod();
                          chatCtrl.update();
                        },
                        child: SvgPicture.asset(
                          eSvgAssets.mic,
                          colorFilter: ColorFilter.mode(
                              chatCtrl.isListening.value
                                  ? appCtrl.appTheme.primary
                                  : appCtrl.appTheme.lightText,
                              BlendMode.srcIn),
                        )),
                    const HSpace(Sizes.s12),
                    SvgPicture.asset(eSvgAssets.send)
                        .paddingAll(Insets.i6)
                        .decorated(
                            color: appCtrl.appTheme.primary,
                            borderRadius: BorderRadius.circular(AppRadius.r6))
                        .inkWell(onTap: () => chatCtrl.processChat()),
                    const HSpace(Sizes.s8),
                  ],
                ),
              ).paddingOnly(bottom: Insets.i20, left: Insets.i20, right: Insets.i20),
            ],
          );
        }
      );
    });
  }
}
