
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../../../config.dart';

class ChatCommonWidget{

  //social layout
  Widget socialLayout(image,text)=> Column(
    children: [
      SvgPicture.asset(image,height: Sizes.s60,),
      const VSpace(Sizes.s8),
      Text(text,
          style: AppCss.outfitMedium14
              .textColor(appCtrl.appTheme.txt)
              .textDecoration(TextDecoration.none))
    ],
  );

  //time text layout
  Widget timeTextLayout(time) => Text(
      DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(
              time))),
      style: AppCss.outfitMedium12
          .textColor(appCtrl.appTheme.lightText));

  //user image
  Widget userImage(image) =>  Container(

    height: Sizes.s44,
    width: Sizes.s40,
    decoration: const BoxDecoration(shape: BoxShape.circle),
    child: CachedNetworkImage(
        imageUrl: image,
        height: Sizes.s44,
        width: Sizes.s50,

        imageBuilder: (context, imageProvider) => Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
            height: Sizes.s44,
            width: Sizes.s40,
            child: Column(children: [
              Image.network(
                  image.toString(),
                  height: Sizes.s40,
                  width: Sizes.s40)
            ])),
        placeholder: (context, url) =>
        const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          height: Sizes.s44,
          width: Sizes.s40,
          child: Image.network(
              appCtrl.selectedCharacter["image"].toString(),
              height: Sizes.s40,
              width: Sizes.s40,
              fit: BoxFit.fill),
        )),
  );

  // common svg icon
  Widget commonSvgIcon(icon,{GestureTapCallback? onTap}) =>  SvgPicture.asset(
    icon,
    colorFilter:
    ColorFilter.mode(appCtrl.appTheme.sameWhite, BlendMode.srcIn),
  ).inkWell(onTap: onTap);
}