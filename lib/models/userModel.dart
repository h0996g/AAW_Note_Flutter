class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  UserModel(
      {this.id, this.name, this.email, this.password, this.phone, this.image});
  UserModel.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    // final Map<String, dynamic> data = <String, dynamic>{};

    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
    };
  }

  // Map<String, dynamic> toJson() {
  //   data['_id'] = sId;
  //   data['name'] = name;
  //   data['email'] = email;
  //   data['password'] = password;
  //   data['phone'] = phone;
  //   data['image'] = image;
  //   data['createdAt'] = createdAt;
  //   data['updatedAt'] = updatedAt;
  //   data['__v'] = iV;
  //   return data;
  // }
}
