import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DropDownTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final IconData? icon1;
  final Color? color;
  final Color? color_text;
  final bool? enable;
  final bool? readOnlyIn;
  final int? length;
  final Color? backgroundColor;
  final TextInputType? keyboardtype;
  final List<TextInputFormatter>? inputformetter;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? textFormFieldMargin;
  final FormFieldValidator<String>? validator;

  DropDownTextField(
      {Key? key,
        this.hintText,
        this.icon,
        this.icon1,
        this.onChanged,
        this.enable,
        this.readOnlyIn,
        this.length,
        this.onTap,
        this.color_text,
        this.keyboardtype,
        this.inputformetter,
        this.color = Colors.white,
        this.backgroundColor = Colors.blueAccent,
        this.textFormFieldMargin,
        this.validator,
        this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: color,
      validator: validator,
      maxLength: length,
      enabled: enable,
      onTap: onTap,
      readOnly:readOnlyIn??false,
      inputFormatters: inputformetter,
      keyboardType: keyboardtype,
      style: TextStyle(color: color_text,fontSize: 15),
      decoration: InputDecoration(
        border: InputBorder.none,
        suffixIcon: Icon(icon1),
        hintText: hintText,
        hintStyle: TextStyle(color: color, fontSize: 13),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        counter: Offstage(),
      ),
    );
  }
}
