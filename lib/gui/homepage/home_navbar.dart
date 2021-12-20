/// Flutter code sample for BottomNavigationBar

import 'package:flutter/material.dart';
import 'package:edcheck/gui/myapp.dart';

class HomeNavBar extends StatefulWidget {
  final Function(int) callback;
  HomeNavBar(this.callback);

  @override
  State<HomeNavBar> createState() => NavBarState();
}

class NavBarState extends State<HomeNavBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    if (index < 4) {
      setState(() {
        selectedIndex = index;
      });
      widget.callback(index);
      print('DEbbugg: Selected Home Nav: ' + index.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: Colors.black,
          label: 'Welcome',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          backgroundColor: Colors.black,
          label: 'Checkers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          backgroundColor: Colors.black,
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.app_registration),
          backgroundColor: Colors.black,
          label: 'Sign Up',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green,
      onTap: onItemTapped,
    );
  }
}
