import '../../../../../config.dart';
import 'bottom_bar_bubble_layout.dart';
import 'bottom_bar_item.dart';
import 'icon_list_widget.dart';

class BottomBarBubble extends StatefulWidget {
  const BottomBarBubble({
    Key? key,
    required this.items,
    this.selectedIndex = 0,
    this.height = 71,
    this.bubbleSize = 10,
    this.color = Colors.green,
    this.onSelect,
  }) : super(key: key);

  final int selectedIndex;
  final double height;
  final double bubbleSize;
  final Color color;
  final ValueChanged<int>? onSelect;
  final List<BottomBarItem> items;

  @override
  State<BottomBarBubble> createState() => _BottomBarBubbleState();
}

class _BottomBarBubbleState extends State<BottomBarBubble>
    with SingleTickerProviderStateMixin {
  var dashboardCtrl = Get.find<DashboardController>();

  @override
  void initState() {
    dashboardCtrl.onInitCall(this);
    _handleTextChangeFromOutside();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant BottomBarBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleTextChangeFromOutside();
  }

  void _handleTextChangeFromOutside() {
    dashboardCtrl.handleTextChangeFromOutside(widget.items);
    //_onChangeIndex(widget.selectedIndex);
  }

  @override
  void dispose() {
    dashboardCtrl.animationController.dispose();
    super.dispose();
  }

  double _getLeftPosition() {
    double width = MediaQuery.of(context).size.width;

    final iconWidth = width / dashboardCtrl.iconCount;

    return (dashboardCtrl.selectedIndex * iconWidth) + (iconWidth / 2);
  }

  @override
  Widget build(BuildContext context) {
    return BottomBarBubbleLayout(
        selectedIndex: widget.selectedIndex,
        color: widget.color,
        height: widget.height,
        bubbleSize: widget.bubbleSize,
        getLeftPosition: _getLeftPosition(),
        iconsWidget: _iconsWidget(),
        items: widget.items);
  }

  List<Widget> _iconsWidget() {
    List<Widget> iconWidgets = [];

    widget.items.asMap().forEach((index, item) {
      iconWidgets.add(IconListWidget(
          onTap: () => _onChangeIndex(index),
          index: index,
          iconsKey: dashboardCtrl.iconsKey,
          color: widget.color,
          selectedIndex: dashboardCtrl.selectedIndex,
          item: item));
    });

    return iconWidgets;
  }

  //on change bottom
  Future _onChangeIndex(int index) async {
    await dashboardCtrl.onChangeIndex(index);
    widget.onSelect?.call(dashboardCtrl.selectedIndex);
  }
}
