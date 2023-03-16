import '../../../config.dart';
import 'layout/drop_down_layout.dart';
import 'layout/image_layout.dart';

class ImageGenerator extends StatelessWidget {
  final imageGeneratorCtrl = Get.put(ImageGeneratorController());

  ImageGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGeneratorController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: appCtrl.appTheme.primary,
            elevation: 0,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: Text(appFonts.imageGenerator,
                style: AppCss.outfitSemiBold22
                    .textColor(appCtrl.appTheme.sameWhite))),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  TextFieldCommon(
                      hintText: appFonts.search,
                      fillColor: appCtrl.appTheme.surface,
                      prefixIcon: SvgPicture.asset(eSvgAssets.search,
                          fit: BoxFit.scaleDown).inkWell(onTap: () {
                        
                      }),
                      suffixIcon: SizedBox(
                          height: 10,
                          width: 5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const VerticalDivider(
                                    width: 1,
                                    thickness: 2,
                                    indent: 10,
                                    endIndent: 10),
                                PopupMenuButton(
                                  icon: SvgPicture.asset(eSvgAssets.filter,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  offset: Offset(0, 60),
                                  itemBuilder: (ctx) => [
                                    _buildPopupMenuItem('sdadsadsadfasdsadadsadasda', Icons.search, 1),
                                    _buildPopupMenuItem('Upload', Icons.upload, 2),
                                    _buildPopupMenuItem('Copy', Icons.copy, 3),
                                    _buildPopupMenuItem('Exit', Icons.exit_to_app, 5),
                                  ],

                                )

                              ]))).authBoxExtension(),
                  const VSpace(Sizes.s10),
                  SizedBox(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                        DropDownLayout(
                            value: imageGeneratorCtrl.imageValue,
                            title: appFonts.imageSize,
                            hintText: appFonts.selectSize,
                            dropDownList: imageGeneratorCtrl.imageSizeLists
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(
                                    value: e.value, child: Text(e.value)))
                                .toList(),
                            onChanged: (val) {
                              imageGeneratorCtrl.imageValue = val.toString();
                              imageGeneratorCtrl.update();
                            }),
                        const HSpace(Sizes.s15),
                        DropDownLayout(
                            value: imageGeneratorCtrl.viewValue,
                            title: appFonts.viewType,
                            hintText: appFonts.selectType,
                            dropDownList: imageGeneratorCtrl.viewTypeLists
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(
                                    value: e.value, child: Text(e.value)))
                                .toList(),
                            onChanged: (val) {
                              imageGeneratorCtrl.viewValue = val.toString();
                              imageGeneratorCtrl.update();
                            })
                      ]).paddingAll(Insets.i15))
                      .authBoxExtension(),
                  const VSpace(Sizes.s20),
                  imageGeneratorCtrl.viewValue == "Grid type"
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: imageGeneratorCtrl.imageLists.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return ImageLayout(
                                    data: imageGeneratorCtrl.imageLists[index])
                                .inkWell(
                                    onTap: () => Get.toNamed(
                                        routeName.imagePreview,
                                        arguments: imageGeneratorCtrl
                                            .imageLists[index]["image"]));
                          },
                        )
                      : Column(
                          children: imageGeneratorCtrl.imageLists
                              .asMap()
                              .entries
                              .map((e) => ImageLayout(
                                      height: Sizes.s400,
                                      width: MediaQuery.of(context).size.width,
                                      data: e.value)
                                  .inkWell(
                                      onTap: () => Get.toNamed(
                                          routeName.imagePreview,
                                          arguments: e.value["image"]))
                                  .paddingOnly(bottom: Insets.i15))
                              .toList()
                        )
                ]),


                // ButtonCommon(title: appFonts.generateImage)
              ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
        ),
      );
    });
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(

      value: position,
      child:  Container(

        child: Row(
          children: [
            Icon(iconData, color: Colors.black,),
            Text(title),


          ],
        ),
      ),
    );
  }

}
