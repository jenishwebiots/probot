import 'package:probot/screens/bottom_screens/dashboard/layouts/tab_layout.dart';

import '../../../../../config.dart';
import 'dashboard_widget.dart';

class BottomNavBarLayout extends StatelessWidget {
  const BottomNavBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return dashboardCtrl.bottomList.isNotEmpty
          ? DefaultTabController(
              length: dashboardCtrl.bottomList.length,
              child: DashboardWidget().tabBorderLayout(
                  child: Container(
                      height: Sizes.s58,
                      decoration: BoxDecoration(
                          color: appCtrl.appTheme.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(53, 193, 255, 0.08),
                                blurRadius: 20,
                                offset: Offset(4, -1))
                          ],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppRadius.r10),
                              topRight: Radius.circular(AppRadius.r10))),
                      child: TabBar(
                          controller: dashboardCtrl.con,
                          physics: const NeverScrollableScrollPhysics(),
                          isScrollable: false,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          overlayColor:
                              MaterialStateProperty.all(appCtrl.appTheme.white),
                          onTap: (val) => dashboardCtrl.onBottomTap(val),
                          indicator: DashboardWidget().materialIndicator(),
                          tabs: dashboardCtrl.bottomList.isNotEmpty
                              ? dashboardCtrl.bottomList
                                  .asMap()
                                  .entries
                                  .map((e) {
                                  return BlogTabLayout(
                                      index: e.key, data: e.value);
                                }).toList()
                              : []))),
            )
          : Container();
    });
  }
}
