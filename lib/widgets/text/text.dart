import 'package:citav2/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Widget material({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 16, color: state.materialColor),
        fontSize: 16,
      ),
    ),
  );
}

Widget text({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 16, color: state.textColor),
        fontSize: 16,
      ),
    ),
  );
}

Widget text10({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 12, color: Colors.black),
        fontSize: 16,
      ),
    ),
  );
}

Widget text14({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 14, color: Colors.black),
        fontSize: 16,
      ),
    ),
  );
}

Widget text10Overflow({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 12, color: Colors.black),
        fontSize: 16,
      ),
    ),
  );
}

Widget text16Bold({@required String title, bool center = false}) {
  return Text(
    title,
    textAlign: center ? TextAlign.center : TextAlign.start,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      fontSize: 16,
    ),
  );
}

Widget text16WBold({@required String title}) {
  return Text(
    title,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      fontSize: 16,
    ),
  );
}

Widget chooserText({@required String title, Color color}) {
  return Text(title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 16, color: color),
      ));
}
