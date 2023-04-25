class SubscribeModel {
  String? title;
  String? type;
  int? price;
  int? balance;
  String? priceTpe;
  String? icon;
  String? chatCount;
  String? imageCount;
  String? textCompletionCount;
  List<String>? benefits;

  SubscribeModel(
      {this.title,
        this.type,
        this.price,
        this.balance,
        this.priceTpe,
        this.icon,
        this.chatCount,
        this.imageCount,
        this.textCompletionCount,
        this.benefits});

  SubscribeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    price = json['price'];
    priceTpe = json['priceTpe'];
    balance = json['balance'] ?? 5;
    icon = json['icon'];
    chatCount = json['chatCount'];
    imageCount = json['imageCount'];
    textCompletionCount = json['textCompletionCount'];
    if(json["benefits"] != null ) {
      benefits = json['benefits'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['price'] = price;
    data['priceTpe'] = priceTpe;
    data['balance'] = balance;
    data['icon'] = icon;
    data['chatCount'] = chatCount;
    data['imageCount'] = imageCount;
    data['textCompletionCount'] = textCompletionCount;
    if(benefits !=null) {
      data['benefits'] = benefits;
    }
    return data;
  }
}