import 'package:admin/controller/signup_controller.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/orphanages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class doner_signup extends StatefulWidget {
  const doner_signup({super.key});

  @override
  State<doner_signup> createState() => _doner_signupState();
}

final controller = Get.find<SignUpController>();
final _formKey = GlobalKey<FormState>();

class _doner_signupState extends State<doner_signup> {
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
                      Color(0xFFF2BEA1),
                      Color(0xFFF2BEA1),
                      Color(0xFFF2BEA1),
                      Color(0xFFF2BEA1),
                      Color(0xFFF2BEA1)
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
                          "ADD ORPHANAGE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        buildmail(
                            name: 'Full name',
                            typeIcon: Icons.person,
                            type: TextInputType.name,
                            ctrl: controller.fullname),
                        SizedBox(
                          height: 20,
                        ),
                        buildmail(
                            name: 'Email',
                            typeIcon: Icons.email,
                            type: TextInputType.emailAddress,
                            ctrl: controller.email),
                        SizedBox(
                          height: 20,
                        ),
                        buildmail(
                            name: 'Phone',
                            typeIcon: Icons.phone,
                            type: TextInputType.phone,
                            ctrl: controller.phone),
                        SizedBox(
                          height: 20,
                        ),
                        buildpassword(name: 'Password'),
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

  Widget buildmail(
      {required String name,
      required IconData typeIcon,
      required TextInputType type,
      required final ctrl}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        name,
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
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          controller: ctrl,
          keyboardType: type,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                typeIcon,
                color: Color(0x66F39C12),
              ),
              hintText: name,
              hintStyle: TextStyle(color: Colors.black38)),
        ),
      ),
    ]);
  }

  Widget buildpassword({required String name}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        name,
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
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
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
              hintText: name,
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
          final doner = userModel(
              email: controller.email.text.trim(),
              password: controller.password.text.trim(),
              fullname: controller.fullname.text.trim(),
              phone: controller.phone.text.trim());
          SignUpController.instance.createDoner(doner);
          if (_formKey.currentState!.validate()) {
            SignUpController.instance.registerUser(
                controller.email.text.trim(), controller.password.text.trim());
          }
        },
        child: Text(
          "CREATE",
          style: TextStyle(
              color: Color(0xFFF39C12),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
