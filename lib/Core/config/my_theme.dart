import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  final appTheme = ThemeData(
    primaryColor: const Color(0XFF004182),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   type: BottomNavigationBarType.fixed,
    //   backgroundColor:  Color(0XFF004182),
    //
    //   showSelectedLabels: false,
    //   showUnselectedLabels: false,
    //   selectedIconTheme: IconThemeData(color: Colors.grey, size: 23,),
    //   unselectedIconTheme: IconThemeData(color: Colors.white, size: 23),
    //   selectedItemColor: Colors.white,
    // ),
    textTheme:  TextTheme(
      displaySmall: GoogleFonts.poppins(
        color:  const Color(0XFF004182),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(
          color:  const Color(0XFF004182),
          fontSize: 16,
          fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.poppins(
        color:  const Color(0XFF004182),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.poppins(
          color:Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.poppins(
        color:const Color(0XFF004182),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    )
  );
