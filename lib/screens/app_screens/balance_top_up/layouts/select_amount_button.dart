import '../../../../config.dart';

class SelectAmountButton extends StatelessWidget {
  final int? selectIndex,index;
  const SelectAmountButton({Key? key,this.index,this.selectIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(Insets.i3),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: selectIndex == index
                    ? appCtrl.appTheme.primary
                    : appCtrl.appTheme.lightText)),
        child: Icon(Icons.circle,
            size: Sizes.s10,
            color: selectIndex == index
                ? appCtrl.appTheme.primary
                : appCtrl.appTheme.trans));
  }
}
