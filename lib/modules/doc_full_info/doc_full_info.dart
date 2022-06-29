import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:flutter/material.dart';

class DocFullInfoScreen extends StatelessWidget {
  const DocFullInfoScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.gender,
    required this.country,
    required this.scientificDegree,
    required this.specialization,
    required this.clinicLocation,
  }) : super(key: key);
  final name;

  final email;

  final gender;

  final country;

  final scientificDegree;

  final specialization;

  final clinicLocation;

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
              //scientificDegree
              Text(
                'Scientific Degree: ',
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
                    Icons.science,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      scientificDegree,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //specialization
              Text(
                'Specialization: ',
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
                    Icons.medication,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      specialization,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //location
              Text(
                'The Location is : ',
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
                    Icons.person_pin_circle,
                    size: 25,
                    color: defaultColor.withOpacity(.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      clinicLocation,
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

//widget of page build for all data of doctor
