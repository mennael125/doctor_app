import 'package:doctorapp/modules/chats_screen_doctor/chats_doctor_screen.dart';
import 'package:doctorapp/modules/map_screen/maps_screen.dart';
import 'package:doctorapp/modules/new_post_screen/new_post_doctor_screen.dart';
import 'package:doctorapp/modules/search/search_in_patinent.dart';
import 'package:doctorapp/modules/settings_screen/doctor_setting/setting_screen_doctor.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/cubit/app_cubit/app%20cubit.dart';
import 'package:doctorapp/shared/cubit/app_cubit/app%20states.dart';
import 'package:doctorapp/shared/cubit/login_cubit/login_states.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorLayout extends StatelessWidget {
  const DoctorLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LogOutLoadingState) {
          const Center(
            child: SizedBox(height: 30, child: CircularProgressIndicator()),
          );
        }
        if (state is AddPostPageState) {
          navigateTo(context: context, widget: NewPostDoctorScreen());
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 110.0,
                    child: DrawerHeader(
                      //margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Menu Doctor',
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context: context, widget: MapsScreen());
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Maps'),
                        Spacer(),
                        Icon(IconBroken.Location),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context: context,
                          widget: Scaffold(
                              appBar: defaultAppBar(
                                  context: context,
                                  title: 'Profile',
                                  actions: [
                                    // IconButton(
                                    //     icon: const Icon(Icons.brightness_2_outlined),
                                    //     onPressed: () {
                                    //       // cubit.darkChange();
                                    //       // print(cubit.isDark);
                                    //     }) ,
                                    IconButton(
                                        icon: const Icon(IconBroken.Search),
                                        onPressed: () {
                                          navigateTo(
                                              context: context,
                                              widget: SearchInPatient());
                                        }),
                                  ]),
                              body: const SettingScreenDoctor()));
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Profile'),
                        Spacer(),
                        Icon(IconBroken.User),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context: context,
                          widget: Scaffold(
                              appBar: defaultAppBar(
                                context: context,
                                title: 'Chats',
                                actions: [
                                  // IconButton(
                                  //     icon: const Icon(Icons.brightness_2_outlined),
                                  //     onPressed: () {
                                  //       // cubit.darkChange();
                                  //       // print(cubit.isDark);
                                  //     }) ,
                                  IconButton(
                                      icon: const Icon(IconBroken.Search),
                                      onPressed: () {
                                        navigateTo(
                                            context: context,
                                            widget: SearchInPatient());
                                      }),
                                ],
                              ),
                              body: const ChatDoctorScreen()));
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Chats'),
                        Spacer(),
                        Icon(IconBroken.Chat),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      cubit.logOut(context: context);
                      cubit.currentIndex = 0;
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Log Out'),
                        Spacer(),
                        Icon(IconBroken.Logout),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            actions: [
              // IconButton(
              //     icon: const Icon(Icons.brightness_2_outlined),
              //     onPressed: () {
              //       // cubit.darkChange();
              //       // print(cubit.isDark);
              //     }) ,
              IconButton(
                  icon: const Icon(IconBroken.Search),
                  onPressed: () {
                    navigateTo(context: context, widget: SearchInPatient());
                  }),
            ],
            title: Text(cubit.titles[cubit.currentIndex]),
            titleSpacing: 2,
          ),
          body: cubit.doctorScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Add Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: 'Profile'),
            ],
            currentIndex: State is LoginSuccessState ? 0 : cubit.currentIndex,
            onTap: (index) {
              cubit.bottomNavChange(index);
            },
          ),
        );
      },
    );
  }
}
// myDrawer({required context}) => Drawer(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 2.0),
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         SizedBox(
//
//           height: 110.0,
//
//
//           child: DrawerHeader(
//             //margin: const EdgeInsets.all(2.0),
//             padding: const EdgeInsets.all(1.0),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(.3),
//               borderRadius: BorderRadius.circular(5),
//
//
//             ),
//             child: Row(
//
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 SizedBox(width: 10,),
//                 Text('Menu Doctor',style: TextStyle(fontSize: 22), ),
//
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 10,),
//         InkWell
//           (
//           onTap: (){
//
//             navigateTo(context: context, widget: const MapsScreen());
//           },
//           child:  Row(
//
//
//             children: const [
//               SizedBox(width: 10,),
//               Text('Maps' ),
//               Spacer(),
//               Icon(IconBroken.Location),
//
//
//             ],
//           ),
//         ),
//         const SizedBox(height: 10,),
//         InkWell(
//           onTap: (){
//
//             navigateTo(context: context, widget:const SettingScreenDoctor());
//           }
//           ,
//           child: Row(
//
//
//             children: const [
//               SizedBox(width: 10,),
//               Text('Settings' ),
//               Spacer(), Icon(IconBroken.Setting),
//
//
//
//             ],
//           ),
//         ),
//         const SizedBox(height: 10,),
//         InkWell(
//           onTap: (){
//             cubit.logOut(context: context);
//             cubit.currentIndex=0;
//           }
//           ,
//           child: Row(
//
//
//             children: const [
//               SizedBox(width: 10,),
//               Text('Log Out' ),
//               Spacer(),Icon(IconBroken.Logout),
//
//
//
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );
