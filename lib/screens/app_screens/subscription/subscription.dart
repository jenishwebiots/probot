import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../config.dart';

class Subscription extends StatelessWidget {
  final subscribeCtrl = Get.put(SubscriptionController());

  Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
            title: appFonts.selectPlan,
            actionIcon: eSvgAssets.currency,
            isAction: true,
            leadingOnTap: () => Get.back(),
            actionOnTap: () => subscribeCtrl.currencyListDialog(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(eImageAssets.subscriptionTopBg),
                    IntrinsicHeight(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text(
                            "Lifetime accessibility\nto everything",
                            style: AppCss.outfitMedium18
                                .textColor(appCtrl.appTheme.sameWhite),
                          ),
                          Image.asset(
                            eImageAssets.subscriptionCrown,
                            height: Sizes.s80,
                          )
                        ]).marginSymmetric(horizontal: Insets.i20))
                  ],
                )
                    .width(MediaQuery.of(context).size.width)
                    .paddingSymmetric(horizontal: Insets.i20),
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(flex: 4),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(

                        decoration: BoxDecoration(
                          color: appCtrl.appTheme.primaryLight,
                            border: Border(
                                top:
                                    BorderSide(color: appCtrl.appTheme.primary),
                                bottom: BorderSide(
                                    color: appCtrl.appTheme.primary))),
                        children: [
                          Column(
                            children: [
                              Text(
                                'Website',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ).paddingSymmetric(vertical:Insets.i8 ),
                          Column(
                            children: [
                              Text(
                                'Free',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ).paddingSymmetric(vertical:Insets.i8 ).decorated(border: Border(
                              left: BorderSide(color: appCtrl.appTheme.primary)
                          )),
                          Column(
                            children: [
                              Text(
                                'Pro',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ).paddingSymmetric(vertical:Insets.i8 ).decorated(border: Border(
                              left: BorderSide(color: appCtrl.appTheme.primary)
                          )),
                        ]),
                    TableRow(children: [
                      Column(
                        children: [
                          Text('https://flutter.dev/'),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(eSvgAssets.share)
                        ],
                      ).decorated(border: Border(
                          left: BorderSide(color: appCtrl.appTheme.primary)
                      )),
                      Column(
                        children: [
                          SvgPicture.asset(eSvgAssets.share)
                        ],
                      ).decorated(border: Border(
                          left: BorderSide(color: appCtrl.appTheme.primary)
                      )),
                    ]),
                    TableRow(children: [
                      Column(
                        children: [
                          Text('https://dart.dev/'),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(eSvgAssets.share)
                        ],
                      ).decorated(border: Border(
                          left: BorderSide(color: appCtrl.appTheme.primary)
                      )),
                      Column(
                        children: [
                          SvgPicture.asset(eSvgAssets.share)
                        ],
                      ).decorated(border: Border(
                          left: BorderSide(color: appCtrl.appTheme.primary)
                      )),
                    ]),
                    TableRow(decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: appCtrl.appTheme.primary))
                    ),children: [
                      Column(
                        children: [
                          Text('https://pub.dev/'),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(eSvgAssets.share)
                        ],
                      ).decorated(border: Border(
                          left: BorderSide(color: appCtrl.appTheme.primary)
                      )),
                      Column(
                        children: [
                          SvgPicture.asset(eSvgAssets.share)
                        ],
                      ).decorated(border: Border(
                          left: BorderSide(color: appCtrl.appTheme.primary)
                      )),
                    ]),
                  ],
                )
              ],
            ).marginSymmetric(
              vertical: Insets.i25,
            ),
          ));
    });
  }
}
