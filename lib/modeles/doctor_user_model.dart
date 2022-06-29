//class model to put data of doctor in it

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorUserModel {
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? bio;
  String? clinicLocation;
  String? specialization;
  String? scientificDegree;
  String? cover;
  String? gender;
  String? idDoctorImage;

  String? image;

  String? uID;

  String? country;

  DoctorUserModel({
    required this.uID,
    required this.idDoctorImage,
    required this.country,
    required this.gender,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.bio,
    required this.clinicLocation,
    required this.specialization,
    required this.cover,
    required this.image,
    required this.scientificDegree,
  });

  DoctorUserModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    idDoctorImage = json['idDoctorImage'];

    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    bio = json['bio'];
    country = json['country'];
    clinicLocation = json['clinicLocation'];
    specialization = json['specialization'];
    cover = json['cover'];
    scientificDegree = json['scientificDegree'];
    image = json['image'];
    uID = json['uID'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idDoctorImage': idDoctorImage,
      'country': country,
      'uID': uID,
      'gender': gender,
      'email': email,
      'userName': userName,
      'password': password,
      'phone': phone,
      'bio': bio,
      'image': image,
      'clinicLocation': clinicLocation,
      'specialization': specialization,
      'scientificDegree': scientificDegree,
      'cover': cover
    };
  }

  factory DoctorUserModel.fromDocument(DocumentSnapshot doc) {
    return DoctorUserModel(
      userName: doc['userName'],
      email: doc['email'],
      password: doc['password'],
      phone: doc['phone'],
      bio: doc['bio'],
      idDoctorImage: doc['idDoctorImage'],
      scientificDegree: doc['scientificDegree'],
      specialization: doc['specialization'],
      cover: doc['cover'],
      gender: doc['gender'],
      country: doc['country'],
      uID: doc['uID'],
      image: doc['image'],
      clinicLocation: doc['clinicLocation'],
    );
  }
}
