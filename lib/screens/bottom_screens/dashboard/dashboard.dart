import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:probot/widgets/common_stream.dart';

import '../../../config.dart';

class Dashboard extends StatelessWidget {
  final dashboardCtrl = Get.put(DashboardController());

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return DirectionalityRtl(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            body: dashboardCtrl.widgetOptions
                .elementAt(dashboardCtrl.selectedIndex),
            bottomNavigationBar: dashboardCtrl.bottomList.isNotEmpty
                ? const BottomNavBarLayout()
                : Container(),
          ),
        ),
      );
    });
  }
}
