import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:submission2/widget/nav_bar_widget.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final _pageController = PageController();

  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () => Get.off(() => NavBarWidget(
            pageController: _pageController,
          )),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/loading.json'),
            Text(
              'UBAY RESTAURANT',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
