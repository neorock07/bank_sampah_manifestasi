import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget SearchCard(BuildContext context,
    {required TextEditingController controller, 
      String? hint = ""
    }) {
  return IntrinsicHeight(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 216, 216),
        borderRadius: BorderRadius.circular(20.dm),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.dm),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(
                  fontFamily: "Poppins"
                ),
                controller: controller,
                scribbleEnabled: false,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hint,
                  disabledBorder: const OutlineInputBorder(
                    gapPadding: 0, borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(3.dm)
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
