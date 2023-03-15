import '../../config.dart';


class ImageGeneratorController extends GetxController {

   List imageSizeLists = [];
   List viewTypeLists = [];
   List imageLists = [];

   String? imageValue;
   String? viewValue;

   @override
  void onReady() {
     imageLists = appArray.imageGeneratorList.map((e) => ImageListModel.fromJson(e)).toList();
      imageSizeLists = appArray.imageSizeList;
      viewTypeLists = appArray.viewTypeList;
      update();
    // TODO: implement onReady
    super.onReady();
  }

}