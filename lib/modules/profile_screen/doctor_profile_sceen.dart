import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modules/doc_clinic_location/doc_clinic_location.dart';
import 'package:doctorapp/modules/doc_full_info/doc_full_info.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_states.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_cubit.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen(
      {Key? key, required this.reciever, required this.uID})
      : super(key: key);
  final reciever;
  final uID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorStates>(
      listener: (cubit, state) {},
      builder: (cubit, state) {
        var cubit = DoctorCubit.get(context);

        var postList = cubit.postsList;

        CollectionReference postRef =
        FirebaseFirestore.instance.collection('post');

        return reciever == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Scaffold(
            appBar: defaultAppBar(
                context: context, title: '${reciever.userName}'),
            body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //container of cover and photo With align
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            //add align to make the cover in the up
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage('${reciever.cover}'),
                                        // image: NetworkImage(
                                        //     'https://img.freepik.com/free-vector/hand-painted-watercolor-galaxy-background_23-2148987182.jpg?w=740&t=st=1651000284~exp=1651000884~hmac=dffcc7f0081e63a08a4d6494db70c61c4fb74e563d6c3eba892d1d080dc7acd9'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            CircleAvatar(
                              radius: 52,
                              backgroundColor: defaultColor,
                              child: CircleAvatar(
                                // backgroundImage: NetworkImage(
                                // 'https://img.freepik.com/free-vector/young-black-girl-avatar_53876-115570.jpg?t=st=1649212806~exp=1649213406~hmac=d4ea9c436ce796f91dae079d8d93dbbd790ef49606427bb1dd387cd7134cebd2&w=740'),

                                backgroundImage:
                                NetworkImage('${reciever.image}'),
                                radius: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //text of name
                      Text(
                        '${reciever.userName}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                      ), //text of bio
                      Text(
                        '${reciever.bio}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                      ),
//row of posts , likes , comments
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.medication,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${reciever.specialization}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: defaultColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.science,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${reciever.scientificDegree}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: defaultColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    widget: LocationInfoScreen(
                                        location: reciever.clinicLocation),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person_pin_circle,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${reciever.clinicLocation}',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: defaultColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      //button of add photo  and edit
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    navigateTo(
                                      widget: DocFullInfoScreen(
                                        name: reciever.userName,
                                        clinicLocation: reciever.clinicLocation,
                                        specialization: reciever.specialization,
                                        scientificDegree:
                                        reciever.scientificDegree,
                                        email: reciever.email,
                                        country: reciever.country,
                                        gender: reciever.gender,
                                      ),
                                      context: context,
                                    );
                                  },
                                  child: Text('Full Info '))),
                        ],
                      ),

                      //posts

                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    cubit.isFollowing = !cubit.isFollowing;

                                    cubit.isFollowing
                                        ? cubit.followMethod(
                                        patientUid: FirebaseAuth
                                            .instance.currentUser?.uid,
                                        doctorUid: uID,
                                        patName: PatientCubit.get(context).patientUserModel!
                                            .userName,
                                        docName:
                                        reciever.userName,)
                                            : cubit.unFollowMethod(
                                    doctorUserUid: uID,
                                        patientUid: FirebaseAuth
                                            .instance.currentUser?.uid);
                                    if (kDebugMode) {
                                      print(cubit.isFollowing.toString());
                                    }
                                  },
                                  child: cubit.isFollowing
                                      ? Text('Un Follow')
                                      : Text(' Follow'))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Conditional.single(
                          fallbackBuilder: (BuildContext context) =>
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No posts yet '),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.sentiment_dissatisfied)
                                  ],
                                ),
                              ),
                          context: context,
                          conditionBuilder: (BuildContext context) =>
                          postList.isNotEmpty,
                          widgetBuilder: (BuildContext context) {
                            return SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  StreamBuilder(
                                      stream: postRef
                                          .where('uID', isEqualTo: uID)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.separated(
                                            physics:
                                            NeverScrollableScrollPhysics(),
                                            itemCount:
                                            snapshot.data.docs.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return pageBuilder(
                                                // model: docModel,
                                                dateTime: snapshot
                                                    .data.docs[index]
                                                    .data()['dateTime'],
                                                context: context,
                                                postID: snapshot
                                                    .data.docs[index].id,
                                                index: index,
                                                // postCommentID:
                                                // PostCommentId[index],
                                                name: snapshot.data.docs[index]
                                                    .data()['name'],
                                                postImage: snapshot
                                                    .data.docs[index]
                                                    .data()['postImage'],
                                                postText: snapshot
                                                    .data.docs[index]
                                                    .data()['postText'],
                                                userImage: snapshot
                                                    .data.docs[index]
                                                    .data()['userImage'],
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                int index) =>
                                                Container(
                                                  width: double.infinity,
                                                  child: SizedBox(
                                                    height: 5,
                                                  ),
                                                ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      })
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                )));
      },
    );
  }
}
// widget of page builder

Widget pageBuilder({
  required context,
  required dateTime,
  required String postID,
  required index,
  required name,
  required userImage,
  required postImage,
  required postText,
}) =>
    Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                //widget of circle picture
                CircleAvatar(
                  radius: 27,
                  backgroundColor: defaultColor,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      // 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'
                        userImage!),
                    radius: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //row of name
                        Row(
                          children: [
                            Text(
                              name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(height: 1.4),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),

                        Text(
                          dateTime,
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // 'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'
                postText,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.2),
              ),
            ),

            //containe of image in post
            if (postImage.isNotEmpty)
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: NetworkImage(
                      //'https://img.freepik.com/free-photo/embarrassed-shocked-european-man-points-index-finger-copy-space-recommends-service-shows-new-product-keeps-mouth-widely-opened-from-surprisement_273609-38455.jpg?w=740'
                      //
                        postImage), fit: BoxFit.cover)),
              ),
            SizedBox(
              height: 10,
            ),

            //divider
            Container(
              width: double.infinity,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  child: InkWell(
                    onTap: () {
                      DoctorCubit.get(context).updatePostLikes(
                          DoctorCubit
                              .get(context)
                              .postsList[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          PatientCubit
                              .get(context)
                              .postsList[index]
                              .values
                              .single
                              .likes!
                              .any((element) =>
                          element ==
                              FirebaseAuth.instance.currentUser?.uid)
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${PatientCubit
                              .get(context)
                              .postsList[index].values.single.likes
                              ?.length} likes',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
