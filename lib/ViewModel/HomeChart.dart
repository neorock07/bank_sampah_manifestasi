import 'package:get/get.dart';

class HomeChartController extends GetxController{

  RxMap<String, double> data = <String, double>{
    "Botol Plastik": 12,
    "Sampah makanan" : 64,
    "Kardus" : 8,
    "Kaca" : 8,
    "Logam" : 8
  }.obs;

}