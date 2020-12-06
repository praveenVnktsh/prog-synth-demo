import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsiveLayout.dart';

class NavBar extends StatelessWidget {
  final navLinks = [""];

  List<Widget> navItem() {
    return navLinks.map((text) {
      return Padding(
        padding: EdgeInsets.only(left: 18),
        child: Text(text, style: TextStyle(fontFamily: "Montserrat-Bold")),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(colors: [
                      Color(0xFF93c845),
                      Color(0xFF66aae3),
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network("assets/symbol.png", scale: .1),
                )),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "CS613 | NLP",
                style: GoogleFonts.comfortaa(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              )
            ],
          ),
          Text(
            "IIT Gandhinagar",
            style: GoogleFonts.comfortaa(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          )
          // if (!ResponsiveLayout.isSmallScreen(context))
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: <Widget>[...navItem()]..add(InkWell(
          //           child: Container(
          //         margin: EdgeInsets.only(left: 20),
          //         width: 120,
          //         height: 40,
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [
          //               Color(0xFF93c845),
          //               Color(0xFF66aae3),
          //             ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          //             borderRadius: BorderRadius.circular(20),
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Color(0xFF6078ea).withOpacity(.3),
          //                   offset: Offset(0, 8),
          //                   blurRadius: 8)
          //             ]),
          //         child: Material(
          //           color: Colors.transparent,
          //           child: Center(
          //             child: Text("IITGN",
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 18,
          //                     letterSpacing: 1,
          //                     fontFamily: "Montserrat-Bold")),
          //           ),
          //         ),
          //       ))),
          //   )
          // else
          //   Image.network("assets/menu.png", width: 26, height: 26)
        ],
      ),
    );
  }
}
