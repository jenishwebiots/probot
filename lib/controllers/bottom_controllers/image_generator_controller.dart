import 'dart:convert';

import 'package:probot/bot_api/config.dart';
import 'package:probot/models/image_model.dart';

import '../../config.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class ImageGeneratorController extends GetxController {
  var url = Uri.parse('https://api.openai.com/v1/images/generations');

  final TextEditingController imageTextController = TextEditingController();
  List imageSizeLists = [];
  List viewTypeLists = [];
  List imageLists = [];

  String? imageValue;
  String? viewValue;
  List noOfImagesLists = [];
  List imageStyleLists = [];
  List moodLists = [];
  List imageColorLists = [];

  bool isFilter = false, isLoader = false;

  String? noOfImagesValue;
  String? imageStyleValue;
  String? moodValue;
  String? imageColorValue;
  ImageModel? imageGPTModel;
  RxInt count = 0.obs;

  Future getGPTImage(
      {required String imageText, String? size = "256x256"}) async {
    log("imageText: $imageText");
    try {
      update();
      var request = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConfig.chatGPTkey}',
        },
        body: jsonEncode(
          {
            'prompt': imageText,
            'n': 5,
            "size": size,
          },
        ),
      );
      print(request.body);
      if (request.statusCode == 200) {
        addCountImage();
        imageGPTModel = ImageModel.fromJson(jsonDecode(request.body));
        update();
        Get.forceAppUpdate();
      } else {
        debugPrint(jsonDecode(request.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addCountImage() async {
    count.value++;
    // LocalStorage.saveImageCount(count: count.value);
  }

  onTapFilter() {
    isFilter = !isFilter;
    update();
  }

  // on tap method
  onTabMethod() async {
    isLoader = true;
    FocusScope.of(Get.context!).unfocus();
    await getGPTImage(imageText: imageTextController.text.trim());
    Get.snackbar('Generated', "Please wait for load image");
    isLoader = false;
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
