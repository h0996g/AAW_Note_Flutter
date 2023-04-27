import 'package:affichage/models/userModel.dart';

class EtudientDetailsWithNote {
  // bool? status;

  // !mb3d nrghom double
  int? math;
  int? physique;
  int? algo;
  int? moy;
  String? id;

  UserModel? data;

  EtudientDetailsWithNote(
      {this.data,
      this.algo,
      this.math,
      this.physique,
      // this.status,
      this.id,
      this.moy});
  EtudientDetailsWithNote.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    math = json['math'];
    physique = json['physique'];
    algo = json['algo'];
    id = json['_id'];
    moy = json['moy'];
    data = UserModel.fromJson(json['userowner']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      // status = json['status'];
      'math': math,
      'algo': algo,
      'physique': physique,
      'moy': moy,
      'data': data
    };
  }
}