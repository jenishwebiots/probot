import '../../config.dart';

class NearbyPointsController extends GetxController {
  SfRangeValues values = const SfRangeValues(30, 40);
  bool nearbyPointsGenerated = false;

  onNearbyPointGenerate () {
    nearbyPointsGenerated = true;
    update();
  }

  endCaptionGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endTraveling,
              subTitle: appFonts.areYouSureEndTravelling,
              endOnTap: () {
                nearbyPointsGenerated = false;
                Get.back();
                update();
              });
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }

}