import '../../../config.dart';
import 'layouts/generated_mail_layout.dart';

class EmailGeneratorScreen extends StatelessWidget {
  final emailGeneratorCtrl = Get.put(EmailGeneratorController());

  EmailGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailGeneratorController>(builder: (_) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.emailWriter, leadingOnTap: () => Get.back()),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: emailGeneratorCtrl.isMailGenerated == true
                    ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appFonts.weCreatedLetter,
                                style: AppCss.outfitSemiBold16
                                    .textColor(appCtrl.appTheme.primary)),
                            const VSpace(Sizes.s15),
                            InputLayout(
                                color: appCtrl.appTheme.white,
                                title: appFonts.generatedMail,
                                isMax: false,
                                responseText: emailGeneratorCtrl.response
                            )
                          ]),
                      const VSpace(Sizes.s30),
                      ButtonCommon(title: appFonts.endEmailWriter, onTap: ()=> emailGeneratorCtrl.endEmailGeneratorDialog())
                    ]).paddingSymmetric(
                    vertical: Insets.i30, horizontal: Insets.i20)
                    : const GeneratedMailLayout(),
              ),
              if(emailGeneratorCtrl.isLoader == true) const LoaderLayout()
            ],
          ));
    });
  }
}
