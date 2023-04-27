import 'package:affichage/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dio/dioHalper.dart';
import '../../../../models/registerModel.dart';
import '../../../../models/userModel.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isvisibility = false;
  int selectedIndex = 0;
  RegisterAndLoginModel? model;

  List<String> pathLoginList = ['Etudient', 'Ensiengnant', 'Responsable'];
  String pathLogin = 'Etudient';
  void showPassword() {
    isvisibility = !isvisibility;
    emit(ShowPasswordState());
  }

  void changeTogel(index) {
    selectedIndex = index;
    pathLogin = pathLoginList[index];
    print(pathLogin);
    emit(ChangeIndexStateGood());
  }

  void loginUser({required String email, required String password}) {
    emit(LodinLoginUserState());
    EtudientModel _userModel = EtudientModel(email: email, password: password);
    DioHelper.postData(url: LOGIN + pathLogin, data: _userModel.toMap())
        .then((value) {
      print('Dkhol');
      model = RegisterAndLoginModel.fromjson(value.data);
      print(model!.token);
      // userModelList.add(UserModel.fromJson(value.data));
      emit(LoginUserStateGood(model!.token));
    }).catchError((e) {
      print(e.toString());
      emit(LoginUserStateBad(e.toString()));
    });
  }
}
