import 'package:admin/home.dart';
import 'package:admin/statuses.dart';
import 'package:admin/users.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class BottomNavBar extends StatelessWidget {
  final bool status;
  final bool home;
  final bool profile;
  const BottomNavBar({
    Key? key,
    required this.home,
    required this.status,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Users Status",
            svgScr: Icons.history,
            isActive: status,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => statuses()),
              );
            },
          ),
          BottomNavItem(
            title: "Home",
            svgScr: Icons.home,
            isActive: home,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => home_()),
              );
            },
          ),
          BottomNavItem(
            title: "Manage Users",
            svgScr: Icons.manage_accounts,
            isActive: profile,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => users()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData svgScr;
  final String title;
  final VoidCallback press;
  final bool isActive;
  const BottomNavItem({
    Key? key,
    required this.svgScr,
    required this.title,
    required this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          // SvgPicture.asset(
          //   svgScr,
          //   color: isActive ? kActiveIconColor : kTextColor,
          // ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
