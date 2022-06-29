import 'package:doctorapp/layout/doctor_layout/doctor_layout.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/constant/constant.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:doctorapp/shared/cubit/doctor_cubit/doctor_states.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

var postController = TextEditingController();

class NewPostDoctorScreen extends StatelessWidget {
  const NewPostDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorStates>(
      listener: (context, state) {
        if (state is UploadDoctorPostSuccessState) {
          backTo(context: context, widget: DoctorLayout());
        }
      },
      builder: (context, state) {
        final formKey = GlobalKey<FormState>();

        var cubit = DoctorCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
              appBar: defaultAppBar(
                  context: context,
                  title: "Create DoctorPost",
                  actions: [
                    textButton(
                        text: "Add post",
                        fun: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.postImage != null) {
                              cubit.uploadDoctorPostImage(
                                  image: cubit.postImageUrl,
                                  text: postController.text,
                                  dateTime: formattedDate);

                              postController.text = '';
                              cubit.removeDoctorPostImage();
                            } else {
                              cubit.addDoctorPost(
                                  postImage: '',
                                  text: postController.text,
                                  dateTime: formattedDate);
                              postController.text = '';

                            }
                          }
                        }),
                    SizedBox(
                      width: 5,
                    )
                  ]),
              body: Conditional.single(
                  context: context,
                  conditionBuilder: (context) => cubit.doctorUserModel == null,
                  fallbackBuilder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (state is UploadDoctorPostLoadingState)
                              Column(
                                children: [
                                  LinearProgressIndicator(),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: defaultColor,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        cubit.doctorUserModel!.image!),
                                    radius: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      cubit.doctorUserModel!.userName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(height: 1.4),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(height: 1.4),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: postController,
                                keyboardType: TextInputType.multiline,
                                // user keyboard will have a button to move cursor to next line
                                minLines: 1,
                                maxLines: 30,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'post body must not be empty';
                                },
                                maxLength: 2000,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: Text(
                                        ' What\'s on your mind , ${cubit.doctorUserModel!.userName!}')),
                              ),
                            ),
                            if (cubit.postImage != null)
                              Expanded(
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    //container of post
                                    Container(
                                      height: 160,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              // image: NetworkImage(
                                              //     'https://img.freepik.com/free-vector/abstract-colorful-hand-painted-wallpaper_52683-61599.jpg?w=740') ,
                                              image:
                                                  FileImage(cubit.postImage!),
                                              fit: BoxFit.cover)),
                                    ),
                                    //widget of get post image
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          //remove post method
                                          cubit.removeDoctorPostImage();
                                        },
                                        child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                defaultColor.withOpacity(.7),
                                            child: Icon(
                                              IconBroken.Close_Square,
                                              size: 23,
                                              color: Colors.black,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      cubit.getDoctorPostImage();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(IconBroken.Image),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Add photo"),
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                  widgetBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ))),
        );
      },
    );
  }
}
