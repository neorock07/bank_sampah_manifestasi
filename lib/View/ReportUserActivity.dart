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

class ReportUserActivity extends StatefulWidget {
  const ReportUserActivity({Key? key}) : super(key: key);

  @override
  _ReportUserActivityState createState() => _ReportUserActivityState();
}

class _ReportUserActivityState extends State<ReportUserActivity> {
  //inisiasi variable controller transaction
  TransactionController transactionController =
      Get.put(TransactionController());
  
  //fungsi untuk memanggil function dari controller transaction
  //untuk get data history transaksi berdasarkan id akun user saat ini
  Future<void> getData() async {
    await transactionController.getRequestById(context);
  }

  RxString name = "".obs;
  SharedPreferences? pref;
  //inisiasi controller authentication
  var authController = Get.put(AuthController());
  
  //mendapatkan data nama akun yang telah disimpan di shared preferences
  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref!.getString("nama")!;
  }

  //load kedua fungsi tadi pada saat halaman ini pertama kali dimuat
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
                  "Laporan Hasil Transaksi",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Bree",
                    fontSize: 20.sp,
                  ),
                ),
                //profile ketika di klik, akan muncul alert dialog dan sebuah tombol log-out
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
                                  // menghapus data shared preferences yang menyimpan data akun sekarang,
                                  
                                  pref!.clear();
                                  //ubah kondisi loading pada halaman login dan register ke kondisi semula (agar tidak muncul loading ketika kembali ke halaman login/register)
                                  authController.isLoading.value = false;
                                  authController.isLoading2.value = false;
                                  authController.isLoading3.value = false;
                                  authController.isLoading4.value = false;
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
                  //tampilkan gambar 404 jika tidak ada data
                  child: (transactionController.list_history_user_data.isEmpty)
                      ? Container(
                          height: 80.dm,
                          width: 80.dm,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/not.png"),
                                  fit: BoxFit.cover)),
                        )
                        //tampilkan daftar history laporan transaksi jika ada data
                      : ListView.builder(
                          itemCount:
                              transactionController.list_history_user_data.value.length,
                          itemBuilder: (_, index) {
                            var item =
                                transactionController.list_history_user_data.value;
                            return Padding(
                              padding: EdgeInsets.all(10.dm),
                              //tampilkan data yang didapat ke widget Card report
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
