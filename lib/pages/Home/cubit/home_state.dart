part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeButtonNavStateGood extends HomeState {}

class LodinGetEtudiantsState extends HomeState {}

class GetOtherEtudiantsStateGood extends HomeState {}

class GetOtherEtudiantsStateBad extends HomeState {
  final e;

  GetOtherEtudiantsStateBad(this.e);
}

class LodinDeleteEtudiantState extends HomeState {}

class DeleteEtudiantStateGood extends HomeState {}

class DeleteEtudiantStateBad extends HomeState {
  final e;

  DeleteEtudiantStateBad(this.e);
}

class LodinGetUserDetailState extends HomeState {}

class GetUserDetailStateGood extends HomeState {}

class GetUserDetailStateBad extends HomeState {
  final e;

  GetUserDetailStateBad(this.e);
}

class LodinGetCurrentResponsableDetailState extends HomeState {}

class GetCurrentResponsableDetailStateGood extends HomeState {}

class GetCurrentResponsableDetailStateBad extends HomeState {
  final e;

  GetCurrentResponsableDetailStateBad(this.e);
}

class LodinUpdateResponsableState extends HomeState {}

// class GetCurrentResponsableDetailStateGood extends HomeState {}

// class GetCurrentResponsableDetailStateBad extends HomeState {
//   final e;

//   GetCurrentResponsableDetailStateBad(this.e);
// }

class ImagePickerProfileResponsableStateGood extends HomeState {}

class ImagePickerProfileResponsableStateBad extends HomeState {}

class UploadProfileResponsableImgAndGetUrlStateGood extends HomeState {}

class UploadProfileResponsableImgAndGetUrlStateBad extends HomeState {}

// class LodinUpdateUserState extends HomeState {}

class UpdateUserStateGood extends HomeState {}

class UpdateUserStateBad extends HomeState {
  final err;

  UpdateUserStateBad(this.err);
}
