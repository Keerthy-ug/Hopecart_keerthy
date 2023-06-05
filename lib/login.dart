import 'package:admin/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ...
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

final controller = Get.find<LoginController>();
final _formKey = GlobalKey<FormState>();
Widget buildmail() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      "Email",
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 10,
    ),
    Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: 60,
      child: TextField(
        controller: controller.email,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color: Color(0x66F39C12),
            ),
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.black38)),
      ),
    ),
  ]);
}

Widget buildpassword() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      "Password",
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 10,
    ),
    Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: 60,
      child: TextField(
        controller: controller.password,
        obscureText: true,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0x66F39C12),
            ),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.black38)),
      ),
    ),
  ]);
}

Widget buildloginbtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        LoginController.instance.loginUser(
            controller.email.text.trim(), controller.password.text.trim());
      },
      child: Text(
        "LOGIN",
        style: TextStyle(
            color: Color(0xFFF39C12),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(),
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFFF39C12),
                      Color(0xCCF39C12),
                      Color(0x99F39C12),
                      Color(0x66F39C12),
                    ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        buildmail(),
                        SizedBox(
                          height: 20,
                        ),
                        buildpassword(),
                        SizedBox(
                          height: 20,
                        ),
                        buildloginbtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
