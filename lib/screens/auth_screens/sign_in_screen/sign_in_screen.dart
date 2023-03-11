import 'package:probot/widgets/button_common.dart';
import 'package:probot/widgets/dotted_line.dart';
import '../../../config.dart';
import '../../../widgets/text_field_common.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const VSpace(Sizes.s20),
           Column(
             children: [
               Image.asset(eImageAssets.proBot,
                   height: Sizes.s38, width: Sizes.s130),
               const VSpace(Sizes.s25),
               SizedBox(
                 width: double.infinity,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(appFonts.welcomeBack,
                         style: AppCss.outfitSemiBold22
                             .textColor(appCtrl.appTheme.txt)),
                     const VSpace(Sizes.s10),
                     Text(appFonts.fillTheBelow,
                         style: AppCss.outfitMedium16
                             .textColor(appCtrl.appTheme.lightText)),
                     const DottedLines()
                         .paddingOnly(top: Insets.i20, bottom: Insets.i15),
                     Text(appFonts.email,
                         style: AppCss.outfitMedium16
                             .textColor(appCtrl.appTheme.txt)),
                     const VSpace(Sizes.s10),
                     TextFieldCommon(hintText: appFonts.enterEmail),
                     const VSpace(Sizes.s15),
                     Text(appFonts.password,
                         style: AppCss.outfitMedium16
                             .textColor(appCtrl.appTheme.txt)),
                     const VSpace(Sizes.s10),
                     TextFieldCommon(hintText: appFonts.enterPassword),
                     const VSpace(Sizes.s10),
                     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                       Text(appFonts.resetPassword,
                           style: AppCss.outfitMedium14
                               .textColor(appCtrl.appTheme.primary))
                     ]),
                     const VSpace(Sizes.s40),
                     ButtonCommon(title: appFonts.signIn),
                     const VSpace(Sizes.s15),
                     Column(
                         children: [
                           Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 RichText(
                                     text: TextSpan(
                                         text: appFonts.dontHaveAnAccount,
                                         style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.lightText),
                                         children:  [
                                           TextSpan(text: appFonts.signUp, style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt))

                                         ]
                                     )
                                 )
                               ]
                           ),
                           SizedBox(
                               width: Sizes.s90,
                               child: Row(children: [
                                 const Expanded(child: Divider(height: 1, thickness: 2)),
                                 Text(appFonts.or,
                                     style: AppCss.outfitMedium14
                                         .textColor(appCtrl.appTheme.lightText))
                                     .paddingSymmetric(horizontal: Insets.i5),
                                 const Expanded(child: Divider(height: 1, thickness: 2))
                               ])).paddingSymmetric(vertical: Insets.i20)
                         ]
                     ),
                     ButtonCommon(title: appFonts.continueWithGoogle,icon: Image.asset(eImageAssets.google,height: 20,width: 20)),
                   ],
                 ).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i25),
               ).decorated(
                   color: appCtrl.appTheme.white,
                   boxShadow: [
                     BoxShadow(
                         color: appCtrl.appTheme.primary.withOpacity(0.1),
                         spreadRadius: 1,
                         blurRadius: 4)
                   ],
                   borderRadius:
                   const BorderRadius.all(Radius.circular(AppRadius.r10)),
                   border: Border.all(
                       color: appCtrl.appTheme.primary.withOpacity(0.1), width: 2))
             ]
           ),
            Text(appFonts.simplyUseThis,textAlign: TextAlign.center,style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.lightText).textHeight(1.3))
          ],
        ).paddingSymmetric(horizontal: Insets.i20,vertical: Insets.i15),
      ),
    );
  }
}
