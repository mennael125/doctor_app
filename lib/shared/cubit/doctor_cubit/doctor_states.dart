abstract class DoctorStates {}

class SignUpInitialState extends DoctorStates {}

class RegisterPasswordShowState extends DoctorStates {}


class ShowToastState extends DoctorStates {}
//fire store
class DoctorCreateFireStoreSuccessState extends DoctorStates {}

class DoctorCreateLoadingState extends DoctorStates {}

class DoctorCreateFireStoreErrorState extends DoctorStates {
  final String error;

  DoctorCreateFireStoreErrorState(this.error);


}
//register
class DoctorRegisterSuccessState extends DoctorStates {}

class DoctorRegisterErrorState extends DoctorStates {
  final String error;

  DoctorRegisterErrorState(this.error);


}

class IdDoctorImagePickedSuccessState extends DoctorStates {}

class IdDoctorImagePickedErrorState extends DoctorStates {
}

class UploadIdDoctorImageErrorState extends DoctorStates {}

class GetUrlIdDoctorImageErrorState extends DoctorStates {}

class UploadIdDoctorImageSuccessState extends DoctorStates {
}

class UploadIdDoctorImageLoadingState extends DoctorStates {
}

//get doctor data
  class GetDoctorDataSuccessState extends DoctorStates{}
  class GetDoctorDataErrorState extends DoctorStates{
  final String error;

  GetDoctorDataErrorState(this.error);


  }
  class GetDoctorDataLoadingState extends DoctorStates{}

//edit profile
  class ProfileDoctorImagePickedSuccessState extends DoctorStates {}

  class ProfileDoctorImagePickedErrorState extends DoctorStates {}

  class CoverDoctorImagePickedSuccessState extends DoctorStates {}

  class CoverDoctorImagePickedErrorState extends DoctorStates {}

  class GetUrlProfileDoctorImageErrorState extends DoctorStates {}

  class GetUrlProfileDoctorImageSuccessState extends DoctorStates {}

  class UpdateProfileDoctorImageErrorState extends DoctorStates {}

  class UpdateProfileDoctorImageSuccessState extends DoctorStates {}

  class UpdateProfileDoctorImageLoadingState extends DoctorStates {}

  class GetUrlCoverDoctorImageErrorState extends DoctorStates {}

  class GetUrlCoverDoctorImageSuccessState extends DoctorStates {}

  class UpdateCoverDoctorImageErrorState extends DoctorStates {}

  class UpdateCoverDoctorImageSuccessState extends DoctorStates {}

  class UpdateCoverDoctorImageLoadingState extends DoctorStates {}

  class UpdateDoctorProfileErrorState extends DoctorStates {}

// create post states
  class DoctorPostImagePickedSuccessState extends DoctorStates {}

  class DoctorPostImagePickedErrorState extends DoctorStates {}

  class UploadDoctorPostImageErrorState extends DoctorStates {}

  class UploadDoctorPostImageSuccessState extends DoctorStates {}

  class UploadDoctorPostLoadingState extends DoctorStates {}

  class UploadDoctorPostErrorState extends DoctorStates {}

  class UploadDoctorPostSuccessState extends DoctorStates {}

  class RemoveDoctorPostImage extends DoctorStates {}

  class GetDoctorPostLoadingState extends DoctorStates {}

  class GetDoctorPostErrorState extends DoctorStates {
  final String error;

  GetDoctorPostErrorState(this.error);
  }

  class GetDoctorPostSuccessState extends DoctorStates {}

//get patient  data
  class GetPatientDataSuccessState extends DoctorStates{}
  class GetPatientDataErrorState extends DoctorStates{
  final String error;

  GetPatientDataErrorState(this.error);


  }
  class GetPatientDataLoadingState extends DoctorStates{}


//get all user
  class GetAllPatientUsersDataLoadingState extends DoctorStates {}

  class GetAllPatientUsersDataErrorState extends DoctorStates {
  final String error;

  GetAllPatientUsersDataErrorState(this.error);
  }

  class GetAllPatientUsersDataSuccessState extends DoctorStates {}

//send msg
  class SendMSGLoadingState extends DoctorStates {}

  class SendMSGErrorState extends DoctorStates {
  final String error;

  SendMSGErrorState(this.error);
  }

  class SendMSGSuccessState extends DoctorStates {}
  class GetMsgDoctorLoadingState extends DoctorStates {}
  class GetMsgDoctorDoneState extends DoctorStates {}


//post like states
  class DoctorPostLikesLoadingState extends DoctorStates {}

  class DoctorPostLikesErrorState extends DoctorStates {
  final String error;

  DoctorPostLikesErrorState(this.error);
  }
  class LikesDoneState extends DoctorStates {}

  class DoctorPostLikesSuccessState extends DoctorStates {}

class IsFollowingTrueState
    extends DoctorStates {}
class IsFollowingFalseState
    extends DoctorStates {}

//
// class PostUpdatedShareSuccess extends DoctorStates {}
// class PostUpdatedShareError extends DoctorStates { final String error;
//
// PostUpdatedShareError(this.error);}

// //post comment states
//   class DoctorPostCommentLoadingState extends DoctorStates {}
//
//   class DoctorPostCommentErrorState extends DoctorStates {
//   final String error;
//
//   DoctorPostCommentErrorState(this.error);
//   }

  // class DoctorPostCommentSuccessState extends DoctorStates {}
// //add comments
//   class UploadDoctorCommentLoadingState extends DoctorStates {}
//   class UploadDoctorCommentSuccessState extends DoctorStates {}
//   class UploadDoctorCommentErrorState extends DoctorStates {
//   final String error;
//
//   UploadDoctorCommentErrorState(this.error);
//   }
