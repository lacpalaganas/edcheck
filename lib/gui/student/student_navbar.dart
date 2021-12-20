/// Flutter code sample for BottomNavigationBar

import 'package:flutter/material.dart';
import 'package:edcheck/gui/myapp.dart';

class StudentNavBar extends StatefulWidget {
  final Function(int) callback;
  StudentNavBar(this.callback);

  @override
  State<StudentNavBar> createState() => StudentNavBarState();
}

class StudentNavBarState extends State<StudentNavBar> {
  int selectedIndex = 0;
  MyAppState myapp = new MyAppState();

  void onItemTapped(int index) {
    int page = index + 4;
    if (page > 3 && page < 6) {
      widget.callback(page);
      setState(() {
        selectedIndex = index;
      });
      print('DEbbugg: Selected Student Nav(tech): ' + page.toString());
      print('DEbbugg: Selected Student Nav(Actual): ' + index.toString());
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
          label: 'Unchecked',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pending),
          backgroundColor: Colors.black,
          label: 'Checked',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          backgroundColor: Colors.black,
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.app_registration),
          backgroundColor: Colors.black,
          label: 'Feedback',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green[800],
      onTap: onItemTapped,
    );
  }
}
