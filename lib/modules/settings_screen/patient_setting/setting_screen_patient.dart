import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modeles/patient_user_model.dart';
import 'package:doctorapp/modeles/post_model/post_model.dart';
import 'package:doctorapp/modules/pat_full_info_screen/pat_full_info.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';

import 'package:doctorapp/shared/cubit/app_cubit/app%20cubit.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_cubit.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_states.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'edit_patient_screen.dart';

class SettingScreenPatient extends StatelessWidget {
  const SettingScreenPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientStates>(
      listener: (cubit, state) {},
      builder: (cubit, state) {
        var cubit = PatientCubit.get(context);
        var patModel = cubit.patientUserModel;
        var PostsModel = PatientCubit.get(context).getPosts;
       // var PostId = PatientCubit.get(context).postId;
        CollectionReference postRef =
            FirebaseFirestore.instance.collection('post');
        //var PostCommentId = PatientCubit.get(context).postCommentId;
        return patModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
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
                                      // image: NetworkImage(
                                      //     'https://img.freepik.com/free-vector/abstract-colorful-hand-painted-wallpaper_52683-61599.jpg?w=740') ,
                                      image: NetworkImage('${patModel.cover}'),
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
                                  NetworkImage('${patModel.image}'),
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
                      '${patModel.userName}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ), //text of bio
                    Text(
                      '${patModel.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Icon(
                              Icons.bloodtype,
                              size: 25,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${patModel.bloodType}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Icon(
                              Icons.coronavirus,
                              size: 25,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${patModel.chronicDiseases}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
                                      widget: PatFullInfoScreen(
                                        name: patModel.userName,
                                        bloodType: patModel.bloodType,
                                        chronicDiseases:
                                            patModel.chronicDiseases,
                                        email: patModel.email,
                                        country: patModel.country,
                                        gender: patModel.gender,
                                      ),
                                      context: context);
                                },
                                child: Text('Full Info'))),
                        OutlinedButton(
                            onPressed: () {
                              navigateTo(
                                  context: context,
                                  widget: const EditProfileScreenPatient());
                            },
                            child: Icon(IconBroken.Edit)),
                        OutlinedButton(
                            onPressed: () async {
                              AppCubit.get(context).logOut(context: context);
                              AppCubit.get(context).currentIndex = 0;
                            },
                            child: Icon(IconBroken.Logout))
                      ],
                    ),

                    //posts

                    SizedBox(
                      height: 10,
                    ),

                    Conditional.single(
                        fallbackBuilder: (BuildContext context) => Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No posts yet '),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.sentiment_dissatisfied
)
                                ],
                              ),
                            ),
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                            PostsModel.isNotEmpty,
                        widgetBuilder: (BuildContext context) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: postRef
                                        .where('uID',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser?.uid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data.docs.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return pageBuilder(
                                             index: index,
                                                dateTime: snapshot
                                                    .data.docs[index]
                                                    .data()['dateTime'],
                                                context: context,

                                                postID: snapshot
                                                    .data.docs[index].id,
                                              name: snapshot
                                                  .data.docs[index]
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
                                                // index: index,
                                                // postCommentID:
                                                //     PostCommentId[index]

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
  required name,
  required String postID,
  required index,
  required postImage,
  required userImage,
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
                      PatientCubit.get(context).patientUserModel!.image! ,
                    ),
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
                         PatientCubit.get(context).patientUserModel!.userName! ,
                          style: Theme.of(context)
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
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
                SizedBox(
                  width: 15,
                ),

                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .removePostConfirm(doc: postID, context: context);
                  },
                  icon: Icon(
                    IconBroken.Delete,
                    color: Colors.red,
                  ),
                  iconSize: 20,
                ),
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
                style: Theme.of(context)
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
                      PatientCubit.get(context).updatePostLikes(
                          PatientCubit.get(context).postsList[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          PatientCubit.get(context)
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
                          '${PatientCubit.get(context).postsList[index].values.single.likes?.length} likes',
                          style: Theme.of(context).textTheme.caption,
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
