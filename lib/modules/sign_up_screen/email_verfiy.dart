import 'dart:async';

import 'package:doctorapp/modules/waiting_screen/waiting_screen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isEmailVerified = false;
  Timer?timer;

  bool canResendEmail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//to send verify email
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 4), (val) => checkEmailVerify());
    }
    void dispose() {
      timer?.cancel();
      super.dispose();
    }
  }

  //fun to check verify
  //fun to send verify
  Future checkEmailVerify() async {
    //call after email verify
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  //fun to send verify
  sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 8));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      toast(text: e.toString(), state: ToastState.warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? WaitingScreen()
        : Scaffold(
      appBar: defaultAppBar(context: context, title: 'Email Verify'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                  "A verification has been sent , please check your Email"),
              const SizedBox(
                height: 20,
              ),

              ElevatedButton.icon(
                  onPressed:(){
                    canResendEmail  ? sendVerificationEmail() : null;
                  },
                  icon: Icon(IconBroken.Message, size: 32,),
                  label: Text("Resend Email ")),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: (){FirebaseAuth.instance.signOut() ;}, child: Text('Cancel'))
            ],



          ),
        ),
      ),
    );
  }
}
