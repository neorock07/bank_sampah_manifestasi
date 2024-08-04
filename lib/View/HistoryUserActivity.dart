import 'package:bank_sampah/Partials/Card/HistoryCard.dart';
import 'package:bank_sampah/Partials/Dialog/DialogPop.dart';
import 'package:bank_sampah/View/LoginActivity.dart';
import 'package:bank_sampah/ViewModel/AuthController.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryUserActivity extends StatefulWidget {
  const HistoryUserActivity({Key? key}) : super(key: key);

  @override
  _HistoryUserActivityState createState() => _HistoryUserActivityState();
}
//halaman untuk history user
class _HistoryUserActivityState extends State<HistoryUserActivity> {
  TransactionController transactionController =
      Get.put(TransactionController());

//get data history dari database
  Future<void> getData() async {
    await transactionController.getRequestById(context);
  }

  RxString name = "".obs;
  SharedPreferences? pref;
  //get data akun dari shared preferences
  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref!.getString("nama")!;
  }

  //controller auth
  var authController = Get.put(AuthController());

///jalankan kedua function pada saat pertama kali buka halaman
  @override
  void initState() {
    super.initState();
    getData();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "History Transaksi",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Bree",
                    fontSize: 20.sp,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    //dialog alert untuk log out
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
                                //hapus data login dari shared preferences ketika logout kemudian pergi login
                                  pref!.clear();
                                  authController.isLoading.value = false;
                                  authController.isLoading2.value = false;
                                  authController.isLoading3.value = false;
                                  authController.isLoading4.value = false;
                               
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginActivity()));    
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
                    backgroundImage: AssetImage("assets/images/avatar.png"),
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
                  child: (transactionController.list_history_user_data.isEmpty)
                      ? 
                      //cek apakah data kosong, jika kosong tampilkan 404
                      Container(
                        height: 80.dm,
                        width: 80.dm,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/not.png"), fit: BoxFit.cover)
                        ),
                      )
                      : 
                      //jika tidak kosong maka tampilkan list history user
                      ListView.builder(
                          itemCount:
                              transactionController.list_history_user_data.value.length,
                          itemBuilder: (_, index) {
                            var item =
                                transactionController.list_history_user_data.value;
                            return Padding(
                              padding: EdgeInsets.all(10.dm),
                              //gunakan widget history card untuk menampilkan data history
                              child: HistoryCard(context,
                                  non: item[index]["total_non"],
                                  organik: item[index]["total_organik"],
                                  poin: item[index]["poin"],
                                  asset: "assets/images/teflon.png",
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
