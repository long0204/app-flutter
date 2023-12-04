import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController{

  @override
  void onInit(){
    super.onInit();
    initCamera();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;
  late CameraImage cameraImage;

  var isCameraInittialzed =false.obs;
  var cameraCount =0;

  initCamera()async
  {
    if(await Permission.camera.request().isGranted){

      cameras =await availableCameras();

      cameraController =CameraController(
       cameras[0] , ResolutionPreset.max
      );
      await cameraController.initialize();
      isCameraInittialzed(true);
      update();
    }
    else{
      print("Permission denied");
    }
  }
  objectDectector(CameraImage image)async{
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
        }).toList(),
        asynch: true,
        imageHeight: image.height,
        imageMean: 127.5,
        imageWidth: image.width,
        imageStd: 127.5,
        numResults: 1,
        rotation: 90,
        threshold: 0.4,
      );
      if(detector != null){
        log("Result is $detector" as num);
      }
  }
}