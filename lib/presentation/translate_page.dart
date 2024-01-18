// ignore_for_file: must_be_immutable

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslatePage extends StatefulWidget {
  TranslatePage({
    Key? key,
    required this.cameras,
    required this.isSign,
  }) : super(key: key);

  final List<CameraDescription> cameras;
  bool isSign;

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  Widget build(BuildContext context) {
    bool isSign = widget.isSign;

    return Scaffold(
      appBar: AppBar(
        title: Text('Translator'),
        centerTitle: true,
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              isSign ? _buildCamera() : _buildRecord(),
              Divider(height: 1, thickness: 1, color: Colors.black),
              SizedBox(height: 10),
              isSign ? _buildButtonInfo() : SizedBox(),
              SizedBox(height: 10),
              isSign ? _buildTriggerButton() : SizedBox(),
              SizedBox(height: 20),
              _buildTextResult(),
            ],
          ),
          isSign ? _buildSwapToSpeech() : _buildSwapToSign(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSwapToSpeech() {
    return Container(
      width: 189,
      height: 36,
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () {
          setState(() {
            widget.isSign = false;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 81,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFDEE9FF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                "Sign Language",
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            Icon(Icons.arrow_forward, size: 15, color: Colors.black),
            Container(
              width: 37,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFDEE9FF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                "Text",
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwapToSign() {
    return Container(
      width: 147,
      height: 36,
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () {
          setState(() {
            widget.isSign = true;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 47,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFDEE9FF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                "Speech",
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            Icon(Icons.arrow_forward, size: 15, color: Colors.black),
            Container(
              width: 37,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFDEE9FF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                "Text",
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCamera() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: Get.width,
          height: 500,
          color: Colors.black,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20, bottom: 20),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.switch_camera_sharp, size: 28),
          ),
        )
      ],
    );
  }

  Widget _buildRecord() {
    return Container(
      width: Get.width,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Klik untuk Merekam', style: TextStyle(fontSize: 15)),
          SizedBox(height: 10),
          Text(
            'Sentuh sekali untuk Merekam,\nsentuh sekali lagi untuk berhenti',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Color(0xFF999999)),
          ),
          SizedBox(height: 40),
          Container(
            width: 155,
            height: 155,
            decoration: BoxDecoration(
              color: Color(0xFF98C455),
              borderRadius: BorderRadius.circular(77.5),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.mic, size: 70, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonInfo() {
    return Text(
      'Klik sekali untuk mulai,\nklik sekali untuk berhenti.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget _buildTriggerButton() {
    return SizedBox(
      width: 208,
      height: 28,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        child: Text('Start Translate', style: TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildTextResult() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text('Text:', style: TextStyle(fontSize: 15)),
    );
  }
}
