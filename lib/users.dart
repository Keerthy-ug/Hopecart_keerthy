import 'package:admin/card.dart';
import 'package:admin/doners.dart';
import 'package:admin/orphanages.dart';
import 'package:flutter/material.dart';

class users extends StatelessWidget {
  const users({super.key});
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
                      title: 'Manage Orphanage',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => orphanahges()),
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
                      title: 'Manage Doner',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => doners()),
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
