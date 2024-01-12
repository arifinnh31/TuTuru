import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:tuturu/core/app_export.dart';
import 'package:tuturu/widgets/custom_elevated_button.dart';
import 'package:tuturu/widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar',
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
                _buildName(),
                SizedBox(height: 20),
                _buildAddress(),
                SizedBox(height: 20),
                _buildDateOfBirth(),
                SizedBox(height: 20),
                _buildEmail(),
                SizedBox(height: 20),
                _buildPassword(),
                SizedBox(height: 20),
                _buildSignUp(),
                SizedBox(height: 20),
                _buildDividerRow(),
                SizedBox(height: 20),
                _buildSignUpWithGoogle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return CustomTextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      hintText: 'Nama Lengkap',
    );
  }

  Widget _buildAddress() {
    return CustomTextFormField(
      controller: _addressController,
      keyboardType: TextInputType.streetAddress,
      hintText: 'Tempat Tinggal',
    );
  }

  Widget _buildDateOfBirth() {
    return CustomTextFormField(
      controller: _dateOfBirthController,
      keyboardType: TextInputType.datetime,
      hintText: 'Tanggal Lahir',
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

  Widget _buildSignUp() {
    return CustomElevatedButton(
      width: 288,
      height: 60,
      buttonColor: Get.theme.primaryColor,
      onPressed: () {
        _signUp();
      },
      child: Text('Daftar', style: TextStyle(fontSize: 17)),
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

  Widget _buildSignUpWithGoogle() {
    return CustomElevatedButton(
      width: 288,
      height: 60,
      buttonColor: Get.theme.primaryColorLight,
      onPressed: () {
        _signUpWithGoogle();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.g_mobiledata, size: 40, color: Get.theme.primaryColor),
          Text('Daftar dengan Google', style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'address': _addressController.text.trim(),
        'dateOfBirth': _dateOfBirthController.text.trim(),
      });

      if (userCredential.user != null) {
        Get.offAll(() => AppNavigation());
      }
    } catch (e) {
      logger.e('Error occurred: $e');
    }
  }

  Future<void> _signUpWithGoogle() async {
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
