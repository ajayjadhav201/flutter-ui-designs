import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              Image.asset(
                "assets/instagram.png",
                height: 72,
                width: 72,
              ),
              SizedBox(height: 100),
              Tile(
                height: 40,
                width: size.width * 0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: textfieldBorder(),
                    hintText: "Username, email or mobile number",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      height: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                    enabledBorder: textfieldBorder(Colors.black),
                    focusedBorder: textfieldBorder(Colors.black),
                    errorBorder: textfieldBorder(Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Tile(
                height: 40,
                borderRadius: BorderRadius.circular(20),
                width: size.width * 0.9,
                color: Colors.blue,
                alignment: center,
                label: Txt(
                  "Login",
                  style: bold(18).paint(Colors.white),
                ),
              ).center
            ],
          ),
        ),
      ),
    );
  }
}

InputBorder textfieldBorder([Color color = Colors.black45]) =>
    OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    );
