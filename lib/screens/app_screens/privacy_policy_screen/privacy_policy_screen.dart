import 'package:probot/controllers/app_pages_controllers/privacy_policy_controller.dart';

import '../../../config.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final privacyPolicyCtrl = Get.put(PrivacyPolicyController());

  PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyController>(builder: (_) {
      return Scaffold(
          appBar: AppAppBarCommon(title: appFonts.privacyTerm),
          body: Column(children: [
            SizedBox(
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        unselectedWidgetColor: appCtrl.appTheme.txt,
                        indicatorColor: appCtrl.appTheme.txt),
                    child: ExpansionTile(
                        iconColor: appCtrl.appTheme.txt,
                        // Text
                        title: Row(children: [
                          SvgPicture.asset(eSvgAssets.arrow),
                          const HSpace(Sizes.s10),
                          Text(appFonts.description.toString().tr,
                              style: AppCss.outfitSemiBold16
                                  .textColor(appCtrl.appTheme.txt))
                        ]),
                        children: [
                          SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                const DottedLines(),
                                const VSpace(Sizes.s15),
                                Text(appFonts.thisPrivacyPolicy,
                                    style: AppCss.outfitMedium14
                                        .textColor(appCtrl.appTheme.lightText)
                                        .textHeight(1.3))
                              ]).padding(
                                  horizontal: Insets.i15, bottom: Insets.i20))
                        ]))).authBoxExtension()
          ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i25));
    });
  }
}
