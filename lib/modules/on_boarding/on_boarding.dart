import 'package:doctorapp/modeles/onboarding_model.dart';
import 'package:doctorapp/modules/login_screen/login_screen.dart';
import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/network/local/cach_helper.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingModel> items = [
    OnBoardingModel(
        image: 'assets/images/4.jpg', title: 'Abbreviations of CHEVA ', body: 'Community Healthcare Express Visit App'),
    OnBoardingModel(
        image: 'assets/images/1.jpeg', title: 'Welcome to CHEVA ', body: 'Let\'s make better communication and evade the confusion among medical assistants and patients.'),
    OnBoardingModel(
        image: 'assets/images/2.jpeg', title: 'Easy to use', body: 'The system can be used anytime and from anywhere by the doctor or patient.'),
    OnBoardingModel(
        image: 'assets/images/3.jpeg', title: 'Your specialist ', body: 'Consult with your own healthcare specialist, wherever you are, using messaging app.'),
  ];
  var boarderController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.savetData(
        key: 'onBoardingSkip',
        value: true)
        .then((value) {
      if (value) {
        navigateAndRemove(widget:
        LoginScreen(), context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [textButton(fun: submit, text: 'skip')],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView.builder(
            onPageChanged: (index) {
              if (index == items.length - 1) {
                setState(() {
                  isLast = true;
                });
              } else {
                setState(() {
                  isLast = false;
                });
              }
            },
            controller: boarderController,
            itemBuilder: (context, index) => onBoarding(items[index]),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
          )),
    );
  }

  Widget onBoarding(OnBoardingModel model) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(model.image ),width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            Text(
              model.title,
              style: const TextStyle(fontSize: 35),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              model.body,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boarderController,
                  count: items.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boarderController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            )
          ],
        ),
  );
}
