import 'package:doctorapp/shared/cubit/app_cubit/app%20cubit.dart';
import 'package:doctorapp/shared/styles/colors/color.dart';
import 'package:doctorapp/shared/styles/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

//navigate with remove
void navigateAndRemove({context, widget}) => {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => widget), (route) => false)
    };
//to navigate
void navigateTo({required context, required widget}) =>
    {Navigator.push(context, MaterialPageRoute(builder: (context) => widget))};
//navigate to back
void backTo({required context, required widget}) =>
    {Navigator.pop(context, MaterialPageRoute(builder: (context) => widget))};

//defaultTextButton
Widget textButton({required String text, required VoidCallback? fun}) =>
    TextButton(onPressed: fun, child: Text(text.toUpperCase()));
//defaultButton
Widget defaultButton({
  double radius = 0,
  double width = double.infinity,
  Color color = defaultColor,
  bool isUpper = true,
  required String text,
  required VoidCallback fun,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          " ${isUpper ? text.toUpperCase() : text} ",
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        onPressed: fun,
      ),
    );
//defaultFormField
Widget defaultFormField({
  String? initialValue,
  TextEditingController? controller,
  required TextInputType textKeyboard,
  IconData? suffix,
  String? helper = '',
  GestureTapCallback? onTaped,
  bool isPassword = false,
  required IconData prefix,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  required FormFieldValidator<String> validate,
  required String textLabel,
  VoidCallback? suffixPressed,
  FormFieldSetter<String>? onSaved,
}) =>
    TextFormField(
      onSaved: onSaved,
      initialValue: initialValue,
      validator: validate,
      controller: controller,
      keyboardType: textKeyboard,
      obscureText: isPassword,
      decoration: InputDecoration(
        helperText: '$helper',
        labelText: textLabel,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTaped,
    );
//Toat
void toast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { warning, error, success }

Color? color;

Color chooseToastColor(ToastState state) {
  switch (state) {
    case (ToastState.success):
      color = Colors.green;
      break;

    case (ToastState.error):
      color = Colors.red;
      break;
    case (ToastState.warning):
      color = Colors.amber;
      break;
  }
  return color!;
}

//full TXT
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//appBar
PreferredSizeWidget? defaultAppBar({
  List<Widget>? actions,
  String? title,
  required BuildContext context,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      titleSpacing: 5.0,
      title: Text('$title'),
      actions: actions,
    );
//drop down list
Widget defaultDropDownList({
  selectedValue,
  required List<String> dropdownItems,
  required context,
  required String labelText,
  required FormFieldValidator ? validator,
}) =>
    DropdownButtonFormField(
      isExpanded: true,
      menuMaxHeight: 100,
      validator:validator ,

      hint: Text(labelText),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(

          borderSide: const BorderSide(color: defaultColor, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),

        filled: false,
      ),
      value: selectedValue,
      onChanged: (newValue) {
        AppCubit.get(context).dropDownChange(
            newValue: newValue,
            selectedValue: selectedValue ?? const Text('Click to choose'));
      },
      items: dropdownItems.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
    );
//CheckBox List
Widget defaultCheckList(
{required List <MultiSelectItem> items , required String text  , IconData? icon , required String buttonText ,  selectedValue,

  required context,
  required label,

}

    )=> MultiSelectDialogField(
  items: items.map((e) => MultiSelectItem(e, label)).toList(),
  title: Text(text),
  selectedColor: defaultColor,
  decoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.1),
    borderRadius: BorderRadius.all(Radius.circular(40)),
    border: Border.all(
      color: Colors.blue,
      width: 2,
    ),
  ),
  buttonIcon: Icon(
    icon ,

  ),
  buttonText: Text(
    buttonText,
    style: TextStyle(
      color: Colors.blue[800],
      fontSize: 16,
    ),
  ),
  onConfirm: (results) {
    AppCubit.get(context).checkListChange(

      selectedValue: selectedValue ,
      newValue: results
    ) ;
  },
);

