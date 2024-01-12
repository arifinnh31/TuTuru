import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuturu/core/app_export.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Get.theme.primaryColor,
          ),
          onPressed: () {
            _signOut();
          },
          child: Text('Logout'),
        ),
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
    Get.offAll(() => LandingPage());
  }
}
