import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config.dart';

class MyAccountController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  String? name, userName, firebaseUser, number;
  String? id;

  deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      Get.offAllNamed(routeName.loginScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        log(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  onUpdate() {
    log("id: $id");
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (value.docs[0].data()["logintype"] == "Number") {
          FirebaseFirestore.instance
              .collection('users')
              .doc(value.docs[0].id)
              .update({
            'nickname': firstNameController.text,
            "email": emailController.text
          });
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(value.docs[0].id)
              .update({
            'nickname': firstNameController.text,
            "phone": numberController.text
          });
        }
      }
    });


  }

  @override
  void onReady() {
    id = appCtrl.storage.read("id") ?? '';
    numberController.text = appCtrl.storage.read("number") ?? "";
    number = numberController.text;
    emailController.text = appCtrl.storage.read("userName");
    userName = emailController.text;
    firstNameController.text = appCtrl.storage.read("name") ?? "";
    name = firstNameController.text;

    // firebaseUser = appCtrl.storage.read("firebaseUser");
    log("number: ${numberController.text}");
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
