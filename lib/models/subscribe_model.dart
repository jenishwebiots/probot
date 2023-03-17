class SubscribeModel {
  String? planName;
  String? type;
  double? price;
  String? priceTpe;
  String? icon;
  List<String>? benefits;

  SubscribeModel(
      {this.planName,
        this.type,
        this.price,
        this.priceTpe,
        this.icon,
        this.benefits});

  SubscribeModel.fromJson(Map<String, dynamic> json) {
    planName = json['planName'];
    type = json['type'];
    price = json['price'];
    priceTpe = json['priceTpe'];
    icon = json['icon'];
    benefits = json['benefits'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['planName'] = planName;
    data['type'] = type;
    data['price'] = price;
    data['priceTpe'] = priceTpe;
    data['icon'] = icon;
    data['benefits'] = benefits;
    return data;
  }
}