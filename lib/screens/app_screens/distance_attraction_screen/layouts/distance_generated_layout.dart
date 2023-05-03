import '../../../../config.dart';

class DistanceGeneratedLayout extends StatelessWidget {
  const DistanceGeneratedLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistanceAttractionController>(
      builder: (distanceCtrl) {
        return Column(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textCommon.outfitSemiBoldPrimary16(
                    text:
                    appFonts.visitWonderfulLocationsAroundWorld),
                const VSpace(Sizes.s15),
                InputLayout(
                    hintText: "",
                    title: appFonts.distanceAttraction,
                    color: appCtrl.appTheme.white,
                    isMax: false,
                    text: distanceCtrl.response,
                    responseText: distanceCtrl.response)
              ]),
          const VSpace(Sizes.s20),
          ButtonCommon(
              title: appFonts.endTraveling,
              onTap: () => distanceCtrl.endDistanceGenerator())
        ]);
      }
    );
  }
}
