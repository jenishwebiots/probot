import '../config.dart';

class AppArray {
  // On boarding list
  var onBoardingList = [
    {
      "image": eImageAssets.ob1,
      "title": appFonts.chatWith,
      "subtitle": appFonts.openAiChatGpt
    },
    {
      "image": eImageAssets.ob2,
      "title": appFonts.easilyGenerateImage,
      "subtitle": appFonts.toReceiveTheFinest
    },
    {
      "image": eImageAssets.ob3,
      "title": appFonts.quickCreation,
      "subtitle": appFonts.enterTheTitle
    }
  ];

// Languages list
  var languagesList = [
    {
      "image": eImageAssets.english,
      "title": appFonts.english,
      'locale': const Locale('en', 'US'),
      "code": "en"
    },
    {"image": eImageAssets.indian, "title": appFonts.hindi,
      'locale': const Locale('hi', 'IN'),
      "code": "hi"
    },
    {"image": eImageAssets.french, "title": appFonts.french,
      'locale': const Locale('fr', 'CA'),
      "code": "fr"
    },
    {"image": eImageAssets.italian, "title": appFonts.italian,
      'locale': const Locale('it', 'IT'),
      "code": "it"
    },
    {"image": eImageAssets.german, "title": appFonts.german,
      'locale': const Locale('ge', 'GE'),
      "code": "ge"
    },
    {
      "image": eImageAssets.japanese, "title": appFonts.japanese,
      'locale': const Locale('ja', 'JP'),
      "code": "ja"
    },
  ];

//Select character list
  var selectCharacterList = [
    {"image": eImageAssets.sc1, "title": appFonts.dino},
    {"image": eImageAssets.sc2, "title": appFonts.king},
    {"image": eImageAssets.sc3, "title": appFonts.dolly},
    {"image": eImageAssets.sc4, "title": appFonts.kettie},
    {"image": eImageAssets.sc5, "title": appFonts.marvel},
    {"image": eImageAssets.sc6, "title": appFonts.henny},
    {"image": eImageAssets.sc7, "title": appFonts.slophie}
  ];
}
