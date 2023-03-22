import 'package:firebase_auth/firebase_auth.dart';
import '../../config.dart';
import '../../widgets/scaffold_messenger.dart';

class MobileLoginController extends GetxController {
  GlobalKey<FormState> mobileGlobalKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

  bool isLoading = false;

}
