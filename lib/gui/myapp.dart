// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:edcheck/gui/checker/checker_checked.dart';
import 'package:edcheck/gui/checker/checker_dashboard.dart';
import 'package:edcheck/gui/checker/checker_in_review.dart';
import 'package:edcheck/gui/checker/checker_profile.dart';
import 'package:edcheck/gui/homepage/welcome.dart';
import 'package:edcheck/gui/student/checked.dart';
import 'package:edcheck/gui/student/feedback.dart';
import 'package:edcheck/gui/student/profile.dart';
import 'package:edcheck/gui/student/student_navbar.dart';
import 'package:edcheck/gui/student/unchecked.dart';
import 'package:edcheck/internal/assignment_data.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'homepage/login_form.dart';
import 'package:flutter/material.dart';
import 'homepage/check_tab.dart';
import 'homepage/home_navbar.dart';
import 'homepage/register_form.dart';
import 'student/feedback.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final List<Widget> _NavItemsHome = [];
  final List<Widget> _NavItemsStudent = [];
  final List<Widget> _NavItemsChecker = [];

  var _NavItems;
  late TabController _controller;

  void initState() {
    super.initState();

    _controller = TabController(vsync: this, length: 4);

    _NavItemsHome.insert(0, Welcome());
    _NavItemsHome.insert(1, CheckerList());
    _NavItemsHome.insert(2, LoginForm(onChangePage));
    _NavItemsHome.insert(3, RegisterForm());
    _NavItemsStudent.insert(0, CheckedAssignments());
    _NavItemsStudent.insert(1, UncheckedAssignments());
    _NavItemsStudent.insert(2, Profile(onChangePage));
    _NavItemsStudent.insert(3, FeedbackTab());
    _NavItemsChecker.insert(0, CheckerDashboard());
    _NavItemsChecker.insert(1, CheckerInReview());
    _NavItemsChecker.insert(2, CheckerCheckedAssignments());
    _NavItemsChecker.insert(3, CheckerProfile(onChangePage));
    _NavItems = _NavItemsHome;
    tabs = homeTab;
  }

  void nothingToDo(String test) {}

  void onChangePage(String page) async {
    setState(() {
      if (page == 'student') {
        _NavItems = _NavItemsStudent;

        tabs = studentTab;
      } else if (page == 'checker') {
        _NavItems = _NavItemsChecker;
        tabs = checkerTab;
      } else {
        _NavItems = _NavItemsHome;
        tabs = homeTab;
      }
    });
    await new Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _controller.animateTo(0);
    });
  }

  final checkerTab = <Widget>[
    Tab(
      icon: Icon(
        Icons.dashboard,
      ),
      child: Text(
        'Dashboard',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(
        Icons.rate_review,
      ),
      child: Text(
        'In Review',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(Icons.assignment_turned_in),
      child: Text(
        'Checked',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(Icons.account_box_rounded),
      child: Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
  ];

  final studentTab = <Widget>[
    Tab(
      icon: Icon(
        Icons.assignment_turned_in,
      ),
      child: Text(
        'Checked',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.normal,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(
        Icons.assignment,
      ),
      child: Text(
        'Unchecked',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(Icons.account_box_rounded),
      child: Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(Icons.add_comment),
      child: Text(
        'Feedback',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
  ];

  final homeTab = <Widget>[
    Tab(
      icon: Icon(
        Icons.home,
      ),
      child: Text(
        'Welcome',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(
        Icons.fact_check,
      ),
      child: Text(
        'Checkers',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(Icons.account_box_rounded),
      child: Text(
        'Login',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
    Tab(
      icon: Icon(Icons.add_box_rounded),
      child: Text(
        'Signup',
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11.0),
      ),
    ),
  ];

  var tabs = <Widget>[];
  var nav = <Widget>[];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.green,
          labelStyle: TextStyle(color: Colors.green), // color for text
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Image.asset(
              'assets/images/edcheckLogo.png',
              width: 60.0,
              height: 60.0,
              fit: BoxFit.contain,
            ),
            elevation: 0.7,
            backgroundColor: Colors.white,
            //leading: new Image.asset('assets/images/edcheckLogo.png'),
            centerTitle: true,

            bottom: TabBar(
              controller: _controller,
              indicatorColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: _NavItems,
          ),
        ),
      ),
    );
  }
}
