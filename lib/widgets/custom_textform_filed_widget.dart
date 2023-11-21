import 'package:flutter/material.dart';

class CustomTextFormFiledWidget extends StatelessWidget {


  CustomTextFormFiledWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.textFormFiledValidator,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();
  String hintText;
  String? Function(String?)? textFormFiledValidator;
  bool obscureText;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: textFormFiledValidator,
      style: TextStyle(fontSize:16, color:Colors.black87,fontWeight: FontWeight.w400),
      cursorColor: Colors.black87,
      controller: controller,
      obscureText: obscureText,

      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle:  TextStyle(fontSize:16, color:Colors.black87,fontWeight: FontWeight.w400),
          filled: true,
          contentPadding: const EdgeInsets.all(12),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 1.0,),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 1.0,),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0), // Set error border color to white
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),

        //  errorStyle: TextStyle(12, Colors.red, FontWeight.w400),


      ),



    );
  }
}
