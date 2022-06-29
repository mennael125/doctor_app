import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/layout/doctor_layout/doctor_layout.dart';
import 'package:doctorapp/layout/patient_layout/patient_layout.dart';
import 'package:doctorapp/modules/waiting_screen/waiting_screen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';
import 'package:doctorapp/shared/network/local/cach_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

// log in
  Future<UserCredential?> logIn(
      {required email, required password, required context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        emit(LoginLoadingState());
         navigateTo(context: context, widget: WaitingScreen());



        print(email);
        print('_______________________________');
        print(FirebaseAuth.instance.currentUser!.uid.toString());
        print('_______________________________');
        print('______________________________');

        emit(LoginSuccessState(FirebaseAuth.instance.currentUser!.uid));
      }).catchError((onError) {
        print(onError.toString());
        toast(
            text: 'please enter correct email and password or sign up now',
            state: ToastState.error);

        emit(LoginErrorState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        toast(text: 'No user found for that email.', state: ToastState.error);

        emit(ShowToastState());
      } else if (e.code == 'wrong-password') {
        toast(text: 'wrong-password', state: ToastState.error);

        emit(ShowToastState());
        print('Wrong password provided for that user.');
      }
    }
  }

  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginPasswordShowState());
  }
}
