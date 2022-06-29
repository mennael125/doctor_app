import 'package:doctorapp/modules/login_screen/login_screen.dart';
import 'package:doctorapp/modules/on_boarding/on_boarding.dart';
import 'package:doctorapp/shared/cubit/app_cubit/app%20cubit.dart';
import 'package:doctorapp/shared/cubit/app_cubit/app%20states.dart';
import 'package:doctorapp/shared/cubit/bloc_observer/bloc_observer.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:doctorapp/shared/cubit/patient_cubit/patient_cubit.dart';
import 'package:doctorapp/shared/network/local/cach_helper.dart';
import 'package:doctorapp/shared/styles/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/waiting_screen/waiting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();
//save is dark in shared pref
  bool? isDark = CacheHelper.getBoolData(key: 'isDark');
  //save is onBoard skip in shared pref

  bool? onBoardingSkip = CacheHelper.getBoolData(key: 'onBoardingSkip');
  print('------------------------');
  print(onBoardingSkip.toString());
  print('------------------------');

  Widget start;

  BlocOverrides.runZoned(
        () async {
      //to check the uid of user
      var uID = FirebaseAuth.instance.currentUser?.uid;

//if statement to start app
      if (onBoardingSkip == true) {
        if (uID != null) {
          // // to choose which page i enter

          start = const WaitingScreen();
        } else {
          start = LoginScreen();
        }
      } else {
        start = const OnBoarding();
      }

      runApp(MyApp(start, isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget start;
  final bool? isDark;

  const MyApp(this.start, this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
            AppCubit()
              ..darkChange(fromShared: isDark)  ),
        BlocProvider(create: (context) =>
        DoctorCubit()
          ..getDoctorData()..getPatientData()..getAllPatientUsers()..
        getPostsMethod()

          ,


        ),
        BlocProvider(create: (context) =>
        PatientCubit()
          ..getPatientData()..getDoctorData()..getAllDoctorUsers()..  getPostsMethod(),


        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode:
            AppCubit
                .get(context)
                .isDark ? ThemeMode.light : ThemeMode.dark,
            theme: lightMode,
            darkTheme: darkMode,
            home: start,

          );
        },
      ),
    );
  }
}
