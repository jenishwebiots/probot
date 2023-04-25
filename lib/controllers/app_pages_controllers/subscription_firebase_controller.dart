import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:probot/config.dart';

class SubscriptionFirebaseController extends GetxController {
  //subscribe plan
  subscribePlan(
      {SubscribeModel? subscribeModel, paymentMethod, isSubscribe = true,amountBalance}) async {
    DateTime now = DateTime.now();
    DateTime? expiryDate;
    if(isSubscribe == true) {
      if (subscribeModel!.type == "weekly") {
        expiryDate = DateTime(now.year, now.month, now.day + 7);
      } else if (subscribeModel.type == "monthly") {
        expiryDate = DateTime(now.year, now.month + 1, now.day);
      } else {
        expiryDate = DateTime(now.year + 1, now.month, now.day);
      }
    }else{
      int balance = appCtrl.envConfig["balance"];
      balance = (amountBalance + balance);
      appCtrl.envConfig["balance"] = balance;
    }
    log("EXPIER : $expiryDate");
    log("subscribeModel : #$subscribeModel");
    String? userName;
    userName = appCtrl.storage.read("userName");
    int id = DateTime.now().millisecondsSinceEpoch;
    log("appCtrl.envConfig: ${appCtrl.envConfig}");

    await FirebaseFirestore.instance
        .collection("userSubscribe")
        .where("email", isEqualTo: appCtrl.storage.read("userName"))
        .limit(1)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection("userSubscribe")
            .doc(id.toString())
            .set({
          "email": userName,
          "userId": FirebaseAuth.instance.currentUser!.uid,
          "subscriptionType": subscribeModel!.type,
          "isExpiry": false,
          "isSubscribe": isSubscribe,
          "createdDate": DateTime.now().millisecondsSinceEpoch,
          "expiryDate": expiryDate,
          "price": subscribeModel.price!,
          "balance": appCtrl.envConfig["balance"],
          "paymentMethod": paymentMethod,
        }).then((value) {
          Get.back();
          Get.back();
        });
      } else {
        await FirebaseFirestore.instance
            .collection("userSubscribe")
            .doc(value.docs[0].id)
            .update({
          "email": userName,
          "userId": FirebaseAuth.instance.currentUser!.uid,
          "createdDate": DateTime.now().millisecondsSinceEpoch,
          "expiryDate": expiryDate,
          "price": isSubscribe ? 0 : subscribeModel!.price!,
          "isSubscribe":isSubscribe,
          "balance": appCtrl.envConfig["balance"],
          "paymentMethod": paymentMethod,
        }).then((value) {
          Get.back();
          Get.back();
        });

      }
    });
  }

  // add or update firebase data
  addUpdateFirebaseData() {
    FirebaseFirestore.instance
        .collection("userSubscribe")
        .where("email", isEqualTo: appCtrl.storage.read("userName"))
        .limit(1)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        if (value.docs[0].data()["isSubscribe"] == false) {
          FirebaseFirestore.instance
              .collection("userSubscribe")
              .doc(value.docs[0].id)
              .update({
            "balance": appCtrl.envConfig["balance"],
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection("userSubscribe")
                .where("email", isEqualTo: appCtrl.storage.read("userName"))
                .limit(1)
                .get()
                .then((value) {
              if (value.docs.isNotEmpty) {
                appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
                appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
                appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
              }
            });
          });
        }
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "balance": appCtrl.envConfig["balance"],
        });
      }
    });
  }

  removeBalance() {
    int balance = appCtrl.envConfig["balance"];
    balance = balance - 1;
    appCtrl.envConfig["balance"] = balance;
    log("BALANCE : ${appCtrl.envConfig["balance"]}");
    update();
    if (!appCtrl.isGuestLogin) {
      addUpdateFirebaseData();
    }
  }
}
