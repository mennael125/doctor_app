import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'chat_detail.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        ListView.separated(
            itemCount: 10, itemBuilder: (BuildContext
        context, int index) =>
            InkWell(onTap: () {
              navigateTo(
                  context: context, widget: ChatDetailUi());
            },
              child: Row(
                children: [
                //widget of circle picture
                CircleAvatar(
                radius: 27,
                backgroundColor: defaultColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/couple-doctors-with-stethoscope-avatar-character_24877-63673.jpg?t=st=1650997810~exp=1650998410~hmac=5d192d1fb84a676b22df97553e5a5052171c0b69348ed0d7e170010d36ce1a7b&w=740'


                ), radius: 25,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "User Name  $index",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(height: 1.4),
            ),
            ]
        ),
      )
      , separatorBuilder: (BuildContext context, int index) =>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(width: double.infinity, color: Colors.grey[300],),
        )
      ,),


    )
    );
  }
}
