import 'dart:io';

import 'package:affichage/models/reclamationModel.dart';
import 'package:affichage/pages/Responsable/Etudients.dart';
import 'package:affichage/pages/Responsable/Reclamation.dart';
import 'package:affichage/pages/Responsable/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../../../dio/dioHalper.dart';
import '../../../models/EtudientDetailsWithNote.dart';
import '../../../models/userModel.dart';
import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  bool? isDone;
  bool iswriteComment = false;
  List<UserModel>? etudiantModelList;
  EtudientDetailsWithNote? etudiantModel;
  List<ReclamationModel>? reclamationModelList;
  ReclamationModel? reclamationModel;
  UserModel? responsableModel;
  int currentIndex = 0;
  List<Widget> userScreen = [
    Reclamation(),
    Etudiants(),
    ProfileResponsable(),
  ];
  List<String> appbarScreen = const [
    'Reclamation',
    'Etudiants',
    'Profile',
  ];

  void changeStateDone(bool state) {
    isDone = state;
    emit(ChangeStatDoneStateGood());
  }

  void resetValueWhenelogout() {
    currentIndex = 0;
    etudiantModelList = null;
    etudiantModel = null;
    responsableModel = null;
  }

  void resetValueWheneUpdate() {
    imageCompress = null;
    linkProfileImg = null;
    mathVisibility = false;
    physiqueVisibility = false;
    algoVisibility = false;
  }

  void resetValueWheneSeeDetailEtudiant() {
    etudiantModel = null;
  }

  changeButtonNav(int currentIndex) {
    this.currentIndex = currentIndex;
    emit(ChangeButtonNavStateGood());
  }

  void writeComment(bool state) {
    iswriteComment = state;
    emit(ChangeAnimatCommentStateGood());
  }

// get Responsable
  Future<void> getCurrentResponsableInfo() async {
    emit(LodinGetCurrentResponsableDetailState());

    await DioHelper.getData(
      url: GETRESPONSABLEDETAIL + DECODEDTOKEN['_id'].toString(),
    ).then((value) {
      print('current user');
      // print(DECODEDTOKEN['_id'].toString());
      responsableModel = UserModel.fromJson(value.data);
      print(responsableModel!.name);
      emit(GetCurrentResponsableDetailStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetCurrentResponsableDetailStateBad(e.toString()));
    });
  }

//  get Etudients
  Future<void> getEtudiants() async {
    etudiantModelList = null;
    emit(LodinGetEtudiantsState());
    await DioHelper.getData(url: GETAllETUDIANTS).then((value) {
      print('jabhom');
      etudiantModelList =
          []; //! bh y9der ydirl.ha add (ni chare7 3lh drt.ha Null fl commit t3 AAW_Flutter)
      for (var element in value.data) {
        etudiantModelList!.add(UserModel.fromJson(element));
      }
      emit(GetOtherEtudiantsStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetOtherEtudiantsStateBad(e.toString()));
    });
  }

// Delete Etudiant

  deleteEtudiant({required String id}) {
    emit(LodinDeleteEtudiantState());

    DioHelper.deleteData(
      url: DELETEETUDIENT + id.toString(),
    ).then((value) {
      print('na7a');

      getEtudiants();
      emit(DeleteEtudiantStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(DeleteEtudiantStateBad(e.toString()));
    });
  }

// info Etudiant
  Future<void> getEtudiantDetail({required String id}) async {
    emit(LodinGetUserDetailState());

    await DioHelper.getData(
      url: GETUSERDETAIL + id.toString(),
    ).then((value) {
      print('dkhol l detail');
      // print(value);
      etudiantModel = EtudientDetailsWithNote.fromJson(value.data);
      print(etudiantModel!.data!.email);
      emit(GetUserDetailStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetUserDetailStateBad(e.toString()));
    });
  }

// !--------imagepicker with Compress
  // XFile? imageProfile;
  File? imageCompress;
  Future<void> imagePickerProfile(ImageSource source) async {
    final ImagePicker _pickerProfile = ImagePicker();
    await _pickerProfile.pickImage(source: source).then((value) async {
      // imageProfile = value;
      await FlutterImageCompress.compressAndGetFile(
        File(value!.path).absolute.path,
        File(value.path).path + '.jpg',
        quality: 10,
      ).then((value) {
        imageCompress = value;
        emit(ImagePickerProfileResponsableStateGood());
      });
    }).catchError((e) {
      emit(ImagePickerProfileResponsableStateBad());
    });
  }

  String? linkProfileImg;
  Future<void> updateProfileImg() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCompress!.path).pathSegments.last}')
        .putFile(imageCompress!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkProfileImg = value;
        print(linkProfileImg);
        // emit(UploadProfileImgAndGetUrlStateGood());  //! bah matro7ch  LodingUpdateUserStateGood() t3 Widget LinearProgressIndicator
      }).catchError((e) {
        emit(UploadProfileResponsableImgAndGetUrlStateBad());
      });
    });
  }

// update Responsable
  Future<void> updateResponsable(
      {required String id, required String name, required String email}) async {
    emit(LodinUpdateResponsableState());

    if (imageCompress != null) {
      await updateProfileImg();
    }
    UserModel _model = UserModel(
      name: name,
      email: email,
      image: linkProfileImg ?? responsableModel!.image,
    );

    await DioHelper.putData(
            url: UPDATERESPONSABLE + id.toString(), data: _model.toMap())
        .then((value) {
      print('badalt info user');
      responsableModel = UserModel.fromJson(value.data);
      getCurrentResponsableInfo();
      emit(UpdateResponsableStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(UpdateResponsableStateBad(e.toString()));
    });
  }

  // !--------------------------------------------

// updateEtudiantResponsable
  Future<void> updateEtudiantResponsable({
    required String id,
    required String name,
    required String email,
  }) async {
    emit(LodinUpdateUserState());

    if (imageCompress != null) {
      await updateProfileImg();
    }
    UserModel _model = UserModel(
      name: name,
      email: email,
      image: linkProfileImg ?? etudiantModel!.data!.image,
    );

    // EtudientDetailsWithNote _modelEtudient = EtudientDetailsWithNote(
    //   data: _model,
    // );

    await DioHelper.putData(
            url: UPDATEUSER + id.toString(), data: _model.toMap())
        .then((value) async {
      print('badalt info Etudiant');
      print(value.data);
      await getEtudiantDetail(id: id);

      // await updateEtudiantNote(
      //   algo: algo,
      //   id: id,
      //   math: math,
      //   physique: physique,
      // );

      // getCurrentResponsableInfo();
      emit(UpdateUserStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(UpdateUserStateBad(e.toString()));
    });
  }

// updateEtudiantNote
  Future<void> updateEtudiantNote({
    required String id,
    required String module,
    required String intero,
    required String controle,
  }) async {
    emit(LodinUpdateUserNoteState());

    await DioHelper.putData(
        url: UPDATEMODULE + id.toString() + module,
        data: {'intero': intero, 'controle': controle}).then((value) async {
      print('badalt note Etudiant');
      await getEtudiantDetail(id: id);
      emit(UpdateUserNoteStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(UpdateUserNoteStateBad(e.toString()));
    });
  }

  bool mathVisibility = false;
  bool physiqueVisibility = false;
  bool algoVisibility = false;
  void mathchangeVisibility() {
    physiqueVisibility = false;
    algoVisibility = false;
    mathVisibility = !mathVisibility;
    emit(ChangeVisibilityState());
  }

  void physiquechangeVisibility() {
    mathVisibility = false;
    algoVisibility = false;
    physiqueVisibility = !physiqueVisibility;
    emit(ChangeVisibilityState());
  }

  void algochangeVisibility() {
    mathVisibility = false;
    physiqueVisibility = false;
    algoVisibility = !algoVisibility;
    emit(ChangeVisibilityState());
  }

  Future<void> getAllReclamation() async {
    emit(LodinGetAllReclamationState());
    await DioHelper.getData(url: GETALLRECLAMATION).then((value) {
      print('jabt Reclamation kml');
      reclamationModelList =
          []; //! bh y9der ydirl.ha add (ni chare7 3lh drt.ha Null fl commit t3 AAW_Flutter)
      for (var element in value.data) {
        reclamationModelList!.add(ReclamationModel.fromJson(element));
      }
      // print(reclamationModelList![0].text);
      emit(GetAllReclamationStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetAllReclamationStateBad(e.toString()));
    });
  }

  Future<void> updatereclamation({
    required bool isdone,
    String? id,
  }) async {
    emit(LodinUpdateReclamationState());

    await DioHelper.putData(
        url: UPDATERECLAMATION + id.toString(),
        data: {"done": isdone}).then((value) {
      print('badalt Reclamation');
      getAllReclamation();

      emit(UpdateReclamationStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(UpdateReclamationStateBad(e.toString()));
    });
  }

  deleteReclamation({required String id}) {
    emit(LodinDeleteReclamationState());

    DioHelper.deleteData(
      url: DELETERECLAMATION + id.toString(),
    ).then((value) {
      print('na7a Reclamation');

      getAllReclamation();
      emit(DeleteReclamationStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(DeleteReclamationStateBad(e.toString()));
    });
  }
}
