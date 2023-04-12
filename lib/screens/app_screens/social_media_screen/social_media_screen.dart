import 'package:probot/controllers/app_pages_controllers/social_media_controller.dart';

import '../../../config.dart';
import 'layouts/social_media_list_layout.dart';

class SocialMediaScreen extends StatelessWidget {
  final socialMediaCtrl = Get.put(SocialMediaController());

  SocialMediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return DirectionalityRtl(
          child: Scaffold(
              appBar: AppAppBarCommon(
                  title: appFonts.socialMedia, leadingOnTap: () => Get.back()),
              body: Column(children: [
                Text(appFonts.chooseOneOfThese,
                    style: AppCss.outfitSemiBold16
                        .textColor(appCtrl.appTheme.primary)),
                const VSpace(Sizes.s15),
                SizedBox(
                        child: Column(
                            children: socialMediaCtrl.socialMediaLists
                                .asMap()
                                .entries
                                .map((e) => SocialMediaListLayout(
                                    data: e.value, index: e.key))
                                .toList()))
                    .paddingSymmetric(
                        vertical: Insets.i20, horizontal: Insets.i15)
                    .authBoxExtension()
              ]).paddingSymmetric(
                  vertical: Insets.i30, horizontal: Insets.i20)));
    });
  }
}
