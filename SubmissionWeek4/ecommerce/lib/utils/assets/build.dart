import 'package:flutter/material.dart';
import 'package:ecommerce/utils/assets/color.dart';
import 'package:ecommerce/utils/assets/text_style.dart';

Widget buildTextField({
  BuildContext context,
  String hint,
  TextEditingController controller,
  FocusNode focus,
  FocusNode nextFocus,
  bool obscure = false,
  int minLines = 1,
  TextInputType inputType = TextInputType.text,
  TextInputAction inputAction = TextInputAction.next,
  IconData icon = Icons.text_fields,
  TextCapitalization textCapital = TextCapitalization.none,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    padding: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      border: Border.all(
        color: colPrimary,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      controller: controller,
      focusNode: focus,
      style: textLabel,
      obscureText: obscure,
      keyboardType: inputType,
      textInputAction: inputAction,
      minLines: minLines,
      maxLines: minLines,
      textCapitalization: textCapital,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: InputBorder.none,
        hintText: hint,
      ),
      onEditingComplete: () {
        if (nextFocus == null) {
          focus.unfocus();
        } else {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Input $hint';
        }
        return null;
      },
    ),
  );
}
