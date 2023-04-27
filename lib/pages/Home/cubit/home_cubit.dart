import 'package:affichage/pages/Responsable/Etudients.dart';
import 'package:affichage/pages/Responsable/Reclamation.dart';
import 'package:affichage/pages/Responsable/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dio/dioHalper.dart';
import '../../../models/EtudientDetailsWithNote.dart';
import '../../../models/userModel.dart';
import '../../../shared/components/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<UserModel>? etudiantModelList;
  EtudientDetailsWithNote? etudiantModel;
  int currentIndex = 0;
  List<Widget> userScreen = [
    const Reclamation(),
    Etudiants(),
    const ProfileResponsable(),
  ];
  List<String> appbarScreen = const [
    'Reclamation',
    'Etudiants',
    'Profile',
  ];
  changeButtonNav(int currentIndex) {
    this.currentIndex = currentIndex;
    emit(ChangeButtonNavStateGood());
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
  void getEtudiantDetail({required String id}) {
    emit(LodinGetUserDetailState());

    DioHelper.getData(
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
}
