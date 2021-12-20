// add introduction_screen: ^2.1.0 in dependencies > pubspec.yaml

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: 'We Check & Correct It',
            body:
                'You can now re-do your \n assignment knowing the right ways to get it all done. Turn it in and get that A+.',
            image: Container(
              child: Center(
                child: Image.asset(
                    'assets/images/edcheck-img-1.png',
                    width: 350),
              ),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Trueno',
                  color: Colors.green),
              bodyTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Trueno',
                  color: Colors.black),
              descriptionPadding: EdgeInsets.all(0).copyWith(bottom: 0),
              imagePadding: EdgeInsets.fromLTRB(24, 32, 24, 20),
            ),
          ),
          PageViewModel(
            title: 'Your Work Is In Good Hands',
            body:
                'EdCheck has the best academics in the world checking your work.',
            image: Container(
              child: Center(
                child: Image.asset(
                    'assets/images/edcheck-img-2.png',
                    width: 350),
              ),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Trueno',
                  color: Colors.green),
              bodyTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Trueno',
                  color: Colors.black),
              descriptionPadding: EdgeInsets.all(0).copyWith(bottom: 0),
              imagePadding: EdgeInsets.fromLTRB(24, 32, 24, 20),
            ),
          ),
          PageViewModel(
            title: 'Ready For an A+?',
            body: 'Signup now to get \n started.',
            image: Container(
              child: Center(
                child: Image.asset(
                    'assets/images/edcheck-img-2.png',
                    width: 350),
              ),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Trueno',
                  color: Colors.green),
              bodyTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Trueno',
                  color: Colors.black),
              descriptionPadding: EdgeInsets.all(0).copyWith(bottom: 0),
              imagePadding: EdgeInsets.fromLTRB(24, 32, 24, 20),
            ),
          ),
        ],
        done: Text('Get Started',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xff3fb549))),
        onDone: () {},
        showSkipButton: false,
        showDoneButton: false,
        skip: Text('Skip', style: TextStyle(color: Colors.black)),
        onSkip: () {},
        next: Icon(Icons.arrow_forward_outlined, color: Colors.black),
        dotsDecorator: DotsDecorator(
          color: Colors.black,
          activeColor: Color(0xff27AE60),
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
