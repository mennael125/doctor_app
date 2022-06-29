import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modeles/doctor_user_model.dart';
import 'package:doctorapp/modeles/msg_model.dart';
import 'package:doctorapp/modeles/patient_user_model.dart';
import 'package:doctorapp/modeles/post_model/post_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'doctor_states.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  DoctorCubit() : super(SignUpInitialState());

  static DoctorCubit get(context) => BlocProvider.of(context);
  DoctorUserModel? doctorUserModel;

//pick id photo
  File? idDoctorImage;
  var idPicker = ImagePicker();

  Future<void> getIdDoctorImage() async {
    XFile? pickedImage = await idPicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      idDoctorImage = File(pickedImage.path);
      emit(IdDoctorImagePickedSuccessState());
    } else {
      emit(IdDoctorImagePickedErrorState());

      print('error in profile image pick');
    }
  }

  String? idDoctorImageUrl;

//upload id image to fire storage
  uploadIdImage() async {
    //upload image to fire Storage
    emit(UploadIdDoctorImageLoadingState());
    await FirebaseStorage.instance
        .ref('IdImageDoctor')
        .child(
        'IdImageDoctor ${Uri
            .file(idDoctorImage!.path)
            .pathSegments
            .last}')
        .putFile(idDoctorImage!)
        .then((value) async {
      // emit(UpdateProfileImageSuccessState());
      //to get the url of image
      await value.ref.getDownloadURL().then((value) {
        //get url
        idDoctorImageUrl = value;

        emit(UploadIdDoctorImageSuccessState());

        // emit(GetUrlProfileImageSuccessState());
      })
      //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlIdDoctorImageErrorState());
      });
    })
    //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading id image $onError ');
      print('--------------------------');
      emit(UploadIdDoctorImageErrorState());
    });
  }

//sign up register throw firebase
  doctorSignUp({required email,
    required password,
    required gender,
    required specialization,
    required name,
    required country,
    required phone,
    required clinicLocation,
    required scientificDegree}) {
    emit(DoctorCreateLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      doctorRegisterFireStore(
          country: country,
          gender: gender,
          specialization: specialization,
          name: name,
          password: password,
          email: email,
          idDoctorImage: idDoctorImageUrl,
          uid: value.user!.uid,
          phone: phone,
          clinicLocation: clinicLocation,
          scientificDegree: scientificDegree);

      emit(DoctorRegisterSuccessState());
    }).catchError((onError) {
      emit(DoctorRegisterErrorState(onError.toString()));
      print(onError.toString());
      print('+___________________________________________________________');
    });
  }

  //fireStore cloud  of doctor
  doctorRegisterFireStore({required name,
    required email,
    required phone,
    required clinicLocation,
    required specialization,
    required scientificDegree,
    required password,
    required gender,
    required uid,
    required idDoctorImage,
    required country}) async {
    emit(DoctorCreateLoadingState());
// DC Model
    DoctorUserModel doctorUserModel = DoctorUserModel(
      uID: uid,
      userName: name,
      email: email,
      password: password,
      phone: phone,
      country: country,
      bio: 'Write your bio....',
      clinicLocation: clinicLocation,
      specialization: specialization,
      image:
      'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?t=st=1647954850~exp=1647955450~hmac=4245fd6d0e7b6dadbe385080750a5a1388442957d00b6a0f7b915e2fb069f426&w=740',
      scientificDegree: scientificDegree,
      cover:
      'https://img.freepik.com/free-vector/frontline-heroes-illustration-doctors-nurses-characters-wearing-masks_218660-64.jpg?w=826',
      gender: gender,
      idDoctorImage: idDoctorImageUrl,
    );
    await FirebaseFirestore.instance
        .collection("Doctor")
        .doc(uid)
        .set(doctorUserModel.toMap())
        .then((value) {})
        .catchError((onError) {
      emit(DoctorCreateFireStoreErrorState(onError.toString()));
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

  //get data of doctor from firebase
  Future<void> getDoctorData() async {
    emit(GetDoctorDataLoadingState());

    await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(FirebaseAuth.instance.currentUser?.uid)
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

//pick Profile photo
  File? profileImage;
  var imagePicker = ImagePicker();

  Future<void> getProfileImage() async {
    XFile? pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(ProfileDoctorImagePickedSuccessState());
    } else {
      emit(ProfileDoctorImagePickedErrorState());

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
      emit(CoverDoctorImagePickedSuccessState());
    } else {
      emit(CoverDoctorImagePickedErrorState());

      print('error in profile image pick');
    }
  }

  String? profileImageUrl;

//upload and update profile image to fire storage
  updateProfileImage(
      {required phone, required bio, required name, required clinicLoc}) async {
    //upload image to fire Storage
    emit(UpdateProfileDoctorImageLoadingState());
    await FirebaseStorage.instance
        .ref('profileImageDoctor')
        .child(
        'profileImageDoctor ${Uri
            .file(profileImage!.path)
            .pathSegments
            .last}')
        .putFile(profileImage!)
        .then((value) async {
      // emit(UpdateProfileImageSuccessState());
      //to get the url of image
      await value.ref.getDownloadURL().then((value) {
        //get url
        profileImageUrl = value;
        updateProfile(
            name: name,
            bio: bio,
            phone: phone,
            profileImage: profileImageUrl,
            clinicLoc: clinicLoc);

        emit(UpdateProfileDoctorImageSuccessState());

        // emit(GetUrlProfileImageSuccessState());
      })
      //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlProfileDoctorImageErrorState());
      });
    })
    //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading profile image $onError ');
      print('--------------------------');
      emit(UpdateProfileDoctorImageErrorState());
    });
  }

  String? coverImageUrl;

//upload  and update cover image to fire storage
  updateCoverImage(
      {required phone, required bio, required name, required clinicLoc}) {
    //upload cover image to fire Storage
    emit(UpdateCoverDoctorImageLoadingState());
    FirebaseStorage.instance
        .ref('coverImageDoctor')
        .child(
        'coverImageDoctor ${Uri
            .file(coverImage!.path)
            .pathSegments
            .last}')
        .putFile(coverImage!)
        .then((value) {
      //to get the url of cover image
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;

        updateProfile(
          name: name,
          bio: bio,
          phone: phone,
          coverImage: coverImageUrl,
          clinicLoc: clinicLoc,
        );
        emit(UpdateCoverDoctorImageSuccessState());
      })
      //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlCoverDoctorImageErrorState());
      });
    })
    //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading cover image $onError ');
      print('--------------------------');
      emit(UpdateCoverDoctorImageErrorState());
    });
  }

//update data in fire base
  //////////////////////////////////////////////
  updateProfile({required name,
    required phone,
    required bio,
    required clinicLoc,
    String? profileImage,
    String? coverImage}) async {
    DoctorUserModel docModel = DoctorUserModel(
      cover: coverImage ?? doctorUserModel!.cover,
      phone: phone,
      image: profileImage ?? doctorUserModel!.image,
      bio: bio,
      email: doctorUserModel!.email,
      uID: doctorUserModel?.uID,
      gender: doctorUserModel!.gender,
      userName: name,
      country: doctorUserModel!.country,
      clinicLocation: clinicLoc,
      password: doctorUserModel!.password,
      specialization: doctorUserModel!.specialization,
      scientificDegree: doctorUserModel!.scientificDegree,
      idDoctorImage: '',
    );
    await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(docModel.uID)
        .update(docModel.toMap())
        .then((value) {
      getDoctorData();
    }).catchError((onError) {
      print('Error in update in fire store $onError ');
      print('--------------------------');
      emit(UpdateDoctorProfileErrorState());
    });
  }

  //pick postImage

  File? postImage;
  var pickDoctorPostImage = ImagePicker();

  Future<void> getDoctorPostImage() async {
    //open imageSource (gallery , camera ,.....)
    XFile? pickedProfileImage =
    await pickDoctorPostImage.pickImage(source: ImageSource.gallery);
    //get photo from gallery

    if (pickedProfileImage != null) {
      postImage = File(pickedProfileImage.path);
      emit(DoctorPostImagePickedSuccessState());
    } else {
      emit(DoctorPostImagePickedErrorState());

      print('error in post image pick');
    }
  }

  //get post image url and upload it
  String? postImageUrl;

  uploadDoctorPostImage({required image, required text, required dateTime}) {
    //UploadDoctorPost image to fire Storage
    emit(UploadDoctorPostLoadingState());
    FirebaseStorage.instance
        .ref('postImage')
        .child('postImage ${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      //to get the url of cover image
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;

        addDoctorPost(postImage: postImageUrl, text: text, dateTime: dateTime);
        emit(UploadDoctorPostImageSuccessState());
      })
      //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(UploadDoctorPostImageErrorState());
      });
    })
    //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading cover image $onError ');
      print('--------------------------');
      emit(UploadDoctorPostImageErrorState());
    });
  }

  //addDoctorPost
  addDoctorPost({required text, String? postImage, required dateTime}) async {
    emit(UploadDoctorPostLoadingState());

    PostModel userDoctorPostModel = PostModel(
      dateTime: dateTime,
      postImage: postImage ?? '',
      uID: doctorUserModel!.uID!,
      postText: text,
      userImage: doctorUserModel!.image,
      name: doctorUserModel!.userName!,
      likes: [],
    );
    await FirebaseFirestore.instance
        .collection('post')
        .add(userDoctorPostModel.toMap())
        .then((value) {
      emit(UploadDoctorPostSuccessState());
    }).catchError((onError) {
      emit(UploadDoctorPostErrorState());
    });
  }

  removeDoctorPostImage() {
    postImage = null;
    emit(RemoveDoctorPostImage());
  }

  PatientUserModel? patientUserModel;

//get all  Patient users
  List<PatientUserModel> allPatientUsers = [];

  //get data of patient from firebase
  Future<void> getPatientData() async {
    emit(GetPatientDataLoadingState());

    await FirebaseFirestore.instance
        .collection('Patient')
        .doc()
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

  getAllPatientUsers() async {
    if (allPatientUsers.isEmpty) {
      emit(GetAllPatientUsersDataLoadingState());

      await FirebaseFirestore.instance
          .collection('Patient')
          .get()
          .then((value) {
        value.docs.forEach((element) {
//to remove doctors  acc from list
          if (element.data()['uID'] != doctorUserModel?.uID) {
            allPatientUsers.add(PatientUserModel.fromJson(element.data()));
          }
          emit(GetAllPatientUsersDataSuccessState());
        });
      }).catchError((onError) {
        emit(GetAllPatientUsersDataErrorState(onError.toString()));
      });
    }
  }

  MsgModel? msgModel;

  //get msg
  sendMSG({required receiverID, required text, required dateTime}) async {
    emit(SendMSGLoadingState());
    MsgModel msgModel = MsgModel(
        senderID: FirebaseAuth.instance.currentUser!.uid,
        text: text,
        dateTime: dateTime,
        receiverID: receiverID);
//set my chats
    await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(doctorUserModel?.uID)
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

    await FirebaseFirestore.instance
        .collection('Patient')
        .doc(receiverID)
        .collection('chats')
        .doc(doctorUserModel?.uID)
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

  getMSGFun({required receiverID}) async {
    await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('chats')
        .doc(receiverID)
        .collection('MSG')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      emit(GetMsgDoctorLoadingState());

//listen in every time receive all data again so  you should make list empty
      getMSG = [];
      event.docs.forEach((element) {
        getMSG.add(MsgModel.fromJson(element.data()));
        emit(GetMsgDoctorDoneState());
      });
    });
  }


  // list of post model to put data in it
  List<PostModel> getPosts = [];

  // //list to get post id
  // List<String> postId = [];
  //
  // //list of number of likes
  // List<int> postLikes = [];

  //get post
  List<Map<String, PostModel>> postsList = [];

  getPostsMethod() {
    FirebaseFirestore.instance.collection('post').snapshots().listen((event) {
      //listen in every time receive all data again so  you should make list empty
      postsList = [];
      for (var element in event.docs) {
        postsList.add(
            {element.reference.id: PostModel.fromJson(element.data())});
        getPosts.add(PostModel.fromJson(element.data()));
      }

      debugPrint(postsList.length.toString());

      emit(GetDoctorPostSuccessState());
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
      emit(DoctorPostLikesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(DoctorPostLikesErrorState(
        error.toString(),
      ));
    });
  }


//follow and unfollow
  bool isFollowing=false;
//follow method
  followMethod(
      {required doctorUid,
        required patientUid,
        required docName,
        required patName,

      }) {
    isFollowing = true;
    emit(IsFollowingTrueState());
    //of fllowing
    FirebaseFirestore.instance
        .collection(" followers")
        .doc(patientUid)
        .collection('User followers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({});
    //of followers
    FirebaseFirestore.instance
        .collection(" followers")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('User followers')
        .doc(patientUid)
        .set({});

    FirebaseFirestore.instance
        .collection("Patient")
        .doc(patientUid)
        .collection('Follow').doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      'current User name':patName ,
      'Doctor User name':docName ,

      'current User uID':patientUid ,
      'Doctor UID': doctorUid


    });
  }
//unfollow method


  unFollowMethod(
      {required doctorUserUid,
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
        .get().then((value){
      if(value.exists)
      {
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
        .get().then((value){
      if(value.exists)
      {
        // to delete the doc
        value.reference.delete();
      }
    });
    FirebaseFirestore.instance
        .collection("Doctor")
        .doc(doctorUserUid)
        .collection('Follow').doc(FirebaseAuth.instance.currentUser?.uid)
        .get().then((value){
      if(value.exists)
      {
        // to delete the doc
        value.reference.delete();
      }
    });
  }

}
