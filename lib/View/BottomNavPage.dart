import 'package:bank_sampah/View/HistoryActivity.dart';
import 'package:bank_sampah/View/HomeActivity.dart';
import 'package:bank_sampah/View/ReportActivity.dart';
import 'package:bank_sampah/View/ShopActivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';


class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  var selectedTab = 0.obs;

  _setPage(int index) {
    selectedTab.value = index;
  }

  List _pages = [
    HomeActivity(),
    ShopActivity(),
    ReportActivity(),
    HistoryActivity(),
    HistoryActivity()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            backgroundColor: Colors.white,
            child: Icon(Icons.call, color: Colors.black,),
            ),
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
                    icon: Icon(LucideIcons.shoppingCart, color: Colors.white,), label: ""),
                
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
