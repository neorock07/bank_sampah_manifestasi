import 'package:bank_sampah/View/CalculateItemActivity.dart';
import 'package:bank_sampah/View/HistoryActivity.dart';
import 'package:bank_sampah/View/HomeActivity.dart';
import 'package:bank_sampah/View/ListDriverActivity.dart';
import 'package:bank_sampah/View/ListUserActivity.dart';
import 'package:bank_sampah/View/ReportActivity.dart';
import 'package:bank_sampah/View/ShopActivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavPageDriver extends StatefulWidget {
  BottomNavPageDriver({super.key, this.pelanggan, this.alamat});

  String? pelanggan, alamat;
  @override
  _BottomNavPageDriverState createState() => _BottomNavPageDriverState();
}

class _BottomNavPageDriverState extends State<BottomNavPageDriver> {
  var selectedTab = 0.obs;

  _setPage(int index) {
    selectedTab.value = index;
  }

  List _pages = [
    CalculateItemActivity(),
    ShopActivity(),
    ListUserActivity(),
    ReportActivity(),
    HistoryActivity()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: _pages[selectedTab.value],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedTab.value,
              onTap: (index) => _setPage(index),
              selectedItemColor: Color.fromRGBO(48, 122, 89, 1),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(
                  fontFamily: "Poppins", color: Color.fromRGBO(48, 122, 89, 1)),
              unselectedLabelStyle:
                  const TextStyle(fontFamily: "Poppins", color: Colors.grey),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(LucideIcons.home), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(LucideIcons.shoppingCart), label: ""),

                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    label: ""),

                BottomNavigationBarItem(
                    icon: Icon(Icons.notification_add), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(LucideIcons.history), label: ""),
                // BottomNavigationBarItem(
                //     icon: Icon(LucideIcons.user), label: ""),
              ]),
        ));
  }
}
