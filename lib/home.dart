import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String parsedtext = ''; // 추출된 텍스트를 저장할 String 변수
  parsethetext() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}","language" :"kor"};
    var header = {"apikey" :"K86070579388957"};

    var post = await http.post(Uri.parse(url),body: payload,headers: header);
    var result = jsonDecode(post.body); // 추출 결과를 받아서 result에 저장
    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText']; // 추출결과를 다시 parsedtext로 저장
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
      )
    );
  }
}