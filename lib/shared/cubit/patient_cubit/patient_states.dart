abstract class PatientStates {}

class SignUpInitialState extends PatientStates {}

class RegisterPasswordShowState extends PatientStates {}

class ShowToastState extends PatientStates {}

//fire store
class PatientCreateFireStoreSuccessState extends PatientStates {}

class PatientCreateLoadingState extends PatientStates {}

class PatientCreateFireStoreErrorState extends PatientStates {
  final String error;

  PatientCreateFireStoreErrorState(this.error);
}

//register
class PatientRegisterSuccessState extends PatientStates {}

class PatientRegisterErrorState extends PatientStates {
  final String error;

  PatientRegisterErrorState(this.error);
}

//get patient  data
class GetPatientDataSuccessState extends PatientStates {}

class GetPatientDataErrorState extends PatientStates {
  final String error;

  GetPatientDataErrorState(this.error);
}

class GetPatientDataLoadingState extends PatientStates {}

//edit profile
class ProfilePatientImagePickedSuccessState extends PatientStates {}

class ProfilePatientImagePickedErrorState extends PatientStates {}

class CoverPatientImagePickedSuccessState extends PatientStates {}

class CoverPatientImagePickedErrorState extends PatientStates {}

class GetUrlProfilePatientImageErrorState extends PatientStates {}

class GetUrlProfilePatientImageSuccessState extends PatientStates {}

class UpdateProfilePatientImageErrorState extends PatientStates {}

class UpdateProfilePatientImageSuccessState extends PatientStates {}

class UpdateProfilePatientImageLoadingState extends PatientStates {}

class GetUrlCoverPatientImageErrorState extends PatientStates {}

class GetUrlCoverPatientImageSuccessState extends PatientStates {}

class UpdateCoverPatientImageErrorState extends PatientStates {}

class UpdateCoverPatientImageSuccessState extends PatientStates {}

class UpdateCoverPatientImageLoadingState extends PatientStates {}

class UpdatePatientProfileErrorState extends PatientStates {}

//get doctor data
class GetDoctorDataErrorState extends PatientStates {
  final String error;

  GetDoctorDataErrorState(this.error);
}

class GetDoctorDataSuccessState extends PatientStates {}

class GetDoctorDataLoadingState extends PatientStates {}

//get all user
class GetAllDoctorUsersDataLoadingState extends PatientStates {}

class GetAllDoctorUsersDataErrorState extends PatientStates {
  final String error;

  GetAllDoctorUsersDataErrorState(this.error);
}

class GetAllDoctorUsersDataSuccessState extends PatientStates {}

//send msg
class SendMSGLoadingState extends PatientStates {}

class SendMSGErrorState extends PatientStates {
  final String error;

  SendMSGErrorState(this.error);
}

class SendMSGSuccessState extends PatientStates {}

class GetMsgPatientLoadingState extends PatientStates {}

class GetMsgPatientDoneState extends PatientStates {}

// create post states
class PatientPostImagePickedSuccessState extends PatientStates {}

class PatientPostImagePickedErrorState extends PatientStates {}

class UploadPatientPostImageErrorState extends PatientStates {}

class UploadPatientPostImageSuccessState extends PatientStates {}

class UploadPatientPostLoadingState extends PatientStates {}

class UploadPatientPostErrorState extends PatientStates {}

class UploadPatientPostSuccessState extends PatientStates {}

class RemovePatientPostImage extends PatientStates {}

class LikesDoneState extends PatientStates {}

class GetPatientPostLoadingState extends PatientStates {}

class GetPatientPostErrorState extends PatientStates {
  final String error;

  GetPatientPostErrorState(this.error);
}

class GetPatientPostSuccessState extends PatientStates {}

class PatientPostLikesLoadingState extends PatientStates {}

class PatientPostLikesErrorState extends PatientStates {
  final String error;

  PatientPostLikesErrorState(this.error);
}

class PatientPostLikesSuccessState extends PatientStates {}



//post comment states
class PatientPostCommentLoadingState extends PatientStates {}

class PatientPostCommentErrorState extends PatientStates {
  final String error;

  PatientPostCommentErrorState(this.error);
}

class PatientPostCommentSuccessState extends PatientStates {}

class IsFollowingTrueState
extends PatientStates {}
class IsFollowingFalseState
    extends PatientStates {}
class CheckIsFollowingState
    extends PatientStates {}
