import '../../../config.dart';




class Dashboard extends StatelessWidget {
  final dashboardCtrl = Get.put(DashboardController());

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          body: dashboardCtrl.widgetOptions
              .elementAt(dashboardCtrl.selectedIndex),
          bottomNavigationBar: dashboardCtrl.bottomList.isNotEmpty
              ? const BottomNavBarLayout()
              : Container(),
        ),
      );
    });
  }
}
