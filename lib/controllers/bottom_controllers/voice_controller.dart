import '../../config.dart';

class VoiceController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List selectLanguageLists = [];
  String langValue = appFonts.english;

  final items = [
    {
      "title": appFonts.english,
      "jh": appFonts.english,
    },{
      "title": appFonts.hindi,
    },{
      "title": appFonts.german,
    },{
      "title": appFonts.japanese,
    }
  ];

  @override
  void onReady() {

    selectLanguageLists = appArray.languagesList
        .map((e) => SelectLanguageModel.fromJson(e))
        .toList();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
