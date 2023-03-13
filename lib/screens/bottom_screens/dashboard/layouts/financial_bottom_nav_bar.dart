import '../../../../../config.dart';
import 'bottom_bar_bubble.dart';
import 'bottom_bar_item.dart';

class FinancialBottomNavBar extends StatelessWidget {
  const FinancialBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (dashboardCtrl) {
        return BottomBarBubble(
          selectedIndex: dashboardCtrl.selectedIndex,
          items: dashboardCtrl.bottomList
              .asMap()
              .entries
              .map((e) => BottomBarItem(
            iconData: SvgPicture.asset(e.value["icon"],
                color: dashboardCtrl.selectedIndex == e.key
                    ? appCtrl.appTheme.primary
                    : appCtrl.appTheme.lightText),
            label: e.value["title"].toString().tr,
          ))
              .toList(),
          color: appCtrl.appTheme.primary,
          onSelect: (index) => dashboardCtrl.onBottomTap(index),
        );
      }
    );
  }
}
