class Module {
  var id;
  var module;
  var intero;
  var controle;
  var comment;
  var moy;
  Module(
      {this.id,
      this.module,
      this.intero,
      this.controle,
      this.comment,
      this.moy});
  Module.fromJson(Map<String, dynamic> json) {
    module = json['module'];
    id = json['_id'];
    intero = json['intero'];
    controle = json['controle'];
    comment = json['comment'];
    moy = json['moy'];
  }
  Map<String, dynamic> toMap() {
    // final Map<String, dynamic> data = <String, dynamic>{};

    return {
      '_id': id,
      'module': module,
      'intero': intero,
      'controle': controle,
      'comment': comment,
      'moy': moy,
    };
  }
}
