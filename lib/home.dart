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
  String filepath = '';

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
      filepath =pickedFile!.path;
    });
  }
  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width/4;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: _imageSize,
                minWidth: _imageSize,
              ),
            ),
              Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.primary),
                  image: DecorationImage(
                      image: FileImage(File(filepath)),
                      fit: BoxFit.contain),
                ),
              ),
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
                width: MediaQuery.of(context).size.width / 1,
                height:MediaQuery.of(context).size.height /15,
                child: ElevatedButton(
                    onPressed: () => parsethetext(),
                    child: Text('사진을 선택해주세요',
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w700)))),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text("추출된 텍스트는",style: GoogleFonts.montserrat(
                      fontSize:20,
                      fontWeight:FontWeight.bold
                  ),),
                  SizedBox(height:10.0),
                  Text(parsedtext,style: GoogleFonts.montserrat(
                      fontSize:25,
                      fontWeight:FontWeight.bold
                  ),)
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}