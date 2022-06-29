import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modeles/doctor_user_model.dart';
import 'package:doctorapp/modeles/msg_model.dart';
import 'package:doctorapp/modeles/patient_user_model.dart';
import 'package:doctorapp/modeles/post_model/post_model.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PatientCubit extends Cubit<PatientStates> {
  PatientCubit() : super(SignUpInitialState());

  static PatientCubit get(context) => BlocProvider.of(context);
  PatientUserModel? patientUserModel;

//sign up register throw firebase
  patientSignUp(
      {required email,
      required password,
      required gender,
      required name,
      required country,
      required phone,
      required bloodType,
      required chronicDiseases}) {
    emit(PatientCreateLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      patientRegisterFireStore(
        country: country,
        gender: gender,
        password: password,
        email: email,
        uid: value.user?.uid,
        phone: phone,
        bloodType: bloodType,
        userName: name,
        chronicDiseases: chronicDiseases,
      );
      emit(PatientRegisterSuccessState());
    }).catchError((onError) {
      emit(PatientRegisterErrorState(onError.toString()));
    });
  }

  //fireStore cloud  of patient
  patientRegisterFireStore(
      {required chronicDiseases,
      required email,
      required phone,
      required userName,
      required bloodType,
      required password,
      required gender,
      required uid,
      required country}) {
    emit(PatientCreateLoadingState());
// patient Model
    PatientUserModel patientModel = PatientUserModel(
      image:
          'https://img.freepik.com/free-vector/doctor-examining-patient-clinic-illustrated_23-2148856559.jpg?t=st=1647972672~exp=1647973272~hmac=a56d8ab59684ead057bcf471ecc9fdbd51ac4ef07aecb5760ea807fed4a9baec&w=740',
      email: email,
      bio: 'Write Your bio ...',
      chronicDiseases: chronicDiseases,
      bloodType: bloodType,
      userName: userName,
      password: password,
      phone: phone,
      country: country,
      cover:
          'https://img.freepik.com/free-vector/doctor-patient-medical-concept-hospital-patient-lying-hospital-bed_1150-50285.jpg?t=st=1650400867~exp=1650401467~hmac=811754f02141e38752f0e7e98ba0461fd0b4e2d9db5b924f65a579426c202ee3&w=740',
      uID: uid,
      gender: gender,
    );
    FirebaseFirestore.instance
        .collection("Patient")
        .doc(uid)
        .set(patientModel.toMap())
        .then((value) {})
        .catchError((onError) {
      emit(PatientCreateFireStoreErrorState(onError.toString()));
    });
  }

  //password Visibility
  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPasswordShowState());
  }

  //get data of patient from firebase
  void getPatientData() {
    emit(GetPatientDataLoadingState());

    FirebaseFirestore.instance
        .collection('Patient')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      //get data from firebase throw fromJson
      patientUserModel = PatientUserModel.fromJson(value.data()!);
      print(FirebaseAuth.instance.currentUser?.uid);
      print('-----------------');
      print(value.data());
      emit(GetPatientDataSuccessState());
    }).catchError((onError) {
      print('___________________________________________');
      print(onError.toString());
      emit(GetPatientDataErrorState(onError.toString()));
    });
  }

//pick Profile photo
  File? profileImage;
  var imagePicker = ImagePicker();

  Future<void> getProfileImage() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(ProfilePatientImagePickedSuccessState());
    } else {
      emit(ProfilePatientImagePickedErrorState());

      print('error in profile image pick');
    }
  }

  //pick Cover photo
  File? coverImage;
  var coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    //open imageSource (gallery , camera ,.....)
    XFile? pickedImage =
        await coverPicker.pickImage(source: ImageSource.gallery);
    //get photo from gallery

    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(CoverPatientImagePickedSuccessState());
    } else {
      emit(CoverPatientImagePickedErrorState());

      print('error in profile image pick');
    }
  }

  String? profileImageUrl;

//upload and update profile image to fire storage
  updateProfileImage({required phone, required bio, required name}) async {
    //upload image to fire Storage
    emit(UpdateProfilePatientImageLoadingState());
    await FirebaseStorage.instance
        .ref('profileImagePatient')
        .child(
            'profileImagePatient ${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      // emit(UpdateProfileImageSuccessState());
      //to get the url of image
      await value.ref.getDownloadURL().then((value) {
        //get url
        profileImageUrl = value;
        updateProfile(
            name: name, bio: bio, phone: phone, profileImage: profileImageUrl);

        emit(UpdateProfilePatientImageSuccessState());

        // emit(GetUrlProfileImageSuccessState());
      })
          //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlProfilePatientImageErrorState());
      });
    })
        //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading profile image $onError ');
      print('--------------------------');
      emit(UpdateProfilePatientImageErrorState());
    });
  }

  String? coverImageUrl;

//upload  and update cover image to fire storage
  updateCoverImage({required phone, required bio, required name}) {
    //upload cover image to fire Storage
    emit(UpdateCoverPatientImageLoadingState());
    FirebaseStorage.instance
        .ref('coverImagePatient')
        .child(
            'coverImagePatient ${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      //to get the url of cover image
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;

        updateProfile(
            name: name, bio: bio, phone: phone, coverImage: coverImageUrl);
        emit(UpdateCoverPatientImageSuccessState());
      })
          //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlCoverPatientImageErrorState());
      });
    })
        //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading cover image $onError ');
      print('--------------------------');
      emit(UpdateCoverPatientImageErrorState());
    });
  }

//update data in fire base
  updateProfile(
      {required name,
      required phone,
      required bio,
      String? profileImage,
      String? coverImage}) {
    PatientUserModel patientModel = PatientUserModel(
      cover: coverImage ?? patientUserModel!.cover,
      phone: phone,
      image: profileImage ?? patientUserModel!.image,
      bio: bio,
      email: patientUserModel!.email,
      uID: patientUserModel?.uID,
      gender: patientUserModel!.gender,
      userName: name,
      bloodType: patientUserModel!.bloodType,
      country: patientUserModel!.country,
      chronicDiseases: patientUserModel!.chronicDiseases,
      password: patientUserModel!.password,
    );
    FirebaseFirestore.instance
        .collection('Patient')
        .doc(patientModel.uID)
        .update(patientModel.toMap())
        .then((value) {
      getPatientData();
    }).catchError((onError) {
      print('Error in update in fire store $onError ');
      print('--------------------------');
      emit(UpdatePatientProfileErrorState());
    });
  }

  DoctorUserModel? doctorUserModel;
  List<DoctorUserModel> allDoctorUsers = [];

  //get data of doctor from firebase
  void getDoctorData() {
    emit(GetDoctorDataLoadingState());

    FirebaseFirestore.instance
        .collection('Doctor')
        .doc()
        .get()
        .then((value) {
      //get data from firebase throw fromJson
      doctorUserModel = DoctorUserModel.fromJson(value.data()!);
      print(FirebaseAuth.instance.currentUser?.uid);
      print('-----------------');
      print(value.data());
      emit(GetDoctorDataSuccessState());
    }).catchError((onError) {
      print('___________________________________________');
      print(onError.toString());
      emit(GetDoctorDataErrorState(onError.toString()));
    });
  }

  getAllDoctorUsers() {
    if (allDoctorUsers.isEmpty) {
      emit(GetAllDoctorUsersDataLoadingState());

      FirebaseFirestore.instance.collection('Doctor').get().then((value) {
        value.docs.forEach((element) {
//to remove doctors  acc from list
          if (element.data()['uID'] != patientUserModel?.uID)
            allDoctorUsers.add(DoctorUserModel.fromJson(element.data()));
          emit(GetAllDoctorUsersDataSuccessState());
        });
      }).catchError((onError) {
        emit(GetAllDoctorUsersDataErrorState(onError.toString()));
      });
    }
  }

  MsgModel? msgModel;

  //get msg
  sendMSG({required receiverID, required text, required dateTime}) {
    emit(SendMSGLoadingState());
    MsgModel msgModel = MsgModel(
        senderID: FirebaseAuth.instance.currentUser!.uid,
        text: text,
        dateTime: dateTime,
        receiverID: receiverID);
//set my chats
    FirebaseFirestore.instance
        .collection('Patient')
        .doc(patientUserModel?.uID)
        .collection('chats')
        .doc(receiverID)
        .collection('MSG')
        .add(msgModel.toMap())
        .then((value) {
      emit(SendMSGSuccessState());
    }).catchError((onError) {
      emit(SendMSGErrorState(onError.toString()));
    });

    //set receiverID chats

    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(receiverID)
        .collection('chats')
        .doc(patientUserModel?.uID)
        .collection('MSG')
        .add(msgModel.toMap())
        .then((value) {
      emit(SendMSGSuccessState());
    }).catchError((onError) {
      emit(SendMSGErrorState(onError.toString()));
    });
  }

  //get message
  //list of msages to put all msg in it
  List<MsgModel> getMSG = [];

  getMSGFun({required receiverID}) {
    FirebaseFirestore.instance
        .collection('Patient')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('chats')
        .doc(receiverID)
        .collection('MSG')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      emit(GetMsgPatientLoadingState());
//listen in every time receive all data again so  you should make list empty
      getMSG = [];
      event.docs.forEach((element) {
        getMSG.add(MsgModel.fromJson(element.data()));
        emit(GetMsgPatientDoneState());
      });
    });
  }

  //pick postImage

  File? postImage;
  var pickPatientPostImage = ImagePicker();

  Future<void> getPatientPostImage() async {
    //open imageSource (gallery , camera ,.....)
    XFile? pickedProfileImage =
        await pickPatientPostImage.pickImage(source: ImageSource.gallery);
    //get photo from gallery

    if (pickedProfileImage != null) {
      postImage = File(pickedProfileImage.path);
      emit(PatientPostImagePickedSuccessState());
    } else {
      emit(PatientPostImagePickedErrorState());

      print('error in post image pick');
    }
  }

  //get post image url and upload it
  String? postImageUrl;

  uploadPatientPostImage({required image, required text, required dateTime}) {
    //UploadPatientPost image to fire Storage
    emit(UploadPatientPostLoadingState());
    FirebaseStorage.instance
        .ref('postImage')
        .child('postImage ${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      //to get the url of cover image
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;

        addPatientPost(postImage: postImageUrl, text: text, dateTime: dateTime);
        emit(UploadPatientPostImageSuccessState());
      })
          //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(UploadPatientPostImageErrorState());
      });
    })
        //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading cover image $onError ');
      print('--------------------------');
      emit(UploadPatientPostImageErrorState());
    });
  }

  //addPatientPost
  addPatientPost({required text, String? postImage, required dateTime}) {
    emit(UploadPatientPostLoadingState());

    PostModel userPatientPostModel = PostModel(
      dateTime: dateTime,
      postImage: postImage ?? '',
      uID: patientUserModel!.uID!,
      postText: text,
      userImage: patientUserModel!.image,
      name: patientUserModel!.userName!,
      likes: [],
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(userPatientPostModel.toMap())
        .then((value) {
      emit(UploadPatientPostSuccessState());
    }).catchError((onError) {
      emit(UploadPatientPostErrorState());
    });
  }

  removePatientPostImage() {
    postImage = null;
    emit(RemovePatientPostImage());
  }

  //get post
  List<Map<String, PostModel>> postsList = [];

//   // list of post model to put data in it
  List<PostModel> getPosts = [];

  getPostsMethod() {
    FirebaseFirestore.instance.collection('post').snapshots().listen((event) {
      //listen in every time receive all data again so  you should make list empty
      postsList = [];
      for (var element in event.docs) {
        postsList
            .add({element.reference.id: PostModel.fromJson(element.data())});
        getPosts.add(PostModel.fromJson(element.data()));
      }

      debugPrint(postsList.length.toString());

      emit(GetPatientPostSuccessState());
    });
  }

  void updatePostLikes(Map<String, PostModel> post) {
    if (post.values.single.likes!
        .any((element) => element == FirebaseAuth.instance.currentUser?.uid)) {
      debugPrint('exist and remove');

      post.values.single.likes?.removeWhere((element) {
        return element == FirebaseAuth.instance.currentUser?.uid;
      });
    } else {
      debugPrint('not exist and add');

      post.values.single.likes!.add(FirebaseAuth.instance.currentUser!.uid);
    }

    FirebaseFirestore.instance
        .collection('post')
        .doc(post.keys.single)
        .update(post.values.single.toMap())
        .then((value) {
      emit(PatientPostLikesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(PatientPostLikesErrorState(
        error.toString(),
      ));
    });
  }

//follow and unfollow
  bool isFollowing = false;

//follow method
  followMethod({
    required doctorUserUid,
    required patientUid,
    required docName,
    required patName,
  }) {
    isFollowing = true;
    emit(IsFollowingTrueState());
    //of fllowing
    FirebaseFirestore.instance
        .collection(" followers")
        .doc(doctorUserUid)
        .collection('User followers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({});
    //of followers
    FirebaseFirestore.instance
        .collection(" followers")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('User followers')
        .doc(doctorUserUid)
        .set({});

    FirebaseFirestore.instance
        .collection("Doctor")
        .doc(doctorUserUid)
        .collection('Follow')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      'current User name': docName,
      'Patient User name': patName,
      'current User uID': doctorUserUid,
      'patient UID': patientUid
    });
  }

//unfollow method

  unFollowMethod({
    required doctorUserUid,
    required patientUid,
  }) {
    isFollowing = false;
    emit(IsFollowingFalseState());
    //of fllowing
    FirebaseFirestore.instance
        .collection(" followers")
        .doc(doctorUserUid)
        .collection('User followers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        // to delete the doc
        value.reference.delete();
      }
    });
    //of followers
    FirebaseFirestore.instance
        .collection(" followers")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('User followers')
        .doc(doctorUserUid)
        .get()
        .then((value) {
      if (value.exists) {
        // to delete the doc
        value.reference.delete();
      }
    });
    FirebaseFirestore.instance
        .collection("Doctor")
        .doc(doctorUserUid)
        .collection('Follow')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        // to delete the doc
        value.reference.delete();
      }
    });
  }


}
