import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String name;
  String? userImage;

  late String postImage;

  late String postText;

  late String dateTime;

  late String uID;
 List<String>  ? likes;

  PostModel({

    required this.likes,
    required this.postImage,
    required this.uID,
    required this.postText,
    required this.userImage,
    required this.name,
    required this.dateTime,
  });

  //constructor to receive data
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postText = json['postText'];
    postImage = json['postImage'];
    userImage = json['userImage'];
    dateTime = json['dateTime'];
    uID = json['uID'];

  likes = List.from(json['likes']).map((e) => e.toString()).toList();
  //   likes =  List <String>.of(json["likes"])
  //       .map((i) => i /* can't generate it properly yet */)
  //       .toList();
  }

//fun to send data
  Map<String, dynamic> toMap() {
    return {

      'dateTime': dateTime,
      'likes': likes!.map((element) => element).toList(),
      'name': name,
      'postText': postText,
      'postImage': postImage,
      'userImage': userImage,
      'uID': uID,
      // 'likes':  jsonEncode(this.likes),

    };
  }


}

