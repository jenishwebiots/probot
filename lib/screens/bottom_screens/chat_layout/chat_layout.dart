import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:probot/config.dart';
import 'package:screenshot/screenshot.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("SE : ${chatCtrl.selectedImage}");
    return GetBuilder<ChatLayoutController>(builder: (_) {
      return CommonStream(
        child: GetBuilder<AppController>(
          builder: (appCtrl) {
            return DirectionalityRtl(
              child: WillPopScope(
                onWillPop: () async {
                  chatCtrl.speechStopMethod();
                  chatCtrl.clearData();
                  return true;
                },
                child:  Screenshot(
                  controller: chatCtrl.screenshotController,
                  child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      key: chatCtrl.scaffoldKey,
                      drawer: const CommonDrawer(),
                      backgroundColor: appCtrl.appTheme.bg1,
                      appBar: const ChatScreenAppBar(),
                      body: InkWell(
                        onTap: () {
                          chatCtrl.isLongPress = false;
                          chatCtrl.selectedData = [];
                          chatCtrl.selectedIndex = [];
                          chatCtrl.update();
                        },
                        child: NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (OverscrollIndicatorNotification overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: Column(
                            children: [
                              const VSpace(Sizes.s10),
                              if (appCtrl.firebaseConfigModel!.isAddShow!)
                                appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!
                                    ? (chatCtrl.bannerAd != null &&
                                            chatCtrl.bannerAdIsLoaded)
                                        ? AdWidget(ad: chatCtrl.bannerAd!)
                                            .height(Sizes.s50)
                                            .paddingOnly(bottom: Insets.i10)
                                            .width(MediaQuery.of(context).size.width)
                                        : Container()
                                    : Container(
                                        alignment: Alignment.topCenter,
                                        child: chatCtrl.currentAd,
                                      )
                                        .paddingSymmetric(
                                          vertical: Insets.i10,
                                          horizontal: Insets.i20,
                                        )
                                        .width(MediaQuery.of(context).size.width),
                              Text("Today, ${DateFormat("hh:mm a").format(DateTime.now())}",
                                      style: AppCss.outfitMedium14
                                          .textColor(appCtrl.appTheme.txt))
                                  .marginOnly(top: Insets.i5),
                              const VSpace(Sizes.s13),
                              const Expanded(flex: 5, child: ChatList()),
                              Container(),
                              const Expanded(flex: 0, child: ChatTextBox()),
                            ],
                          ).backgroundImage(DecorationImage(
                              image: AssetImage(appCtrl.isTheme
                                  ? chatCtrl.selectedImage == null
                                      ? eImageAssets.dBg1
                                      : chatCtrl.selectedImage["darkImage"] ??
                                          eImageAssets.dBg1
                                  : chatCtrl.selectedImage == null
                                      ? eImageAssets.background1
                                      : chatCtrl.selectedImage["image"] ??
                                          eImageAssets.background1),
                              fit: BoxFit.fill)),
                        ),
                      )),
                ),
              ),
            );
          }
        ),
      );
    });
  }
}
