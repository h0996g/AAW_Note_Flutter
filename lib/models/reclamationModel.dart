import 'package:affichage/models/userModel.dart';

class ReclamationModel {
  // bool? status;

  // !mb3d nrghom double
  String? text;
  String? module;
  String? updatedAt;
  String? createdAt;
  String? id;
  bool? done;
  String? title;

  UserModel? data;

  ReclamationModel({
    this.data,
    this.done,
    this.updatedAt,
    this.text,
    this.module,
    this.title,

    // this.status,
    this.id,
    this.createdAt,
  });
  ReclamationModel.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    text = json['text'];
    module = json['module'];
    done = json['done'];
    updatedAt = json['updatedAt'];
    id = json['_id'];
    createdAt = json['createdAt'];
    title = json['title'];
    data = UserModel.fromJson(json['userowner']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'text': text,
      'done': done,
      'updatedAt': updatedAt,
      'module': module,
      'createdAt': createdAt,
      'data': data,
      'title': title
    };
  }
}
