import 'package:probot/screens/bottom_screens/dashboard/layouts/bottom_bar.dart';

import '../../../config.dart';
import '../../../widgets/directionality_rtl.dart';

class Dashboard extends StatelessWidget {
  final dashboardCtrl = Get.put(DashboardController());

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
          backgroundColor: appCtrl.appTheme.white,
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
