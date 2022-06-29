import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modeles/doctor_user_model.dart';
import 'package:doctorapp/modeles/msg_model.dart';
import 'package:doctorapp/modules/profile_screen/doctor_profile_sceen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_cubit.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_states.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

var msgController = TextEditingController();

class ChatPatientDetailUi extends StatelessWidget {
  const ChatPatientDetailUi({Key? key, this.receiver}) : super(key: key);
  final DoctorUserModel? receiver;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      PatientCubit.get(context).getMSGFun(receiverID: receiver!.uID);
      return BlocConsumer<PatientCubit, PatientStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CollectionReference streamBuildPat = FirebaseFirestore.instance
              .collection(FirebaseAuth.instance.currentUser!.uid);

          var cubit = PatientCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: appBarTitle(receiver: receiver!, context: context, pageReciever: receiver, uID: receiver!.uID),
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Conditional.single(
                  conditionBuilder: (
                      BuildContext context) => state is GetMsgPatientLoadingState,
                  fallbackBuilder: (BuildContext context) {
                    return StreamBuilder(
                        stream: streamBuildPat.doc('chats').collection(
                            '${receiver!.uID}').doc('Msg').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          //define msg by the index num
                                          var MSGNum = cubit.getMSG[index];
                                          if (receiver!.uID == MSGNum.receiverID)
                                            return Align(
                                                alignment: AlignmentDirectional
                                                    .topEnd,
                                                child: mSG(
                                                    msgText: MSGNum,
                                                    color: defaultColor
                                                        .withOpacity(.5),
                                                    topRight: Radius.circular(0),
                                                    context: context,
                                                    topLeft: Radius.circular(5)));
                                          else
                                            return
                                              //sender msg
                                              Align(
                                                  alignment:
                                                  AlignmentDirectional.topStart,
                                                  child: mSG(
                                                      msgText: MSGNum,
                                                      color: Colors.grey[300],
                                                      topRight: Radius.circular(
                                                          5),
                                                      context: context,
                                                      topLeft: Radius.circular(
                                                          0)));

                                          //my message
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 5,
                                            ),
                                        itemCount: cubit.getMSG.length),
                                  ),
                                  containerBuild(
                                      receiver: receiver!.uID, context: context)
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  },
                  context: context,
                  widgetBuilder: (BuildContext context) =>
                      Column(
                          children: [
                            Spacer(),
                            containerBuild(
                                receiver: receiver!.uID, context: context),
                            SizedBox(height: 5,),
                          ])),
            ),
          );
        },
      );
    });
  }
}

//appBar design
appBarTitle({required DoctorUserModel receiver, required context , required pageReciever , required uID}) =>
    Row(children: [
//widget of circle picture
      InkWell(
       onTap:     (){  navigateTo(context:context ,widget: DoctorProfileScreen( reciever: pageReciever, uID: uID,) );}, child: CircleAvatar(
          radius: 27,
          backgroundColor: defaultColor,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
// 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'),
                receiver.image!),
            radius: 25,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        receiver.userName!,
        style: Theme
            .of(context)
            .textTheme
            .bodyText1!
            .copyWith(height: 1.4),
      ),
    ]);
//Message design
mSG({required color,
  required context,
  required topLeft,
  required topRight,
  required MsgModel msgText}) =>

    Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                topLeft: topLeft,
                bottomLeft: Radius.circular(5),
                topRight: topRight)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            msgText.text,
            style: Theme
                .of(context)
                .textTheme
                .bodyText1,
          ),

        ))

;

containerBuild({required receiver, required context}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
          Border.all(width: 1, color: defaultColor)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0),
              child: TextFormField(
                controller: msgController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write Your Message'),
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {
                PatientCubit.get(context).sendMSG(
                    receiverID: receiver,
                    text: msgController.text,
                    dateTime: DateTime.now().toString());

                msgController.text = "";
              },
              child: Icon(
                IconBroken.Send,
                size: 25,
                color: defaultColor,
              ))
        ],
      ),
    )
;