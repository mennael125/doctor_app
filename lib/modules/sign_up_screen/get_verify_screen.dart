import 'package:doctorapp/modules/sign_up_screen/email_verfiy.dart';
import 'package:doctorapp/modules/toogle_register/toogle_screen_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetVerifyScreen  extends StatelessWidget {
  const GetVerifyScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return EmailVerifyScreen();
            } else {
              return ToggleScreenRegister();
            }
          }),);
  }
}
