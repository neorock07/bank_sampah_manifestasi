import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconMaker extends StatelessWidget {
IconMaker({ super.key, this.link});
  
  String? link;  
  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 66.dm,
      width: 66.dm,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(link!)
            )
        ),
      )
    );
  }
}