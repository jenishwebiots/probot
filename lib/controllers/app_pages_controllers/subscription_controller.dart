

import 'package:probot/models/subscribe_model.dart';
import 'package:probot/screens/app_screens/subscription/layouts/currency_list.dart';

import '../../config.dart';

class SubscriptionController extends GetxController {
  List<SubscribeModel> subscriptionLists = [];
  List currencyList = [];

  int selectIndex =0;

  @override
  void onReady() {
    subscriptionLists = appArray.subscriptionPlan.map((e) => SubscribeModel.fromJson(e)).toList();
    currencyList = appArray.currencyList;
    dynamic arg = appCtrl.storage.read("currency");
    if(arg["title"] == "dollar"){
      selectIndex = 0;
    }else if(arg["title"] == "euro"){
      selectIndex =1;
    }else if(arg["title"] == "inr"){
      selectIndex =2;
    }else{
      selectIndex =3;
    }
    update();
    // TODO: implement onReady
    super.onReady();
  }




  //currency list
  currencyListDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: CurrencyList(),
        );
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
}