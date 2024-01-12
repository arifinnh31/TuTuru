// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:tuturu/core/app_export.dart';
import 'package:tuturu/widgets/custom_elevated_button.dart';
import 'package:tuturu/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Masuk',
          style: TextStyle(color: Get.theme.primaryColorDark),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Get.theme.primaryColorDark),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height - 2 * 56,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmail(),
                SizedBox(height: 20),
                _buildPassword(),
                SizedBox(height: 20),
                _buildRememberAccount(),
                SizedBox(height: 20),
                _buildForgotPassword(),
                SizedBox(height: 20),
                _buildSignIn(),
                SizedBox(height: 20),
                _buildDontHaveAccount(),
                SizedBox(height: 20),
                _buildDividerRow(),
                SizedBox(height: 20),
                _buildSignInWithGoogle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return CustomTextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      hintText: 'Alamat Email',
    );
  }

  Widget _buildPassword() {
    return CustomTextFormField(
      controller: _passwordController,
      obscureText: true,
      hintText: 'Kata Sandi',
    );
  }

  Widget _buildRememberAccount() {
    return Container(
      margin: EdgeInsets.only(left: (Get.width - 288) / 2 - 15),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {
              value = !value!;
            },
          ),
          Text('Ingat akun saya', style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: (Get.width - 288) / 2),
      child: Text(
        'Lupa kata sandi?',
        style: TextStyle(fontSize: 17, color: Get.theme.primaryColor),
      ),
    );
  }

  Widget _buildSignIn() {
    return CustomElevatedButton(
      width: 288,
      height: 60,
      buttonColor: Get.theme.primaryColor,
      onPressed: () {
        _signIn();
      },
      child: Text('Masuk', style: TextStyle(fontSize: 17)),
    );
  }

  Widget _buildDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Belum punya akun?'),
        SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Get.to(() => RegisterPage());
          },
          child: Text(
            'Daftar',
            style: TextStyle(
              color: Color(0xFF306FB6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDividerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 128, height: 1, color: Get.theme.primaryColorDark),
        SizedBox(width: 10),
        Text('OR', style: TextStyle(fontSize: 15)),
        SizedBox(width: 10),
        Container(width: 128, height: 1, color: Get.theme.primaryColorDark),
      ],
    );
  }

  Widget _buildSignInWithGoogle() {
    return CustomElevatedButton(
      width: 288,
      height: 60,
      buttonColor: Get.theme.primaryColorLight,
      onPressed: () {
        _signInWithGoogle();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.g_mobiledata, size: 40, color: Get.theme.primaryColor),
          Text(
            'Masuk dengan Google',
            style: TextStyle(color: Get.theme.primaryColorDark, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        Get.offAll(() => AppNavigation());
      }
    } catch (e) {
      logger.e('Error occurred: $e');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          Get.offAll(() => AppNavigation());
        }
      }
    } catch (e) {
      logger.e('Error occurred: $e');
    }
  }
}
