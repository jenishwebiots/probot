import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../config.dart';
import 'layouts/bottom_layout.dart';
import 'layouts/drawer_list_common.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeCtrl) {
      log("ISCHAT : ${appCtrl.firebaseConfigModel!.isChatHistory!}");
      return Drawer(
          width: Sizes.s223,
          backgroundColor: appCtrl.appTheme.boxBg,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Insets.i20),
                  bottomRight: Radius.circular(Insets.i20))),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(children: [
              CachedNetworkImage(
                  imageUrl: appCtrl.firebaseConfigModel!.drawerLogo.toString(),
                  height: Sizes.s40,
                  width: Sizes.s40,
                  fit: BoxFit.fill,
                  imageBuilder: (context, imageProvider) => SizedBox(
                      height: Sizes.s40,
                      width: Sizes.s40,
                      child: Column(children: [
                        Image.network(
                            appCtrl.firebaseConfigModel!.drawerLogo.toString(),
                            height: Sizes.s40,
                            width: Sizes.s40,
                            fit: BoxFit.fill)
                      ])),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                      eImageAssets.proBot,
                      height: Sizes.s40,
                      width: Sizes.s40,
                      fit: BoxFit.fill)),
              DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1,
                      dashLength: 3,
                      dashColor: appCtrl.appTheme.txt.withOpacity(.2))
                  .marginSymmetric(horizontal: Insets.i20),

              ...homeCtrl.drawerList.asMap().entries.map((e) {
                log("guest: ${appCtrl.isGuestLogin}");
                return e.value["title"] == "chatBot"
                    ? appCtrl.firebaseConfigModel!.isChatShow!
                        ? DrawerListCommon(data: e.value, index: e.key)
                        : Container()
                    : e.value["title"] == "option2"
                        ? appCtrl.firebaseConfigModel!.isImageGeneratorShow!
                            ? DrawerListCommon(data: e.value, index: e.key)
                            : Container()
                        : e.value["title"] == "option3"
                            ? appCtrl.firebaseConfigModel!.isImageGeneratorShow!
                                ? DrawerListCommon(data: e.value, index: e.key)
                                : Container()
                            : DrawerListCommon(data: e.value, index: e.key);
              }).toList()
            ]).paddingSymmetric(vertical: Insets.i30),
            const BottomLayout()
          ]));
    });
  }
}
