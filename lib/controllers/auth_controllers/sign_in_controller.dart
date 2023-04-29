import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:probot/env.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../config.dart';

// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)

import '../../utils/general_utils.dart';

class SignInController extends GetxController {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();

  String? userNameGoogle = "";
  String? userName = "";
  bool obscureText = true;

  //password obscure
  onObscure() {
    obscureText = !obscureText;
    update();
  }

  // SignIn With Google Method
  Future signInWithGoogle() async {
    try{
      appCtrl.isGuestLogin = false;
      appCtrl.storage.write(session.isGuestLogin, false);
      log("message");
      isLoading = true;
      update();
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      User? user = (await auth.signInWithCredential(credential)).user;
      update();
      userNameGoogle = user!.email;
      isLoading = false;
      update();
      appCtrl.storage.write("userName", userNameGoogle);
      appCtrl.storage.write("name", user.displayName);

      await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .limit(1)
          .get()
          .then((result) async {
        if (result.docs.isEmpty) {
          // Update data to server if new user
          FirebaseMessaging.instance.getToken().then((token) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'logintype': "Google",
              'nickname': user.displayName,
              'email': userNameGoogle,
              'phone': user.phoneNumber,
              'id': user.uid,
              "balance": 5,
              "fcmToken": token,
              "isActive": true
            });
          });
          appCtrl.envConfig["balance"] = 5;
        } else {

          log("BANCE :${result.docs[0].data()["balance"] == null}");
          if(result.docs[0].data()["balance"] == null){
            appCtrl.envConfig["balance"] = 5;
          }else{
            appCtrl.envConfig["balance"] = result.docs[0].data()["balance"];
          }
          update();
          await FirebaseMessaging.instance.getToken().then((token) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({"fcmToken": token, "isActive": true,"balance":appCtrl.envConfig["balance"]});
          });
          appCtrl.envConfig["balance"] = result.docs[0].data()["balance"];
        }
      });

      appCtrl.storage.write("id", user.uid);
      await checkData();
      Get.offAllNamed(routeName.selectLanguageScreen);
    }catch(e){
      isLoading = false;
      update();
    }finally{
      isLoading = false;
      update();
    }
  }

  // Sign In With Email & Password Method
  signInMethod() async {
    appCtrl.isGuestLogin = false;
    appCtrl.storage.write(session.isGuestLogin, false);
    if (signInGlobalKey.currentState!.validate()) {
      // isLoading = true;
      update();
      try {
        var firebaseUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.toString(),
                password: passwordController.text.toString());
        var signIn = FirebaseAuth.instance.currentUser;
        userName = signIn!.email;
        update();
        isLoading = false;
        appCtrl.storage.write("userName", userName);
        appCtrl.storage.write("name", signIn.displayName);
        await checkData();
        Get.offAllNamed(routeName.selectLanguageScreen);
        FirebaseMessaging.instance.getToken().then((token) async {
          await FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: firebaseUser.user!.uid)
              .limit(1)
              .get()
              .then((value) async {
            log("doc ${value.docs.isEmpty}");
            if (value.docs.isEmpty) {
              // Update data to server if new user
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(firebaseUser.user!.uid)
                  .set({
                'logintype': "Email",
                'nickname': firebaseUser.user!.displayName,
                'email': userName,
                'phone': firebaseUser.user!.phoneNumber,
                'id': firebaseUser.user!.uid,
                "balance": 5,
                "fcmToken": token,
                "isActive": true
              });
              appCtrl.envConfig["balance"] = 5;
            } else {
              log("BANCE :${value.docs[0].data()["balance"] == null}");
              if(value.docs[0].data()["balance"] == null){
                appCtrl.envConfig["balance"] = 5;
              }else{
                appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
              }
              update();
              await FirebaseMessaging.instance.getToken().then((token) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(firebaseUser.user!.uid)
                    .update({"fcmToken": token, "isActive": true,"balance":appCtrl.envConfig["balance"]});
              });
              appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
            }
          });
        });
        update();
        appCtrl.storage.write("id", firebaseUser.user!.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          isLoading = false;
          update();
          snackBarMessengers(message: appFonts.wrongPassword);
        } else if (e.code == 'user-not-found') {
          isLoading = false;
          update();
          snackBarMessengers(message: appFonts.userNotFound);
        }
      } catch (e) {
        isLoading = false;
        update();
        snackBarMessengers(message: e.toString());
      }
    }
  }

  //sign in with apple
  signInWithApple() async {
    appCtrl.isGuestLogin = false;
    appCtrl.storage.write(session.isGuestLogin, false);
    isLoading = true;
    update();
    try {
      final rawNonce = generateNonces();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      log("CRED : $appleCredential");
      final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode);

      log("AUTH : $oauthCredential");
      update();

      await FirebaseAuth.instance
          .signInWithCredential(oauthCredential)
          .then((value) async {
        var signIn = FirebaseAuth.instance.currentUser;
        userName = signIn!.email;
        isLoading = false;
        update();

        appCtrl.storage.write("userName", userName);
        appCtrl.storage.write("name", signIn.displayName);

        await checkData();
        Get.offAllNamed(routeName.selectLanguageScreen);
        FirebaseMessaging.instance.getToken().then((token) async {
          await FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: signIn.uid)
              .limit(1)
              .get()
              .then((value) async {
            log("doc ${value.docs.isEmpty}");
            if (value.docs.isEmpty) {
              // Update data to server if new user
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(signIn.uid)
                  .set({
                'logintype': "Email",
                'nickname': signIn.displayName,
                'email': signIn.email,
                'phone': signIn.phoneNumber,
                'id': signIn.uid,
                "balance": 5,
                "fcmToken": token,
                "isActive": true
              });
              appCtrl.envConfig["balance"] = 5;
            } else {
              log("BANCE :${value.docs[0].data()["balance"] == null}");
              if(value.docs[0].data()["balance"] == null){
                appCtrl.envConfig["balance"] = 5;
              }else{
                appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
              }
              await FirebaseMessaging.instance.getToken().then((token) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(signIn.uid)
                    .update({"fcmToken": token, "isActive": true,"balance": appCtrl.envConfig["balance"]});
              });
              appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
            }
          });
        });
        appCtrl.storage.write("id", signIn.uid);
      });

      update();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();

      snackBarMessengers(message: e.code);
    } catch (e) {
      isLoading = false;
      update();

      log("ERROR CATHC ; $e");
    }
  }

  checkData() async {
    await FirebaseFirestore.instance
        .collection("userSubscribe")
        .where("email", isEqualTo: appCtrl.storage.read("userName"))
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        log("DATA : ${value.docs[0].data()}");
        if(value.docs[0].data()["isSubscribe"] == false) {
          appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
          appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
          appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
          appCtrl.storage.write(session.isSubscribe, false);
          appCtrl.isSubscribe = false;
        }else{
          appCtrl.isSubscribe = true;
          appCtrl.storage.write(session.isSubscribe, true);
        }
        appCtrl.storage.write(session.isAnySubscribe, true);
      } else {
        appCtrl.storage.write(session.isAnySubscribe, false);
        appCtrl.envConfig = environment;
        appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
        appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
      }
    });
  }

  @override
  void onClose() {
    signInGlobalKey.currentState;
    // TODO: implement onClose
    super.onClose();
  }
}
