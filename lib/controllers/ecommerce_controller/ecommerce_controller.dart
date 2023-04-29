import '../../config.dart';

class EcommerceController extends GetxController {
  List ecommerceLists = [];

  onTapEcommerce(data) {
   if(data["title"] == appFonts.amazonProductFeature) {
          Get.toNamed(routeName.amazonProductFeatureScreen);
   } else if (data["title"] == appFonts.amazonProductListing) {
     Get.toNamed(routeName.amazonProductListingScreen);
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