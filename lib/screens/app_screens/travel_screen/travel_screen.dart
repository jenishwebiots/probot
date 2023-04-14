import '../../../config.dart';

class TravelScreen extends StatelessWidget {
  final travelCtrl = Get.put(TravelController());
  TravelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelController>(builder: (_) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [],
        ),
      );
    });
  }
}
