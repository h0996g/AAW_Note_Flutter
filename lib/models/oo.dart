class Etudiant {
  String? sId;
  int? math;
  int? physique;
  int? algo;
  Userowner? userowner;
  int? iV;
  int? moy;
  String? id;

  Etudiant(
      {this.sId,
      this.math,
      this.physique,
      this.algo,
      this.userowner,
      this.iV,
      this.moy,
      this.id});

  Etudiant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    math = json['math'];
    physique = json['physique'];
    algo = json['algo'];
    userowner = json['userowner'] != null
        ? Userowner.fromJson(json['userowner'])
        : null;
    iV = json['__v'];
    moy = json['moy'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['math'] = math;
    data['physique'] = physique;
    data['algo'] = algo;
    if (userowner != null) {
      data['userowner'] = userowner!.toJson();
    }
    data['__v'] = iV;
    data['moy'] = moy;
    data['id'] = id;
    return data;
  }
}

class Userowner {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Userowner(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Userowner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
