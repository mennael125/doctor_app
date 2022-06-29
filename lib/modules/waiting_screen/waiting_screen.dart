
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/layout/doctor_layout/doctor_layout.dart';
import 'package:doctorapp/layout/patient_layout/patient_layout.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';
import 'package:doctorapp/shared/network/local/cach_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  // void initState(){
  //   isLogged(uID: uID, context: context);
  //
  //   super.initState();
  //
  // }



  Widget build(BuildContext context) {
   isLogged(uID:  FirebaseAuth.instance.currentUser?.uid, context: context);

    return       const Scaffold(

        body: Center(
            child: Icon(
              Icons.beach_access,
            ))
    );

  }
}



Future isLogged({ required context, required uID})   async {

    await FirebaseFirestore.instance
      .collection('Patient')
      .doc(uID)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {

      navigateAndRemove(context: context, widget: PatientLayout());
      print ('pat=====================================');

    } else    {

      navigateAndRemove(context: context, widget: DoctorLayout());
      print ('doccccc');

    }
  });


     }

