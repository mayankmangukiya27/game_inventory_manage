class UserDataModel {
  String? fullName;
  String? id;
  String? email;

  UserDataModel({this.fullName, this.id, this.email});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}
