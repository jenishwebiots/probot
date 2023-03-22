import '../../../../config.dart';

class SenderWidthText extends StatelessWidget {
  final String? text;
  final int? index;

  const SenderWidthText({Key? key, this.text, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Container(
        width: 250,
        padding: const EdgeInsets.symmetric(
            horizontal: Insets.i10, vertical: Insets.i12),
        decoration: BoxDecoration(
            color: appCtrl.appTheme.boxBg,
            borderRadius: BorderRadius.circular(AppRadius.r6)),
        child: Text(
          text!,
          overflow: TextOverflow.clip,
          style: AppCss.outfitMedium14
              .textColor(appCtrl.appTheme.txt)
              .textHeight(1.2),
        ),
      ).inkWell(onTap: () {
        if (chatCtrl.isLongPress) {
          if (!chatCtrl.selectedIndex.contains(index)) {
            chatCtrl.selectedIndex.add(index);
            chatCtrl.selectedData.add(chatCtrl.selectedMessages[index!]);
            chatCtrl.update();
          }else{
            if (chatCtrl.selectedIndex.contains(index)) {
              chatCtrl.selectedIndex.remove(index);
              chatCtrl.selectedData.remove(chatCtrl.selectedMessages[index!]);
              chatCtrl.update();
            }
          }
        } else {
          if (chatCtrl.selectedIndex.contains(index)) {
            chatCtrl.selectedIndex.remove(index);
            chatCtrl.selectedData.remove(chatCtrl.selectedMessages[index!]);
            chatCtrl.update();
          }
        }
      });
    });
  }
}
