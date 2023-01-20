import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  parsethetext() async {
    final imagefile = await ImagePicker().getImage(source:ImageSource.gallery, maxWidth: 670,   maxHeight: 970);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            alignment: Alignment.center,
            child: Text(
              "OCR APP",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                  onPressed: () => parsethetext(),
                  child: Text('Upload a image',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.w700))))
        ],
      ),
    );
  }
}