import 'dart:developer';
import 'package:probot/common/app_array.dart';

import '../../config.dart';
import '../../models/translate_model.dart';
import '../../screens/app_screens/translate_screen/layouts/country_picker_layout.dart';
import '../../screens/app_screens/translate_screen/layouts/language_services.dart';

class TranslateController extends GetxController {
  TextEditingController transController = TextEditingController();
  TextEditingController transCompleteController = TextEditingController();
  bool isTranslated = false;
  var selectItem;
  var toSelectItem;
  var onFromSelect;
  var onToSelect;
  int value = 0;
  int toValue = 0;
  List <String>translateLanguagesList = [];
  final FixedExtentScrollController? fromScrollController = FixedExtentScrollController();
  final FixedExtentScrollController? toScrollController = FixedExtentScrollController();
  final ScrollController? thumbScrollController = ScrollController(initialScrollOffset: 50.0);


  @override
  void onReady() {
    translateLanguagesList = AppArray.translateLanguages;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  endTranslationDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: Material(
                color: appCtrl.appTheme.trans,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CommonPopUpTitle(title: appFonts.endTranslation.tr),
                  DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1,
                      dashLength: 3,
                      dashColor: appCtrl.appTheme.txt.withOpacity(.1)),
                  const VSpace(Sizes.s20),
                  Image.asset(eImageAssets.notification, height: Sizes.s180),
                  const VSpace(Sizes.s15),
                  Text(appFonts.areYouSure.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.txt)
                          .textHeight(1.2)),
                  Row(children: [
                    Expanded(
                        child: ButtonCommon(
                            title: appFonts.cancel,
                            isGradient: false,
                            style: AppCss.outfitMedium16
                                .textColor(appCtrl.appTheme.primary),
                            color: appCtrl.appTheme.trans,
                            borderColor: appCtrl.appTheme.primary,
                            onTap: () => Get.back())),
                    const HSpace(Sizes.s15),
                    Expanded(
                        child: ButtonCommon(
                      title: appFonts.end,
                      onTap: () {
                        isTranslated = false;
                        update();
                        Get.back();
                      },
                    ))
                  ]).paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i20)
                ])
                    .decorated(
                        color: appCtrl.appTheme.white,
                        borderRadius: BorderRadius.circular(AppRadius.r10))
                    .marginSymmetric(horizontal: Insets.i20)));
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // from languages list
  onFromLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<TranslateController>(
          builder: (translateCtrl) {
            return LanguagePickerLayout(
              list: translateLanguagesList,
              title: appFonts.selectLanguage,
              index: value,
              scrollController: translateCtrl.fromScrollController,
              thumbScrollController: thumbScrollController,
              suggestionsCallbacks: (value) {
                return StateService.getSuggestions(value,translateLanguagesList);
              },
              onSuggestionSelected: (i) {
                int index =
                AppArray.translateLanguages.indexWhere((element) {
                  return element == i;
                });
                translateCtrl.fromScrollController!.jumpToItem(index);
                log("suggestion: $i");
                log("index: $index");
                update();
                translateCtrl.update();
              },
              onSelectedItemChanged: (i) {
                value = i;
                selectItem = translateLanguagesList[i];
                log("SELECT ITEM: $selectItem");
                update();
                translateCtrl.update();
              },
              selectOnTap: () {
                onFromSelect = selectItem;
                Get.back();
                translateCtrl.update();
              },
            );
          }
        );
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppRadius.r10),
            topLeft: Radius.circular(AppRadius.r10))
      ),
    );
  }

  // to language list
  onToLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<TranslateController>(
          builder: (translateCtrl) {
            return LanguagePickerLayout(
              title: appFonts.selectLanguage,
              list: translateLanguagesList,
              index: toValue,
              scrollController: translateCtrl.toScrollController,
              suggestionsCallbacks: (value) {
                return StateService.getSuggestions(value,translateLanguagesList);
              },
              onSelectedItemChanged: (i) {
                toValue = i;
                toSelectItem = translateLanguagesList[i];
                log("SELECT ITEM: $toSelectItem");
                update();
                translateCtrl.update();
              },
              onSuggestionSelected: (i) {
                int index =
                AppArray.translateLanguages.indexWhere((element) {
                  return element == i;
                });
                translateCtrl.toScrollController!.jumpToItem(index);
                log("suggestion: $i");
                log("index: $index");
                update();
                translateCtrl.update();
              },
              selectOnTap: () {
                onToSelect = toSelectItem;
                Get.back();
                translateCtrl.update();
              },
            );
          }
        );
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppRadius.r10),
            topLeft: Radius.circular(AppRadius.r10)),
      ),
    );
  }
}
