import '../../config.dart';

class EcommerceController extends GetxController {
  List ecommerceLists = [];

  onTapEcommerce(data) {
   if(data["title"]) {

   }
    update();
  }

  @override
  void onReady() {
    ecommerceLists = appArray.ecommerceList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

}