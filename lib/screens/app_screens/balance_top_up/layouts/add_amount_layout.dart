import '../../../../config.dart';

class AddAmountLayout extends StatelessWidget {
  const AddAmountLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<TopUpController>(
      builder: (topUpCtrl) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(appFonts.addAmount.tr,
              style: AppCss.outfitSemiBold16.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s8),
          TextFieldCommon(
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val!.isEmpty) {
                  topUpCtrl.selectedPrice = 0;
                }
                topUpCtrl.update();
                return null;
              },
              onChanged: (val) {
                if (val.isNotEmpty) {
                  topUpCtrl.selectedPrice = int.parse(val.toString());
                } else {
                  topUpCtrl.selectedPrice = 0;
                }
                topUpCtrl.update();
              },
              controller: topUpCtrl.txtAmount,
              hintText: "\$30")
        ]).paddingSymmetric(vertical: Insets.i15);
      }
    );
  }
}
