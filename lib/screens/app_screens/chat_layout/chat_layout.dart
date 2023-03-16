import 'package:intl/intl.dart';
import 'package:probot/config.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (_) {
      return chatCtrl.data != null
          ? DirectionalityRtl(
            child: Scaffold(
                backgroundColor: appCtrl.appTheme.bg1,
                appBar: const ChatScreenAppBar(),
                body: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: Column(
                    children: [
                      Text("Today, ${DateFormat("hh:mm a").format(DateTime.now())}",style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),),
                      const VSpace(Sizes.s13),

                      const Expanded(
                        child: ChatList(),
                      ),
                      Container(),
                      const ChatTextBox()
                    ],
                  ).backgroundImage(DecorationImage(
                      image: AssetImage(
                          chatCtrl.selectedImage ?? eImageAssets.background2),
                      fit: BoxFit.fill)).marginOnly(top: Insets.i15),
                )),
          )
          : Container();
    });
  }
}
