import 'package:admin/controller/login_controller.dart';
import 'package:admin/create_orphanage.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/user_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class orphanahges extends StatefulWidget {
  const orphanahges({super.key});

  @override
  State<orphanahges> createState() => _orphanahgesState();
}

class _orphanahgesState extends State<orphanahges> {
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<List<userModel>>(
              future: controller.getOrphanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return user_list(
                              id: snapshot.data![index].id.toString(),
                              name: snapshot.data![index].fullname.toString(),
                              email: snapshot.data![index].email.toString(),
                              phone: snapshot.data![index].phone.toString(),
                              userType: 'orphanage',
                            );
                          }),
                    );
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => doner_signup()),
          );
        },
        backgroundColor: Color(0xFFF2BEA1),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
