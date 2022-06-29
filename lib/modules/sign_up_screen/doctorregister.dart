import 'package:doctorapp/layout/doctor_layout/doctor_layout.dart';
import 'package:doctorapp/modules/login_screen/login_screen.dart';
import 'package:doctorapp/modules/waiting_screen/waiting_screen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_states.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'get_verify_screen.dart';

String? genderIndex;
String? countryIndex;

String? scientificDegreeIndex;
String? specializationIndex;

var passwordController = TextEditingController();
var userNameController = TextEditingController();
var phoneController = TextEditingController();
var locationController = TextEditingController();

var emailController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class DoctorRegisterScreen extends StatelessWidget {
  const DoctorRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DoctorCubit(),
        child: BlocConsumer<DoctorCubit, DoctorStates>(
          listener: (context, state) {
            if (state is DoctorRegisterSuccessState) {
              navigateAndRemove(
                  context: context, widget: const GetVerifyScreen());
            }
          },
          builder: (context, state) {
            DoctorCubit cubit = DoctorCubit.get(context);

            return Scaffold(
                appBar: defaultAppBar(
                    context: context, title: 'Doctor Register Screen'),
                body: Center(
                    child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      state is DoctorCreateLoadingState,
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
                              height: 5,
                            ),
                            //default form field location
                            defaultFormField(
                                controller: locationController,
                                textKeyboard: TextInputType.text,
                                prefix: Icons.info_outline,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your location please";
                                  }
                                  if (value.length > 500) {
                                    return "Your location can'\t be more than 500 ";
                                  }
                                  if (value.length < 20) {
                                    return "Your location can'\t be less than 20 ";
                                  }
                                },
                                textLabel: 'Clinic location'),

                            const SizedBox(
                              height: 5,
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
                            //specialization list

                            defaultDropDownList(
                                dropdownItems: specialization,
                                context: context,
                                labelText: 'Choose your specialization ',
                                validator: (value) {
                                  specializationIndex = value;
                                }),

                            const SizedBox(
                              height: 15,
                            ),
                            //scientificDegree
                            defaultDropDownList(
                                dropdownItems: scientificDegree,
                                context: context,
                                labelText: 'Choose your scientificDegree ',
                                validator: (value) {
                                  scientificDegreeIndex = value;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: MaterialButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('UPLOAD ID',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  cubit.getIdDoctorImage();
                                  cubit.uploadIdImage();
                                },
                              ),
                            ),

                            if (state is IdDoctorImagePickedSuccessState)
                              Text('Upload ID is Done '),
                            if (state is IdDoctorImagePickedErrorState)
                              Text('Error in Uploading , try again'),
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
                                  if (formKey.currentState!.validate()) {
// register method
                                    cubit.doctorSignUp(
                                      country: countryIndex,
                                      gender: genderIndex,
                                      clinicLocation: locationController.text,
                                      scientificDegree: scientificDegreeIndex,
                                      phone: phoneController.text,
                                      name: userNameController.text,
                                      specialization: specializationIndex,
                                      password: passwordController.text,
                                      email: emailController.text,
                                    );
                                    emailController.text = '';
                                    phoneController.text = '';
                                    locationController.text = '';
                                    userNameController.text = '';
                                  }
                                }),
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
