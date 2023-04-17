import '../../config.dart';

class NearbyPointsController extends GetxController {
  SfRangeValues values = const SfRangeValues(05, 15);
  bool isNearbyPointsGenerated = false;
  TextEditingController nearbyController = TextEditingController();

  onNearbyPointGenerate() {
    isNearbyPointsGenerated = true;
    update();
  }

  endNearbyGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endTraveling,
              subTitle: appFonts.areYouSureEndTravelling,
              endOnTap: () {
                isNearbyPointsGenerated = false;
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
