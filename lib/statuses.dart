import 'package:admin/card.dart';
import 'package:admin/donation_status.dart';
import 'package:admin/request_status.dart';
import 'package:flutter/material.dart';

class statuses extends StatelessWidget {
  const statuses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .15,
                ),
                Container(
                  height: 250,
                  width: 200,
                  child: CategoryCard(
                      svgSrc: 'assets/icons/orphanage.png',
                      title: 'Request Status',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => request_status()),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  width: 200,
                  child: CategoryCard(
                      svgSrc: 'assets/icons/donate.png',
                      title: 'Donation Status',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => donation_status()),
                        );
                      }),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
