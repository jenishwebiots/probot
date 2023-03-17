import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config.dart';


class ImagePreviewController extends GetxController {
  dynamic image;



  @override
  void onReady() {
    var data = Get.arguments;
    image = data ?? "";
    update();
    // TODO: implement onReady
    super.onReady();
  }

  //download image
  download(String url) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> status;

    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt <= 32) {
        status = await [Permission.storage].request();
      } else {
        status = await [Permission.photos].request();
      }
    } else {
      status = await [Permission.photosAddOnly].request();
    }

    var allAccept = true;
    status.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccept = false;
      }
    });

    if (allAccept) {
      await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      url.substring(url.length - 20);
    } else {}
  }
}