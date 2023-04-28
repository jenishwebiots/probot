import 'dart:developer';

import 'package:probot/config.dart';

class QuickAdvisorController extends GetxController {
  List quickAdvisorLists = [];
  List favoriteDataList = [];
  int? selectedIndex;
  int? selectedIndexRemove;
  bool isFav = true;
  dynamic favDex;
  dynamic favRemoveDex;

  onTapAddFavorite(index) {
    selectedIndex = index;
    favoriteDataList.add(quickAdvisorLists[index]);
    quickAdvisorLists.removeWhere((element)=> element == quickAdvisorLists[index]);
    selectedIndex = null;
    appCtrl.storage.write("fav", index);
    /*quickAdvisorLists.remove(favoriteDataList[index]);*/
    update();
  }

  onTapRemoveFavorite(index) {
    selectedIndexRemove = index;
    quickAdvisorLists.add(favoriteDataList[index]);
    favoriteDataList.remove(favoriteDataList[index]);
    appCtrl.storage.write("removeFav", index);
    update();
  }

  @override
  void onReady() {
    List<dynamic> list = appCtrl.storage.read("quickList")?? [];
    List<dynamic> favList = appCtrl.storage.read("favList") ?? [];
    dynamic fav = appCtrl.storage.read("fav") ?? 0;
    dynamic removeFavorite = appCtrl.storage.read("removeFav") ?? 0;
    favDex = fav;
    favRemoveDex = removeFavorite;
    log("=============================$fav");
    log("==============++++++===============$favRemoveDex");
    log("LIST $list");
    log("FAV LIST $favList");


    if(list.isEmpty) {
      log("LIST EMPTY $list");
      appCtrl.storage.write("quickList", appArray.quickAdvisor);
    }
    if (favList.isEmpty) {
      log("FAV LIST EMPTY $favList");
      appCtrl.storage.write("favList", favoriteDataList);
    }
    quickAdvisorLists =  appCtrl.storage.read("quickList");
    favoriteDataList = appCtrl.storage.read("favList");

    update();
    // TODO: implement onReady
    super.onReady();
  }
}
