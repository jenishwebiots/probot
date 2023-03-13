import '../../../../../config.dart';
import 'bottom_bar_bubble_icon.dart';
import 'bottom_bar_item.dart';

class IconListWidget extends StatelessWidget {
  final int? index,selectedIndex;
  final GestureTapCallback? onTap;
  final List<GlobalKey<BottomBarBubbleIconState>>? iconsKey;
  final BottomBarItem? item;
  final Color? color;
  const IconListWidget({Key? key,this.index,this.onTap,this.iconsKey,this.selectedIndex,this.item,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: InkWell(
        onTap: onTap,
        child: BottomBarBubbleIcon(
          key: iconsKey![index!],
          isSelected: selectedIndex == index,
          item: item!,
          color: color!,
        ),
      ),
    );
  }
}
