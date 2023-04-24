import '../../../config.dart';

class PasswordGeneratorScreen extends StatelessWidget {
  final passwordCtrl = Get.put(PasswordController());

  PasswordGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordController>(builder: (_) {
      return Scaffold(
          appBar: AppAppBarCommon(
              title: appFonts.passwordGenerator,
              leadingOnTap: () => Get.back()),
          body: SingleChildScrollView(
              child: Column(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textCommon.outfitSemiBoldPrimary16(text: appFonts.getTheStrong),
              const VSpace(Sizes.s15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                textCommon.outfitSemiBoldTxt14(text: appFonts.passwordLength),
                const VSpace(Sizes.s70),
                const PasswordLengthSlider(),
                const VSpace(Sizes.s20),
                textCommon.outfitSemiBoldTxt14(text: appFonts.passwordType),
                const VSpace(Sizes.s10),
                ...passwordCtrl.passwordTypeLists
                    .asMap()
                    .entries
                    .map((e) => PasswordRadioButtonLayout(
                        data: e.value,
                        index: e.key,
                        selectIndex: passwordCtrl.selectedIndex,
                        onTap: () => passwordCtrl.onChangePasswordType(e.key)))
                    .toList(),
                const VSpace(Sizes.s10),
                textCommon.outfitSemiBoldTxt14(text: appFonts.passwordStrength),
                const VSpace(Sizes.s20),
                const PasswordStrengthSlider(),
                const VSpace(Sizes.s10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: passwordCtrl.passwordStrengthLists
                        .asMap()
                        .entries
                        .map((e) => Text(e.value,
                            style: AppCss.outfitMedium14.textColor(
                                passwordCtrl.strengthValue >= e.key
                                    ? appCtrl.appTheme.primary
                                    : appCtrl.appTheme.lightText)))
                        .toList())
              ])
                  .paddingSymmetric(
                      vertical: Insets.i20, horizontal: Insets.i15)
                  .authBoxExtension(),
              const VSpace(Sizes.s30),
              if (passwordCtrl.isPasswordGenerated != true)
                ButtonCommon(
                    title: appFonts.buildSomeMagic,
                    onTap: () => passwordCtrl.onPasswordGenerate()),
              if (passwordCtrl.isPasswordGenerated == true)
                Column(children: [
                  InputLayout(
                      color: appCtrl.appTheme.white,
                      title: appFonts.generatedPassword,
                      isMax: false,
                      controller: passwordCtrl.passwordController),
                  const VSpace(Sizes.s20),
                  ButtonCommon(
                      title: appFonts.endPasswordGenerator,
                      onTap: () => passwordCtrl.endPasswordGeneratorDialog())
                ])
            ])
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20)));
    });
  }
}
