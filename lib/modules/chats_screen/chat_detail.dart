import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

var msgController = TextEditingController();

class ChatDetailUi extends StatelessWidget {
  const ChatDetailUi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Reciever Name'),
        leading: IconButton(
          icon: Icon(IconBroken.Arrow___Left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Spacer(),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: defaultColor)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextFormField(
                        controller: msgController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write Your Message'),
                      ),
                    ),
                  ),
                  MaterialButton(
                      onPressed: () {},
                      child: Icon(
                        IconBroken.Send,
                        size: 25,
                        color: defaultColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
