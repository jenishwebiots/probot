import '../../../config.dart';

class AmazonProductFeatureScreen extends StatelessWidget {
  const AmazonProductFeatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.bg1,
      resizeToAvoidBottomInset: false,
      appBar: AppAppBarCommon(title: appFonts.amazonProductFeature,leadingOnTap: ()=> Get.back()),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
