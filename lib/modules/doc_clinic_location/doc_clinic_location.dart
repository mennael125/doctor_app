import 'package:doctorapp/shared/components/componants.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:flutter/material.dart';

class LocationInfoScreen extends StatelessWidget {
  const LocationInfoScreen({Key? key, this.location,}) : super(key: key);
  final location ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: defaultAppBar(context: context , title: 'View full location') ,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Row(                crossAxisAlignment: CrossAxisAlignment.start,

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
                    location ,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ],
        ),











      ),
    );
  }
}


