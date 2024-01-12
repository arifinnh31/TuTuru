import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslatePage extends StatefulWidget {
  TranslatePage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate'),
        centerTitle: true,
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildCamera(),
          SizedBox(height: 10),
          _buildButtonInfo(),
          SizedBox(height: 10),
          _buildTriggerButton(),
          SizedBox(height: 10),
          _buildTextResult(),
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

  Widget _buildCamera() {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: 500,
          color: Get.theme.primaryColorDark,
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
          width: Get.width,
          height: 500,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 189,
                height: 36,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColorLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 81,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Color(0xFFDEE9FF),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Language",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward, size: 15),
                    Container(
                      width: 37,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Color(0xFFDEE9FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Text",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 20, bottom: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.switch_camera_sharp, size: 28),
                ),
              ),
            ],
          ),
        ),
      ],
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text('Text:', style: TextStyle(fontSize: 15)),
    );
  }
}
