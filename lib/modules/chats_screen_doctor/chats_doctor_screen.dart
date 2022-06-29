import 'package:doctorapp/modeles/patient_user_model.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_states.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'chat_doctor_detail.dart';




class ChatDoctorScreen extends StatelessWidget {
  const ChatDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allUsers = DoctorCubit
        .get(context)
        .allPatientUsers;
    return BlocConsumer<DoctorCubit, DoctorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return
          Scaffold(

            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Conditional.single(
                    widgetBuilder: (BuildContext context) =>
                        ListView.separated(
                          itemCount: allUsers.length, itemBuilder: (BuildContext
                        context, int index)
                        =>
                            chatPageBuilder(context: context, patientUserModel: allUsers[index])
                          , separatorBuilder: (BuildContext context, int index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(width: double.infinity, color: Colors.grey[300],),
                        )
                          ,),

                    context: context,
                    conditionBuilder: (BuildContext context) => allUsers.isNotEmpty,
                    fallbackBuilder: (BuildContext context) =>
                        Center(child: CircularProgressIndicator(),)
                )
            )
        );

      }

      ,

    );}}


  Widget chatPageBuilder({required context, required PatientUserModel patientUserModel}) =>
      InkWell(onTap: () {

        navigateTo(context: context  , widget:  ChatDoctorDetailUi(receiver:patientUserModel ,));
      },
        child: Row(
            children: [
              //widget of circle picture
              CircleAvatar(
                radius: 27,
                backgroundColor: defaultColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    // 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'),
                      patientUserModel.image!),  radius: 25,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                patientUserModel.userName!,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.4),
              ),
            ]
        ),
      );