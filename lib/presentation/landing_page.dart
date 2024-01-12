import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuturu/core/app_export.dart';
import 'package:tuturu/widgets/custom_elevated_button.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            SizedBox(height: 87),
            _buildLogo(),
            _buildSubtitle(),
            SizedBox(height: 74),
            _buildLoginButtons(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Selamat Datang di\nAplikasi TuTuru',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 199,
      height: 267,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgTuturulogo11),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Bebaskan Komunikasimu Dengan\nTeman Tuli & Teman Bisu',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          width: 135,
          height: 45,
          buttonColor: Get.theme.primaryColor,
          onPressed: () {
            Get.to(() => LoginPage());
          },
          child: Text('Masuk'),
        ),
        CustomElevatedButton(
          width: 135,
          height: 45,
          buttonColor: Get.theme.primaryColorLight,
          onPressed: () {
            Get.to(() => RegisterPage());
          },
          child: Text('Daftar'),
        ),
      ],
    );
  }
}
