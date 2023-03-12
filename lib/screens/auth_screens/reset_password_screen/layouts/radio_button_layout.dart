import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class RadioButtonLayout extends StatelessWidget {
  final SelectLanguageModel? data;
  final int? index, selectIndex;
  final GestureTapCallback? onTap;
  const RadioButtonLayout(
      {Key? key, this.data, this.selectIndex, this.index, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Sizes.s20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Image.asset(data!.image!, height: Sizes.s40, width: Sizes.s40)
              .decorated(boxShadow: [
            BoxShadow(
                color: appCtrl.appTheme.lightText.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 3)
          ], shape: BoxShape.circle),
          const HSpace(Sizes.s12),
          Text(data!.title!,
              style: AppCss.outfitMedium18.textColor(appCtrl.appTheme.txt))
        ]),
        Stack(alignment: Alignment.center, children: [
          Icon(CupertinoIcons.circle,
              color: selectIndex == index
                  ? appCtrl.appTheme.primary
                  : appCtrl.appTheme.lightText),
          if (selectIndex == index)
            Icon(Icons.circle, color: appCtrl.appTheme.primary, size: 9)
        ])
      ]).inkWell(onTap: onTap),
      if (index != 5) const VSpace(Sizes.s20),
      if (index != 5) const Divider(height: 1, thickness: 1)
    ]);
  }
}
