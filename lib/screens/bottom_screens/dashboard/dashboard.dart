import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../config.dart';
import 'layouts/tab_common.dart';

class Dashboard extends StatelessWidget {
  final dashboardCtrl = Get.put(DashboardController());

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return DirectionalityRtl(
          child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder:
                      (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                    return snapshot.data == ConnectivityResult.none
                        ? NoInternet(connectionStatus: snapshot.data)
                        : Scaffold(
                            backgroundColor: appCtrl.appTheme.bg1,
                            body: dashboardCtrl.widgetOptions
                                .elementAt(dashboardCtrl.selectedIndex),
                            bottomNavigationBar: Container(
                                height: Sizes.s50,
                                margin:const EdgeInsets.only(bottom: Insets.i5),
                                decoration: BoxDecoration(
                                    color: appCtrl.appTheme.boxBg,
                                    boxShadow:  [
                                      BoxShadow(
                                          color:appCtrl.appTheme.borderColor,
                                          blurRadius: 20,
                                          offset:const Offset(4, -1))
                                    ],
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(AppRadius.r10),
                                        topRight:
                                            Radius.circular(AppRadius.r10))),
                                width: double.maxFinite,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TabCommon(
                                          title: "home",
                                          sImage: eSvgAssets.homeColor,
                                          usImage: eSvgAssets.home,
                                          index: 0),
                                      if (appCtrl
                                          .firebaseConfigModel!.isChatShow!)
                                        TabCommon(
                                            title: "chat",
                                            sImage: eSvgAssets.chatColor,
                                            usImage: eSvgAssets.chat,
                                            index: 1),
                                      if (appCtrl.firebaseConfigModel!
                                          .isImageGeneratorShow!)
                                        TabCommon(
                                            title: "image",
                                            sImage: eSvgAssets.galleryColor,
                                            usImage: eSvgAssets.gallery,
                                            index: 2),
                                      if (appCtrl.firebaseConfigModel!
                                          .isVoiceEnable!)
                                        TabCommon(
                                            title: "voice",
                                            sImage: eSvgAssets.micColor,
                                            usImage: eSvgAssets.micNav,
                                            index: 3),
                                      if (appCtrl.firebaseConfigModel!
                                          .isCameraEnable!)
                                      TabCommon(
                                          title: "camera",
                                          sImage: eSvgAssets.cameraColor,
                                          usImage: eSvgAssets.cameraNav,
                                          index: 4)
                                    ]))
                            );
                  })));
    });
  }
}
