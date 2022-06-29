import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:flutter/material.dart';

class PatFullInfoScreen extends StatelessWidget {
  const PatFullInfoScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.gender,
    required this.country,
    required this.bloodType,
    required this.chronicDiseases,
  }) : super(key: key);
  final name;

  final email;

  final gender;

  final country;

  final chronicDiseases;

  final bloodType;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'View full info'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //name
              Text(
                'Full Name: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: defaultColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.account_circle,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //email
              Text(
                'Mail: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: defaultColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.mail,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      email,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              // gender
              Text(
                'Gender: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: defaultColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.person,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      gender,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //country
              Text(
                'Country: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: defaultColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.flag,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      country,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              //chronicDiseases
              Text(
                'Chronic Diseases: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: defaultColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.coronavirus,                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      chronicDiseases,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //Blood Type
              Text(
                'Blood Type : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: defaultColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.bloodtype,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      bloodType,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

