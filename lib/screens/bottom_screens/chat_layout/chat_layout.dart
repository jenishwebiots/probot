import 'package:probot/config.dart';
import 'package:probot/controllers/bottom_controllers/chat_layout_controller.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (_) {
      return chatCtrl.data != null
          ? Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppBar(
                toolbarHeight: 70,
                titleSpacing: 0,
                leading: Hero(
                  tag: "chat${chatCtrl.index}",
                  child: SvgPicture.asset(eSvgAssets.leftArrow,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              appCtrl.appTheme.white, BlendMode.srcIn))
                      .inkWell(onTap: () => Get.back()),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: appCtrl.appTheme.primary,
                title: Row(
                  children: [
                    Container(
                      height: 50,
                      width: Sizes.s50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                            chatCtrl.data["image"],
                          ))),
                    ),
                    const HSpace(Sizes.s10),
                    Text(chatCtrl.data["title"].toString().tr,
                        style: AppCss.outfitExtraBold22
                            .textColor(appCtrl.appTheme.white)),
                  ],
                ),
              ),
              body: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    controller: chatCtrl.scrollController,
                    itemCount: chatCtrl.chatList.length,
                    itemBuilder: (context, index) {
                      if (index == chatCtrl.chatList.length) {
                        return Container(
                          height: 70,
                        );
                      }
                      return Column(
                        children: [
                          Text(chatCtrl.chatList[index].dateTime!)
                              .marginSymmetric(vertical: Insets.i15),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: chatCtrl.chatList[index].chat!.length,
                            itemBuilder: (context, i) {
                              if (chatCtrl
                                  .chatList[index].chat![i].isReceiver!) {
                                return  ClipPath(
                                  clipper: ArcClipper(),
                                  child: Container(
                                    height: 70,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                );
                              } else {
                                return Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Insets.i10,
                                              vertical: Insets.i12),
                                          decoration: BoxDecoration(
                                              color: appCtrl.appTheme.primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppRadius.r6)),
                                          child: Text(
                                            chatCtrl.chatList[index].chat![i]
                                                .message!,
                                            style: AppCss.outfitMedium14
                                                .textColor(
                                                    appCtrl.appTheme.white),
                                          ),
                                        ),
                                        const VSpace(Sizes.s3),
                                        Text(
                                          chatCtrl
                                              .chatList[index].chat![i].time!,
                                          style: AppCss.outfitMedium12
                                              .textColor(
                                                  appCtrl.appTheme.lightText),
                                        )
                                      ],
                                    ).marginSymmetric(
                                        horizontal: Insets.i20,
                                        vertical: Insets.i5));
                              }
                            },
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          : Container();
    });
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height) ;
    path.lineTo(size.width * .03, size.height);
    
    path.quadraticBezierTo(size.width * .2, size.height * .5, size.width * .03, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}