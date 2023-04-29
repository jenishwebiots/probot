import '../../../config.dart';
import '../../bottom_screens/home/layouts/quick_advisor_layout.dart';

class QuickAdvisorScreen extends StatelessWidget {
  final quickAdvisorCtrl = Get.put(QuickAdvisorController());

  QuickAdvisorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickAdvisorController>(builder: (quickAdvisorCtrl) {
      return DirectionalityRtl(
          child: Scaffold(
              appBar: AppAppBarCommon(
                  title: appFonts.quickAdvice, leadingOnTap: () => Get.back()),
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        quickAdvisorCtrl.favoriteDataList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(appFonts.favoriteQuickAdvisor,
                                            style: AppCss.outfitSemiBold16
                                                .textColor(
                                                    appCtrl.appTheme.txt))
                                        .paddingOnly(bottom: Insets.i15),
                                    GridView.builder(
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: quickAdvisorCtrl
                                            .favoriteDataList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 1,
                                                mainAxisSpacing: 15,
                                                mainAxisExtent: 105,
                                                crossAxisCount: 3),
                                        itemBuilder: (context, index) {
                                          return QuickAdvisorLayout(
                                              index: index,
                                              isFavorite: true,
                                              selectIndex: quickAdvisorCtrl
                                                  .selectedIndexRemove,
                                              data: quickAdvisorCtrl
                                                  .favoriteDataList[index],
                                              onTap: () => quickAdvisorCtrl
                                                  .onTapRemoveFavorite(index));
                                        })
                                  ]).paddingOnly(bottom: Insets.i30)
                            : Container(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appFonts.otherQuickAdvisor,
                                      style: AppCss.outfitSemiBold16
                                          .textColor(appCtrl.appTheme.txt))
                                  .paddingOnly(bottom: Insets.i15),
                              GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      quickAdvisorCtrl.quickAdvisorLists.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 1,
                                          mainAxisSpacing: 15,
                                          mainAxisExtent: 105,
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return QuickAdvisorLayout(
                                        index: index,
                                        isFavorite: false,
                                        selectIndex:
                                            quickAdvisorCtrl.selectedIndex,
                                        data: quickAdvisorCtrl
                                            .quickAdvisorLists[index],
                                        onTap: () => quickAdvisorCtrl
                                            .onTapAddFavorite(index));
                                  })
                            ])
                      ]).paddingAll(Insets.i20))));
    });
  }
}
