//class model to put data of patient in it


import 'package:cloud_firestore/cloud_firestore.dart';

class PatientUserModel {
  String? userName;
  String? email;
  String? password;
  String ? country;

  String ? uID;

  String ? gender;

  String ? cover;

  String ?image;

  String? phone;
  String? bio;
  String? bloodType;
  String? chronicDiseases;

  PatientUserModel({

    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.bio,
    required this.bloodType,
    required this.chronicDiseases,
    required this.image,
    required this.country,
    required this.gender,
    required this.uID,
    required this .cover,
  });

  PatientUserModel .fromJson(Map<String, dynamic> json){
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    bio = json['bio'];
    bloodType = json['bloodType'];
    chronicDiseases = json['chronicDiseases'];
    cover = json['cover'];
    gender = json['gender'];
    country = json['country'];
    uID = json['uID'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'email': email,
      'userName': userName,
      'password': password,
      'phone': phone,
      'bio': bio,
      'image': image,
      'bloodType': bloodType,
      'country': country,
      'chronicDiseases': chronicDiseases,
      'gender': gender,
      'cover': cover
    };
  }

  factory PatientUserModel .fromDocument(DocumentSnapshot doc){
    return PatientUserModel(
      userName: doc['userName'],
      email: doc['email'],
      password: doc['password'],
      phone: doc['phone'],
      bio: doc['bio'],
      bloodType: doc['bloodType'],
      chronicDiseases: doc['chronicDiseases'],
      cover: doc['cover'],
      gender: doc['gender'],
      country: doc['country'],
      uID: doc['uID'],
      image: doc['image'],
    );
  }


}