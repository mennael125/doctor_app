import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:doctorapp/layout/patient_layout/patient_layout.dart';
import 'package:doctorapp/modules/login_screen/login_screen.dart';
import 'package:doctorapp/modules/waiting_screen/waiting_screen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_cubit.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_states.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'get_verify_screen.dart';


var passwordController = TextEditingController();
var userNameController = TextEditingController();
var phoneController = TextEditingController();
String? countryIndex;

String? genderIndex;

String? bloodTypeIndex;

String? chronicDiseasesIndex;

var emailController = TextEditingController();
GroupController controller = GroupController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class PatientRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PatientCubit(),
        child: BlocConsumer<PatientCubit, PatientStates>(
          listener: (context, state) {
            if (state is PatientRegisterSuccessState) {
              navigateAndRemove(context: context, widget: const GetVerifyScreen());

            }
          },
          builder: (context, state) {
            PatientCubit cubit = PatientCubit.get(context);

            return Scaffold(
                appBar: defaultAppBar(
                    context: context, title: 'Patient Register Screen'),
                body: Center(
                    child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      state is PatientCreateLoadingState,
                  widgetBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fallbackBuilder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //name text form field
                            defaultFormField(
                                controller: userNameController,
                                textKeyboard: TextInputType.text,
                                prefix: IconBroken.User,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your user name please";
                                  }
                                  if (value.length > 100) {
                                    return "Your user name can'\t be more than 100 ";
                                  }
                                  if (value.length < 2) {
                                    return "Your user name can'\t be less than 2 ";
                                  }
                                },
                                textLabel: 'User Name'),
                            const SizedBox(
                              height: 5,
                            ),
                            //email controller
                            defaultFormField(
                                controller: emailController,
                                textKeyboard: TextInputType.text,
                                prefix: IconBroken.Message,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your Email please";
                                  }
                                  if (value.length > 200) {
                                    return "Your Email can'\t be more than 200 ";
                                  }
                                  if (value.length < 2) {
                                    return "Your Email can'\t be less than 2 ";
                                  }
                                },
                                textLabel: 'Email'),
                            const SizedBox(
                              height: 5,
                            ),
                            //password visibility
                            defaultFormField(
                                suffix: cubit.suffix,
                                suffixPressed: cubit.passwordVisibility,
                                controller: passwordController,
                                textKeyboard: TextInputType.text,
                                prefix: IconBroken.Lock,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your password please";
                                  }
                                  if (value.length > 100) {
                                    return "Your password can'\t be more than 100 ";
                                  }
                                  if (value.length < 6) {
                                    return "Your password can'\t be less than 6 ";
                                  }
                                },
                                textLabel: 'Password',
                                isPassword: cubit.isPassword),
                            const SizedBox(
                              height: 5,
                            ),
                            //phone controller
                            defaultFormField(
                                controller: phoneController,
                                textKeyboard: TextInputType.phone,
                                prefix: IconBroken.Call,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your user phone please";
                                  }
                                  if (value.length > 20) {
                                    return "Your user name can'\t be more than 20 ";
                                  }
                                  if (value.length < 2) {
                                    return "Your user name can'\t be less than 2 ";
                                  }
                                },
                                textLabel: 'phone'),
                            const SizedBox(
                              height: 5,
                            ),
                            // drop down Of gender
                            defaultDropDownList(
                                dropdownItems: gender,
                                context: context,
                                labelText: 'Your gender ',
                                validator: (value) {
                                  genderIndex = value;
                                }),

                            const SizedBox(
                              height: 15,
                            ),
                            //Country list
                            defaultDropDownList(
                                dropdownItems: countries,
                                context: context,
                                labelText: 'Choose your country ',
                                validator: (value) {
                                  countryIndex = value;
                                }),

                            const SizedBox(
                              height: 15,
                            ),

                            //bloodTypes list

                            defaultDropDownList(
                                dropdownItems: bloodTypes,
                                context: context,
                                labelText: 'Choose your bloodType ',
                                validator: (value) {
                                  bloodTypeIndex = value;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            //chronic diseases list

                            defaultDropDownList(
                                dropdownItems: chronicDiseases,
                                context: context,
                                labelText:
                                    'Choose your chronic diseases If You have ',
                                validator: (value) {
                                  chronicDiseasesIndex = value;
                                }),

                            const SizedBox(
                              height: 15,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'If you have an account ',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                textButton(
                                    text: 'Click here',
                                    fun: () {
                                      backTo(
                                          context: context,
                                          widget: LoginScreen());
                                    }),
                                const Spacer(),
                              ],
                            ),
                            defaultButton(
                                text: 'Sign Up',
                                fun: () async {
                                  ///////////////////////////////////////Stoppppppppppp Funnnnnnnnnnnnnnnn                    /       /////////////////////////////
                                  if (formKey.currentState!.validate()) {
                                    cubit.patientSignUp(
                                      country: countryIndex,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                      name: userNameController.text,
                                      chronicDiseases: chronicDiseasesIndex,
                                      bloodType: bloodTypeIndex,
                                      gender: genderIndex,
                                    );

                                    userNameController.text = '';
                                    phoneController.text = '';
                                    passwordController.text = '';
                                    emailController.text = '';
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
          },
        ));
  }
}
