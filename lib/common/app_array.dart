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

//Select character list
  var selectCharacterList = [
    {"image": eImageAssets.sc1, "title": appFonts.dino},
    {"image": eImageAssets.sc2, "title": appFonts.king},
    {"image": eImageAssets.sc3, "title": appFonts.dolly},
    {"image": eImageAssets.sc4, "title": appFonts.kettie},
    {"image": eImageAssets.sc5, "title": appFonts.marvel},
    {"image": eImageAssets.sc6, "title": appFonts.henny},
    {"image": eImageAssets.sc7, "title": appFonts.sophie}
  ];

// Languages list
  var languagesList = [
    {
      "image": eImageAssets.english,
      "title": appFonts.english,
      'locale': const Locale('en', 'US'),
      "code": "en"
    },
    {
      "image": eImageAssets.indian,
      "title": appFonts.hindi,
      'locale': const Locale('hi', 'IN'),
      "code": "hi"
    },
    {
      "image": eImageAssets.french,
      "title": appFonts.french,
      'locale': const Locale('fr', 'CA'),
      "code": "fr"
    },
    {
      "image": eImageAssets.italian,
      "title": appFonts.italian,
      'locale': const Locale('it', 'IT'),
      "code": "it"
    },
    {
      "image": eImageAssets.german,
      "title": appFonts.german,
      'locale': const Locale('ge', 'GE'),
      "code": "ge"
    },
    {
      "image": eImageAssets.japanese,
      "title": appFonts.japanese,
      'locale': const Locale('ja', 'JP'),
      "code": "ja"
    },
  ];

  // bottom list
  var bottomList = [
    {
      "title": "home",
      "icon": eSvgAssets.home,
      "iconSelected": eSvgAssets.homeColor
    },
    {
      "title": "chat",
      "icon": eSvgAssets.chat,
      "iconSelected": eSvgAssets.chatColor
    },
    {
      "title": "image",
      "icon": eSvgAssets.gallery,
      "iconSelected": eSvgAssets.galleryColor
    },
    {
      "title": "content",
      "icon": eSvgAssets.content,
      "iconSelected": eSvgAssets.contentColor
    },
    {
      "title": "setting",
      "icon": eSvgAssets.setting,
      "iconSelected": eSvgAssets.settingColor
    }
  ];

  // homeOption list
  var homeOptionList = [
    {"title": "option1", "icon": eSvgAssets.chatColor, "desc": "desc1"},
    {"title": "option2", "icon": eSvgAssets.galleryColor, "desc": "desc2"},
    {"title": "option3", "icon": eSvgAssets.contentColor, "desc": "desc3"}
  ];

  //drawer list
  var drawerList = [
    {"title": "proBot", "icon": eSvgAssets.chat},
    {"title": "option2", "icon": eSvgAssets.gallery},
    {"title": "option3", "icon": eSvgAssets.content},
    {"title": "setting", "icon": eSvgAssets.setting},
    {"title": "language", "icon": eSvgAssets.translate},
    {"title": "logout", "icon": eSvgAssets.logout},
  ];

  //chat list
  var chatList = [
    {
      "dateTime": "Today, 5:30 am",
      "chat": [
        {
          "isReceiver": true,
          "message": "Hello, There ?",
          "time": "5:30",
        },
        {
          "isReceiver": false,
          "message": "Hello !!",
          "time": "5:31",
        },
        {
          "isReceiver": true,
          "message": "How are you ? 😄",
          "time": "5:31",
        },
        {
          "isReceiver": false,
          "message": "I’m good ! what about you ?",
          "time": "5:32",
        },
        {
          "isReceiver": false,
          "message": "I’m good ! what about you ?",
          "time": "5:32",
        },
        {
          "isReceiver": true,
          "message": "Too good !\nWhere were you all this time ?",
          "time": "5:32",
        },
        {"isReceiver": true, "message": "Have any problem ?", "time": "5:32"},
        {
          "isReceiver": false,
          "message": "Yeah ! i’m not so good. 😐",
          "time": "5:33"
        },
        {
          "isReceiver": false,
          "message": "I need just some time. 😇",
          "time": "5:33",
        },
        {
          "isReceiver": true,
          "message": "Too good !\nWhere were you all this time ?",
          "time": "5:34",
        },
        {
          "isReceiver": true,
          "message": "Too good !\nWhere were you all this time ?",
          "time": "5:34",
        },
        {
          "isReceiver": false,
          "message": "I need just some time. 😇",
          "time": "5:35",
        },
      ]
    }
  ];

  // notification list
  var notificationList = [
    {
      "image": eImageAssets.sc6,
      "title": appFonts.hennyHasSent,
      "subtitle": appFonts.justNow,
    },
    {
      "image": eImageAssets.lock,
      "title": appFonts.yourPasswordHasBeen,
      "subtitle": appFonts.am12,
    },
    {
      "image": eImageAssets.sc7,
      "title": appFonts.sophieHasWrite,
      "subtitle": appFonts.am11,
    },
    {
      "image": eImageAssets.sc1,
      "title": appFonts.dinoHasSent,
      "subtitle": appFonts.am10,
    },
    {
      "image": eImageAssets.sc5,
      "title": appFonts.marvelHasSent,
      "subtitle": appFonts.am9,
    },
    {
      "image": eImageAssets.sc4,
      "title": appFonts.kettieHasWrite,
      "subtitle": appFonts.am9,
    },
    {
      "image": eImageAssets.sc2,
      "title": appFonts.kingHasSend,
      "subtitle": appFonts.am9,
    },
  ];
}
