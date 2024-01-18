// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuturu/core/app_export.dart';

class LearnPage extends StatelessWidget {
  LearnPage({super.key});

  final List<String> letters = List.generate(
      26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        backgroundColor: Get.theme.primaryColor,
        toolbarHeight: 156,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildImage(),
            SizedBox(height: 20),
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yuk Mulai Belajar\nAlfabet',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          'Tambah keahlian kamu dengan belajar Bahasa\nIsyarat bersama TuTuru.',
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgLearnPage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      height: Get.height - 156 - 140 - 40 - 30,
      child: ListView.builder(
        itemCount: letters.length,
        itemBuilder: (context, index) {
          final letter = letters[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            elevation: 10,
            child: Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  'Huruf ${letter.toUpperCase()}',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                  _details(letter);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _details(String letter) {
    Get.bottomSheet(
      Scaffold(
        appBar: AppBar(
          title: null,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Huruf ${letter.toUpperCase()}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/huruf_$letter.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
