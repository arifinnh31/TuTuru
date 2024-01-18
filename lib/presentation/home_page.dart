import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:tuturu/core/app_export.dart';
import 'package:tuturu/widgets/custom_icon_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 156,
        title: _buildGreetingSection(),
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTranslationSection(),
            SizedBox(height: 30),
            _buildLearningSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    User? user = _auth.currentUser;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            'Hi, ${user?.displayName ?? 'User'}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Yuk Bebaskan Berkomunikasi\ndan Berekspresi!',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationSection() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 148,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Translator',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconButton(
                  icon: Icons.camera_alt,
                  text: 'Sign Language\nto Text',
                  onPressed: () async {
                    List<CameraDescription> cameras = await availableCameras();
                    Get.to(() => TranslatePage(cameras: cameras, isSign: true));
                  },
                ),
                CustomIconButton(
                  icon: Icons.mic,
                  text: 'Speech to Text',
                  onPressed: () async {
                    List<CameraDescription> cameras = await availableCameras();
                    Get.to(
                        () => TranslatePage(cameras: cameras, isSign: false));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningSection() {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Tertarik Belajar\nBahasa Isyarat?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Get.to(() => LearnPage());
            },
            child: Card(
              elevation: 10,
              child: SizedBox(
                width: Get.width - 60,
                height: 227,
                child: Column(
                  children: [
                    Container(
                      width: Get.width - 60,
                      height: 156,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Yuk Belajar Bahasa Isyarat\nBersama TuTuru',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width - 60,
                      height: 71,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mulai Belajar Alfabet',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Mengenal Alfabet dalam Bahasa Isyarat',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
