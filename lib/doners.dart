import 'package:admin/controller/login_controller.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/user_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class doners extends StatefulWidget {
  const doners({super.key});

  @override
  State<doners> createState() => _donersState();
}

class _donersState extends State<doners> {
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<userModel>>(
        future: controller.getDoners(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return user_list(
                      id: snapshot.data![index].id.toString(),
                      name: snapshot.data![index].fullname.toString(),
                      email: snapshot.data![index].email.toString(),
                      phone: snapshot.data![index].phone.toString(),
                      userType: 'doner',
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Text('Something went wrong.');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
