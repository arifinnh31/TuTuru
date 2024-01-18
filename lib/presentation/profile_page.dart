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
      appBar: AppBar(
        title: Text('Akun', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          _buildProfile(),
          SizedBox(height: 20),
          _buildDivider(),
          SizedBox(height: 20),
          _buildData(),
          SizedBox(height: 250),
          _buildLogout(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    User? user = _auth.currentUser;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFD9D9D9),
                // backgroundImage: NetworkImage(user?.photoURL ?? ''),
                child: Icon(Icons.person, size: 75, color: Colors.black),
              ),
              SizedBox(width: 10),
              Text(
                user?.displayName ?? '',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email_outlined, color: Colors.black),
              SizedBox(width: 10),
              Text(user?.email ?? '')
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.black),
              SizedBox(width: 10),
              Text(user?.phoneNumber ?? '')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(thickness: 1, color: Colors.black);
  }

  Widget _buildData() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jenis Kelamin',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('Masukkan Data'),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tempat Tinggal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('Masukkan Data'),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tanggal Lahir',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('Masukkan Data'),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogout() {
    return SizedBox(
      width: Get.width - 72,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _signOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.white),
            SizedBox(width: 10),
            Text('Keluar', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
    Get.offAll(() => LandingPage());
  }
}
