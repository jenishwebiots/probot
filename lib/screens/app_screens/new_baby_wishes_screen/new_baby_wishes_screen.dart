import '../../../config.dart';

class NewBabyWishesScreen extends StatelessWidget {
  const NewBabyWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.bg1,
      resizeToAvoidBottomInset: false,
      appBar: AppAppBarCommon(title: appFonts.newBabyWishes,leadingOnTap: ()=> Get.back()),
      body: SingleChildScrollView(
        child: Column(
          children: [
              Column(
                children: [
                  textCommon.outfitSemiBoldPrimary16(text: appFonts.wonderFullGreetings),
                  Column(
                    children: [

                    ],
                  ).paddingSymmetric(vertical: Insets.i20,horizontal: Insets.i15).authBoxExtension(),
                ],
              )
          ],
        ).paddingSymmetric(horizontal: Insets.i20,vertical: Insets.i30),
      ),
    );
  }
}
