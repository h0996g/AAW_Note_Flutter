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
