import 'package:affichage/models/reclamationModel.dart';
import 'package:affichage/pages/Etudiant/affichage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dio/dioHalper.dart';
import '../../../models/EtudientDetailsWithNote.dart';
import '../../../models/userModel.dart';
import '../../../shared/components/constants.dart';
import '../../Etudiant/Reclamation.dart';
import '../../Etudiant/profile.dart';
import 'ensignant_state.dart';

class EtudiantCubit extends Cubit<EnsignantState> {
  EtudiantCubit() : super(EnsignantInitial());
  static EtudiantCubit get(context) => BlocProvider.of(context);
  List<UserModel>? etudiantModelList;
  EtudientDetailsWithNote? etudiantModel;
  List<ReclamationModel>? reclamationByIdModelList;
  ReclamationModel? reclamationByIdModel;
  bool? isDone;
  bool iswriteComment = false;

  int currentIndex = 0;
  List<Widget> userScreen = [
    const Affichage(),
    Reclamation(),
    const ProfileEtudiant(),
  ];
  List<String> appbarScreen = const [
    'Affichage',
    'Reclamation',
    'Profile',
  ];
  void resetValueWhenelogout() {
    currentIndex = 0;
    etudiantModelList = null;
    etudiantModel = null;
    reclamationByIdModelList = null;
    reclamationByIdModel = null;
    iswriteComment = false;
  }

  changeButtonNav(int currentIndex) {
    this.currentIndex = currentIndex;
    emit(ChangeButtonNavStateGood());
  }

  void writeComment(bool state) {
    iswriteComment = state;
    emit(ChangeAnimatCommentStateGood());
  }

  void changeStateDone(bool state) {
    isDone = state;
    emit(ChangeStatDoneStateGood());
  }

  Future<void> getCurrentEtudiantInfo() async {
    emit(LodinGetCurrentEnsignantDetailState());

    await DioHelper.getData(
      url: GETUSERDETAIL + DECODEDTOKEN['_id'].toString(),
    ).then((value) {
      print('get current user');
      print(DECODEDTOKEN['_id'].toString());
      etudiantModel = EtudientDetailsWithNote.fromJson(value.data);
      print(etudiantModel!.data);
      emit(GetCurrentEnsignantDetailStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetCurrentEnsignantDetailStateBad(e.toString()));
    });
  }

  void addreclamation(
      {String? title, String? text, String? module, String? id}) {
    emit(LodinAddReclamationState());

    DioHelper.postData(url: ADDRECLAMATION, data: {
      "title": title,
      "text": text,
      "module": module,
      "userowner": DECODEDTOKEN['_id'].toString()
    }).then((value) {
      print('Add Reclamation');
      getAllReclamationById();
      emit(AddReclamationStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(AddReclamationStateBad(e.toString()));
    });
  }

  Future<void> getAllReclamationById() async {
    emit(LodinGetAllReclamationByIdState());
    await DioHelper.getData(
            url: GETALLRECLAMATIONBYID + DECODEDTOKEN['_id'].toString())
        .then((value) {
      print('jabt Reclamation kml by Id');
      reclamationByIdModelList =
          []; //! bh y9der ydirl.ha add (ni chare7 3lh drt.ha Null fl commit t3 AAW_Flutter)
      for (var element in value.data) {
        reclamationByIdModelList!.add(ReclamationModel.fromJson(element));
      }
      // print(reclamationModelList![0].text);
      emit(GetAllReclamationByIdStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetAllReclamationByIdStateBad(e.toString()));
    });
  }

  void deleteReclamation({required String id}) {
    emit(LodinDeleteReclamationState());

    DioHelper.deleteData(
      url: DELETERECLAMATION + id.toString(),
    ).then((value) {
      print('na7a Reclamation');

      getAllReclamationById();
      emit(DeleteReclamationStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(DeleteReclamationStateBad(e.toString()));
    });
  }
}
