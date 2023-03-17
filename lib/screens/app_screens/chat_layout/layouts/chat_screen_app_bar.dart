


import '../../../../config.dart';

class ChatScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return AppBar(
          toolbarHeight: 70,
          titleSpacing: 0,

          leading: Hero(
              tag: "chat${chatCtrl.index}",
              child: SvgPicture.asset(eSvgAssets.leftArrow,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                          appCtrl.appTheme.sameWhite, BlendMode.srcIn))
                  .inkWell(onTap: () => Get.back())),
          automaticallyImplyLeading: false,
          backgroundColor: appCtrl.appTheme.primary,
          actions: [SvgPicture.asset(eSvgAssets.search), const MoreOption()],
          title: Row(children: [
            Container(
              height: Sizes.s50,
              width: Sizes.s50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(chatCtrl.data["image"]))),
            ),
            const HSpace(Sizes.s10),
            Text(chatCtrl.data["title"].toString().tr,
                style: AppCss.outfitExtraBold22
                    .textColor(appCtrl.appTheme.sameWhite))
          ]));
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
