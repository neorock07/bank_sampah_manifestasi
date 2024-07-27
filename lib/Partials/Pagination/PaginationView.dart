import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget PaginationView(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton.filled(
          iconSize: 20.dm,
          color: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen)),
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      IconButton.filled(
          iconSize: 20.dm,
          color: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen)),
          onPressed: () {},
          icon: Text("1")),
      IconButton.filled(
          iconSize: 20.dm,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen)),
          onPressed: () {},
          icon: Text("...")),
      IconButton.filled(
          iconSize: 20.dm,
          color: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen)),
          onPressed: () {},
          icon: Text("5")),
      IconButton.filled(
          iconSize: 20.dm,
          color: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen)),
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          )),
    ],
  );
}
