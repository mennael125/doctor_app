

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modeles/doctor_user_model.dart';
import 'package:doctorapp/modules/profile_screen/doctor_profile_sceen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchInDoctor extends StatefulWidget {
  const SearchInDoctor({Key? key}) : super(key: key);

  @override
  State<SearchInDoctor> createState() => _SearchInDoctorState();
}

class _SearchInDoctorState extends State<SearchInDoctor> {
  var searchController = TextEditingController();
  CollectionReference<Map<String, dynamic>> docRef =
  FirebaseFirestore.instance.collection('Doctor');
  Future<QuerySnapshot>? searchResult;

//handle search
  handleSearchMethod(value) {
    Future<QuerySnapshot> user =
    docRef.where('userName', isGreaterThanOrEqualTo: value).get();
    setState(() {
      searchResult = user;
    });
  }

  searchResultMethod() {
    return FutureBuilder<QuerySnapshot>(
      future: searchResult,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
        List<UserResult> searchData = [];
        snapshot.data?.docs.forEach((element) {
          DoctorUserModel docModle = DoctorUserModel.fromDocument(element);

          searchData.add(UserResult(
            userModel: docModle,
          ));
        });
        return ListView(shrinkWrap: true, children: searchData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar(context: context, title: 'Search'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TextFormField(),
                defaultFormField(
                    controller: searchController,
                    textKeyboard: TextInputType.text,
                    prefix: IconBroken.User1,
                    onFieldSubmitted: (value) {
                      handleSearchMethod(value);
                    },
                    suffix: IconBroken.Close_Square,
                    suffixPressed: () {
                      searchController.clear();
                    },
                    validate: (val) {},
                    textLabel: 'Search for user'),
                searchResult == null
                    ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Search for a user'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.sentiment_dissatisfied
)
                    ],
                  ),
                )
                    : searchResultMethod()
              ],
            ),
          ),
        ));
  }
}

class UserResult extends StatelessWidget {
  const UserResult({
    Key? key,
    required this.userModel,
  }) : super(key: key);
  final DoctorUserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              navigateTo(context: context, widget:DoctorProfileScreen(reciever: userModel, uID: userModel.uID,));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: defaultColor,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
// 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'),
                        userModel.image!),
                    radius: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  userModel.userName!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.4),
                ),
                SizedBox(
                  width: 10,
                ),
              ],

            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
