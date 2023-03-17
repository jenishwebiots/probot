import 'dart:developer';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import '../../../config.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

class ImagePreview extends StatelessWidget {
  final imagePreviewCtrl = Get.put(ImagePreviewController());
  ImagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return GetBuilder<ImagePreviewController>(builder: (_) {
      return Scaffold(
          body: Stack(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(imagePreviewCtrl.image, fit: BoxFit.cover)),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            SvgPicture.asset(eSvgAssets.leftArrow,
                    colorFilter: ColorFilter.mode(
                        appCtrl.appTheme.sameWhite, BlendMode.srcIn))
                .inkWell(onTap: () => Get.back()),
            const HSpace(Sizes.s18),
            Text(appFonts.imagePreview,
                style: AppCss.outfitSemiBold22
                    .textColor(appCtrl.appTheme.sameWhite))
          ]),
          Row(children: [
            Expanded(
                child: ButtonCommon(
              title: appFonts.share,
              onTap: () =>
                  Share.share(imagePreviewCtrl.image, subject: "Probot image"),
            )),
            const HSpace(Sizes.s15),
            Expanded(
                child: ButtonCommon(
              title: appFonts.download,
              onTap: () => download(imagePreviewCtrl.image),
            ))
          ])
        ]).padding(horizontal: Insets.i20, top: Insets.i60, bottom: Insets.i40)
      ]));
    });
  }
}
