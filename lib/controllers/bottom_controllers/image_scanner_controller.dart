import '../../config.dart';

class ImageScannerController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List imageScannerList = [];
  int selectedIndex = 0;

  onScanFrom(index) {
    selectedIndex = index;
    update();
  }

  @override
  void onReady() {
    imageScannerList = appArray.imageScannerList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
