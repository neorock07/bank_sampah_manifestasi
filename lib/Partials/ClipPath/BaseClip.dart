import 'package:flutter/material.dart';

class BaseClip extends CustomClipper<Path> { 
@override 
Path getClip(Size size) { 
	var path = Path(); 
	// path.moveTo(0, size.height * 0.5); 
	path.lineTo(0, 0); 
	path.lineTo(size.width, 0); 
	path.lineTo(size.width, size.height * 0.4);
	path.lineTo(size.width * 0.5, size.height * 0.3);
	path.lineTo(0, size.height * 0.4);

	path.close(); 
	return path; 
} 

@override 
bool shouldReclip(CustomClipper<Path> oldClipper) { 
	return false; 
} 
}
