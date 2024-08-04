import 'package:bank_sampah/Partials/Card/HistoryCard.dart';
import 'package:bank_sampah/Partials/Card/ReportCard.dart';
import 'package:bank_sampah/Partials/Dialog/DialogPop.dart';
import 'package:bank_sampah/ViewModel/AuthController.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportActivity extends StatefulWidget {
  const ReportActivity({Key? key}) : super(key: key);

  @override
  _ReportActivityState createState() => _ReportActivityState();
}

class _ReportActivityState extends State<ReportActivity> {
  //inisiasi controller transaction
  TransactionController transactionController =
      Get.put(TransactionController());
  
  //function untuk get data transaksi dari database
  Future<void> getData() async {
    await transactionController.getTransaksi(context);
  }
  //inisiasi shared preferences, controller authentication
  RxString name = "".obs;
  SharedPreferences? pref;
  var authController = Get.put(AuthController());
  
  //function untuk get data nama akun dari shared preferences
  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref!.getString("nama")!;
  }

  //panggil kedua function saat halaman ini dimuat pertama kali
  @override
  void initState() {
    super.initState();
    getData();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    //untuk setting status bar
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color.fromRGBO(70, 178, 133, 1),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(99, 215, 167, 1),
        body: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            //text title halaman
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Laporan Hasil Transaksi",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Bree",
                    fontSize: 20.sp,
                  ),
                ),

                //profile ketika di klik akan muncul alert dialog dengan button log-out
                InkWell(
                  onTap: () async {
                    DialogPop(context,
                        icon: Column(
                          children: [
                            Text("Tekan untuk keluar Akun",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 14.sp)),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green)),
                                onPressed: () {
                                  // hapus data dari shared preferences, dan kembalikan kondisi loading agar tidak muncul saat kembali ke halaman loading atau register
                                  pref!.clear();
                                  authController.isLoading.value = false;
                                  authController.isLoading2.value = false;
                                  authController.isLoading3.value = false;
                                  authController.isLoading4.value = false;
                                  //setelah logout pergi ke halaman login
                                  Navigator.pushReplacementNamed(
                                      context, "/login");
                                },
                                child: Text(
                                  "Log-Out",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 14.sp),
                                ))
                          ],
                        ));
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/sd.jpeg"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() => Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  //cek kondisi apakah data sudah ada 
                  child: (transactionController.list_user_data.isEmpty)
                      ? 
                      //jika data kosong tampilkan 404
                      Container(
                          height: 80.dm,
                          width: 80.dm,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/not.png"),
                                  fit: BoxFit.cover)),
                        )
                      : 
                      //jika data sudah ada maka tampilkan list view dengan widget report card
                      ListView.builder(
                          itemCount:
                              transactionController.list_user_data.value.length,
                          itemBuilder: (_, index) {
                            var item =
                                transactionController.list_user_data.value;
                            return Padding(
                              padding: EdgeInsets.all(10.dm),
                              child: ReportCard(context,
                                  non: item[index]["total_non"],
                                  organik: item[index]["total_organik"],
                                  poin: item[index]["poin"],
                                  non_item: item[index]["items_non"],
                                  organik_item: item[index]["items_organik"],
                                  user: "assets/images/avatar.png",
                                  name: item[index]["nama"],
                                  address: item[index]["alamat"]),
                            );
                          }),
                ))
          ],
        ),
      ),
    );
  }
}
