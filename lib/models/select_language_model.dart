class SelectLanguageModel {
  String? image;
  String? title;

  SelectLanguageModel({this.image, this.title});

  SelectLanguageModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
