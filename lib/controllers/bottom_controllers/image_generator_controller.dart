import 'dart:convert';

import 'package:probot/bot_api/config.dart';
import 'package:probot/models/image_model.dart';

import '../../config.dart';
import 'package:http/http.dart' as http;

class ImageGeneratorController extends GetxController {
  var url = Uri.parse('https://api.openai.com/v1/images/generations');

  final TextEditingController imageTextController = TextEditingController();
  List imageSizeLists = [];
  List viewTypeLists = [];
  List imageLists = [];

  String? imageValue;
  String? viewValue;

  ImageModel? imageGPTModel;
  RxInt count = 0.obs;

  @override
  void onReady() {
    imageLists = appArray.imageGeneratorList;
    imageSizeLists = appArray.imageSizeList;
    viewTypeLists = appArray.viewTypeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  Future getGPTImage({required String imageText}) async {
    try {
      update();
      var request = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConfig.chatGPTkey}',
        },
        body: jsonEncode(
          {'prompt': imageText, 'n': 5, "size": "256x256"},
        ),
      );
      print(request.body);
      if (request.statusCode == 200) {
        addCountImage();
        imageGPTModel = ImageModel.fromJson(jsonDecode(request.body));
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
}
