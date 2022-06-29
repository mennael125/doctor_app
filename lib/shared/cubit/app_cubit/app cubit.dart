import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/modules/chats_screen_doctor/chats_doctor_screen.dart';
import 'package:doctorapp/modules/chats_screen_patient/chats_patient_screen.dart';
import 'package:doctorapp/modules/home_screen/home_screen_doctor.dart';
import 'package:doctorapp/modules/home_screen/home_screen_patient.dart';
import 'package:doctorapp/modules/login_screen/login_screen.dart';
import 'package:doctorapp/modules/new_post_screen/new_post_doctor_screen.dart';
import 'package:doctorapp/modules/new_post_screen/new_post_patient_screen.dart';
import 'package:doctorapp/modules/settings_screen/doctor_setting/setting_screen_doctor.dart';
import 'package:doctorapp/modules/settings_screen/patient_setting/setting_screen_patient.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/cubit/app_cubit/app%20states.dart';
import 'package:doctorapp/shared/network/local/cach_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

//dark mood
  bool isDark = false;

  void darkChange({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(DarkStateChange());
    } else {
      isDark = !isDark;
      CacheHelper.savetData(value: isDark, key: 'isDark');
      emit(DarkStateChange());
    }
  }

  //fun to log out throw firebase
  Future<void> logOut({required context}) async {
    await FirebaseAuth.instance.signOut().then((value) async {
      emit(LogOutLoadingState());

      navigateAndRemove(context: context, widget: LoginScreen());


      emit(LogOutSuccessState());
    }).catchError((onError) {
      emit(LogOutErrorState());
    });
  }

  //drop down change
  dropDownChange({required selectedValue, required newValue}) {
    selectedValue = newValue!;
    emit(DropDownChangeState());
  }

  checkListChange({required selectedValue, required newValue}) {
    selectedValue = newValue!;
    emit(CheckListChangeState());
  }

  //bottom navBar
  int currentIndex = 0;

  //Toggle Between Screens
  List<Widget> patientScreens = [
    const HomeScreenPatient(),
    const ChatPatientScreen(),
    const NewPostPatientScreen(),
    const SettingScreenPatient(),
  ];
  List<Widget> doctorScreens = [
    const HomesScreenDoctor(),
    const ChatDoctorScreen(),
    const NewPostDoctorScreen(),
    const SettingScreenDoctor(),
  ];

//titles in AppBar
  List<String> titles = ['Home', 'Chats', 'Add Post'


    , 'Profile'];

//fun to change Screens
  void bottomNavChange(int index) {
    if (index == 2) {
      emit(AddPostPageState());
    } else {
      currentIndex = index;
      emit(NavBarChangeState());
    }
  }



//remove post Confirm
  removePostConfirm({required context, required String doc}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

            title: const Text("Confirm"),
            content: Text(
              "Are you sure you wish to delete this item?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: <Widget>[
              MaterialButton(
                  color: Colors.red,
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    //delete from fire store
                    await FirebaseFirestore.instance
                        .collection('post')
                        .doc(doc)
                        .delete();
                  },
                  child: const Text("DELETE")),
              MaterialButton(
                color: Colors.green,
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("CANCEL"),
              )
            ]);
      },
    );

    emit(ConfirmSuccess());
  }




}