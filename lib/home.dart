import 'package:admin/card.dart';
import 'package:admin/cloth.dart';
import 'package:admin/controller/authentication_repository.dart';
import 'package:admin/food.dart';
import 'package:admin/medicine.dart';
import 'package:admin/navigator.dart';
import 'package:admin/stationery.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home_ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        home: true,
        status: false,
        profile: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        AuthenticationRepository.instance.logout();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2BEA1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.logout),
                      ),
                    ),
                  ),
                  Text(
                    "Hello",
                    style: GoogleFonts.kalam(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 60.0),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Food donations",
                          svgSrc: "assets/icons/diet.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => food()),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Stationer items",
                          svgSrc: "assets/icons/stationery.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => stationery()),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "cloth",
                          svgSrc: "assets/icons/clothes.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => cloth()),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Medicines",
                          svgSrc: "assets/icons/medicine.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => medicine()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
