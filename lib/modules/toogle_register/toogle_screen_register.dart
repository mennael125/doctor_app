import 'package:doctorapp/modules/sign_up_screen/doctorregister.dart';
import 'package:doctorapp/modules/sign_up_screen/patientregister.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleScreenRegister extends StatelessWidget {
  const ToggleScreenRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: defaultAppBar(context: context , title: 'Choose Screen') ,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children:

        [
          Row(children: [


            Expanded(child: defaultButton(radius: 5,text: "Patient", fun: (){navigateTo(context: context , widget: PatientRegisterScreen());}))
            ,const SizedBox(width: 5,),
            Expanded(child: defaultButton( radius: 5,text: "Doctor", fun: (){navigateTo(context: context , widget: DoctorRegisterScreen());}))

          ],)



        ],),
      ),
    );
  }
}
