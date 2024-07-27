import 'package:get/get.dart';

class ItemPickedController extends GetxController {
  RxDouble total_non = 0.0.obs;
  RxDouble total_organik = 0.0.obs;
  RxInt total_point = 0.obs;
  Map<int, double> map_controller_index = {};
  Map<int, double> map_controller_organik_index = {};
}