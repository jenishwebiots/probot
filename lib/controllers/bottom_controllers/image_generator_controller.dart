import '../../config.dart';


class ImageGeneratorController extends GetxController {

   List imageSizeLists = [];
   List viewTypeLists = [];
   List imageLists = [];
   List noOfImagesLists = [];
   List imageStyleLists = [];
   List moodLists = [];
   List imageColorLists = [];

   bool isFilter = false;

   String? imageValue;
   String? viewValue;
   String? noOfImagesValue;
   String? imageStyleValue;
   String? moodValue;
   String? imageColorValue;

   onTapFilter () {
     isFilter = !isFilter;
     update();
   }

   @override
  void onReady() {

     imageLists = appArray.imageGeneratorList;
     imageSizeLists = appArray.imageSizeList;
     viewTypeLists = appArray.viewTypeList;

     noOfImagesLists = appArray.noOfImagesList;
     imageStyleLists = appArray.imageStyleList;
     moodLists = appArray.moodList;
     imageColorLists = appArray.imageColorList;



      update();
    // TODO: implement onReady
    super.onReady();
  }

}