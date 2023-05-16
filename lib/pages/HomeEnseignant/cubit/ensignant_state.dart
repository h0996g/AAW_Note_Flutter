abstract class EnsignantState {}

class EnsignantInitial extends EnsignantState {}

class ChangeButtonNavStateGood extends EnsignantState {}

class LodinGetCurrentEnsignantDetailState extends EnsignantState {}

class GetCurrentEnsignantDetailStateGood extends EnsignantState {}

class GetCurrentEnsignantDetailStateBad extends EnsignantState {
  final e;

  GetCurrentEnsignantDetailStateBad(this.e);
}

class LodinUpdateEnsignantState extends EnsignantState {}

class UpdateEnsignantStateGood extends EnsignantState {}

class UploadProfileEnsignantImgAndGetUrlStateBad extends EnsignantState {}

class LodinAddReclamationState extends EnsignantState {}

class AddReclamationStateGood extends EnsignantState {}

class AddReclamationStateBad extends EnsignantState {
  final e;

  AddReclamationStateBad(this.e);
}

class LodinGetAllReclamationByIdState extends EnsignantState {}

class GetAllReclamationByIdStateGood extends EnsignantState {}

class GetAllReclamationByIdStateBad extends EnsignantState {
  final e;

  GetAllReclamationByIdStateBad(this.e);
}

class LodinDeleteReclamationState extends EnsignantState {}

class DeleteReclamationStateGood extends EnsignantState {}

class DeleteReclamationStateBad extends EnsignantState {
  final e;

  DeleteReclamationStateBad(this.e);
}

class ChangeStatDoneStateGood extends EnsignantState {}

class ChangeAnimatCommentStateGood extends EnsignantState {}
