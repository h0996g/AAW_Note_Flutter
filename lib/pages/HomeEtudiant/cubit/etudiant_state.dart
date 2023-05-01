abstract class EtudiantState {}

class EtudiantInitial extends EtudiantState {}

class ChangeButtonNavStateGood extends EtudiantState {}

class LodinGetCurrentEtudiantDetailState extends EtudiantState {}

class GetCurrentEtudiantDetailStateGood extends EtudiantState {}

class GetCurrentEtudiantDetailStateBad extends EtudiantState {
  final e;

  GetCurrentEtudiantDetailStateBad(this.e);
}

class LodinUpdateEtudiantState extends EtudiantState {}

class UpdateEtudiantStateGood extends EtudiantState {}

class UploadProfileEtudiantImgAndGetUrlStateBad extends EtudiantState {}

class LodinAddReclamationState extends EtudiantState {}

class AddReclamationStateGood extends EtudiantState {}

class AddReclamationStateBad extends EtudiantState {
  final e;

  AddReclamationStateBad(this.e);
}

class LodinGetAllReclamationByIdState extends EtudiantState {}

class GetAllReclamationByIdStateGood extends EtudiantState {}

class GetAllReclamationByIdStateBad extends EtudiantState {
  final e;

  GetAllReclamationByIdStateBad(this.e);
}

class LodinDeleteReclamationState extends EtudiantState {}

class DeleteReclamationStateGood extends EtudiantState {}

class DeleteReclamationStateBad extends EtudiantState {
  final e;

  DeleteReclamationStateBad(this.e);
}

class ChangeStatDoneStateGood extends EtudiantState {}

class ChangeAnimatCommentStateGood extends EtudiantState {}
