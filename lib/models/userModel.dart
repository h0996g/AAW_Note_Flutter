class UserModel {
  var id;
  var name;
  var email;
  var password;
  var phone;
  var image;
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
}
