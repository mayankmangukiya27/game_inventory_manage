class InventoryModel {
  String? inventoryId;
  String? dateTime;
  String? img;
  int? qty;
  String? cat;
  String? name;
  int? gameId;
  bool? isUsed;

  InventoryModel({this.inventoryId, this.dateTime, this.img, this.qty, this.cat, this.name, this.gameId, this.isUsed});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    img = json['img'];
    qty = json['qty'];
    cat = json['cat'];
    name = json['name'];
    gameId = json['id'];
    isUsed = json['isUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['img'] = this.img;
    data['qty'] = this.qty;
    data['cat'] = this.cat;
    data['name'] = this.name;
    data['id'] = this.gameId;
    data['isUsed'] = this.isUsed;
    return data;
  }
}
