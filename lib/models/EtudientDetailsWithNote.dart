import 'package:affichage/models/module.dart';
import 'package:affichage/models/userModel.dart';

class EtudientDetailsWithNote {
  // bool? status;

  // !mb3d nrghom double
  Module? math;
  Module? physique;
  Module? algo;
  var moy;
  var id;

  UserModel? data;

  EtudientDetailsWithNote({
    this.data,
    this.algo,
    this.math,
    this.physique,

    // this.status,
    this.id,
    this.moy,
  });
  EtudientDetailsWithNote.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    math = Module.fromJson(json['math']);
    physique = Module.fromJson(json['physique']);
    algo = Module.fromJson(json['algo']);
    id = json['_id'];
    moy = json['moy'];
    data =
        // json['userowner'] != null
        // ?
        UserModel.fromJson(json['userowner']);
    // : null;
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
