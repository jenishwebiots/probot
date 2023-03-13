import '../../../../../config.dart';
import 'bottom_bar_item.dart';
import 'bottom_clipper_layout.dart';
import 'bottom_widget.dart';
import 'icon_widget.dart';

class BottomBarBubbleIcon extends StatefulWidget {
  const BottomBarBubbleIcon({
    Key? key,
    required this.item,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final BottomBarItem item;
  final Color color;
  final bool isSelected;

  @override
  BottomBarBubbleIconState createState() => BottomBarBubbleIconState();
}

class BottomBarBubbleIconState extends State<BottomBarBubbleIcon>
    with SingleTickerProviderStateMixin {
  static const duration = Duration(milliseconds: 500);

  late AnimationController _animationController;
  late Tween<double> _colorTween;
  late Animation<double> _animation;
  bool _isSelect = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: duration);
    _colorTween = Tween(begin: 0, end: 1);
    _animation = _colorTween.animate(_animationController);
    if (widget.isSelected) {
      _isSelect = widget.isSelected;
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: appCtrl.appTheme.white,
          border: Border(
              top: BorderSide(color: appCtrl.appTheme.primary))),
      child: Column(children: [
        BottomWidget().indicator(widget.isSelected),
        Stack(children: [
          Positioned(bottom: 5, left: 0, right: 0, child: _labelWidget()),
          BottomWidget().iconWidget(
              child: IconWidget(
                  animation: _animation,
                  colorLayout: widget.color,
                  iconBuilder: widget.item.iconBuilder,
                  iconData: widget.item.iconData!),
              isNull: widget.item.label != null),
          BottomClipperLayout(
              isNull: widget.item.label != null,
              color: widget.color,
              animation: _animation,
              isSelect: _isSelect)
        ])
      ]),
    );
  }

  Widget _labelWidget() {
    if (widget.item.label != null) {
      return Text(widget.item.label!,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: AppCss.outfitRegular12.textColor(widget.isSelected
              ? appCtrl.appTheme.primary
              : appCtrl.appTheme.lightText));
    } else {
      return const SizedBox();
    }
  }

  void updateSelect(bool isSelect) {
    setState(() {
      _isSelect = isSelect;
    });

    if (!isSelect) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }
}
