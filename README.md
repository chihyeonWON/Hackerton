# OCR-Api
```
OCR Api를 사용하여 사진에서 문자를 추출하는 기능을 제공하는 앱을 제작해보겠습니다.
```

## 첫 화면
```
화면의 UI 구성은 사진이 들어갈 Box와 사진을 휴대폰 갤러리에서 선택하는 버튼, 
추출한 텍스트를 보여주는 공간으로 크게 스크롤이 가능하도록 구현하였습니다.
사용자의 휴대폰에서 갤러리를 가져오는 과정은 크게 개인정보 권한을 얻지 않아도 되도록 
정책 상 변경되었기 때문에 특별한 권한은 주지 않았습니다.
```
![image](https://user-images.githubusercontent.com/58906858/213846450-21b10476-6adb-4fc4-a1db-8621c8a7a6fa.png)

## 화면을 선택한 후
```
선택한 이미지가 박스 안으로 들어갑니다. Box.contain 속성을 주어 선택한 이미지가 화면에 
짤리지않고 다 나올 수 있또록 설계하였습니다.
선택한 이미지의 글자를 모두 잘 추출해 내어 화면에 뿌려줍니다.
하지만 그렇게 인식률이 좋은 것 같진 않습니다.
이 프로젝트의 라이브러리를 사용해서 추후에 더 활용도 있는 프로젝트를 진행하기로 하였습니다.
```
![image](https://user-images.githubusercontent.com/58906858/213846451-ed828786-6fdd-422f-ba9f-5c789844f89f.png)


[참고한 사이트](https://medium.com/@nsivaramdav/create-a-image-to-text-recognition-app-with-flutter-d135b682ba4d/)<<- 사이트를 참조하였습니다.
## 의존성 추가
```
커스텀 폰트를 위한 google_fonts,
데이터를 불러오기 위한 http,
이미지를 압축시키기 위한 path_provider,
base64로 인코딩하기 위한 image,
이미지를 찍거나 선택하기 위한 image_picker,

5개의 라이브러리를 설치합니다.
```
![image](https://user-images.githubusercontent.com/58906858/213621288-64bc8034-0cf4-4880-a349-697feedfd25d.png)

## 갤러리에서 이미지 가져오기

```
main.dart에서 stateful 클래스의 HomePage를 생성하고 homepage.dart 파일에 HomePage클래스를 생성합니다.
HomePage의 ElevatedButton에서 이미지 선택 버튼을 눌렀을 때 작동하는 parsethetext() 메서드를 생성합니다.
이미지를 갤러리에서 가져오는 기능을 추가합니다.

parsethetext() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
```

## 이미지를 base64로 변환하기
```
parsethetext()에 이미지를 갤러리에서 선택한 후에 선택한 이미지를 base64로 인코딩해야 합니다.
왜냐하면 사용하고자 하는 OCR Api가 base64 형식의 이미지만을 취급하기 때문입니다.
이미지를 선택하자마자 텍스트 인식까지 하는 코드를 구현하였습니다.

var bytes = File(pickedFile.path.toString()).readAsBytesSync(); // 선택한 이미지 텍스트 인식
    String img64 = base64Encode(bytes); // base64로 인코딩(변환)
```

## OCR Api Key 발급

[OCR API 홈페이지](https://ocr.space/OCRAPI) 이 홈페이지에서 OCR API Key를 발급받아야 합니다.
```
free api를 선택하고 발급을 요청하면 입력한 이메일로 Api key가 발급됩니다.
```
![image](https://user-images.githubusercontent.com/58906858/213626975-fd9fb331-2c80-49ab-9801-6a2435a8e0d0.png)

## 발급받은 Api키를 가지고 특정 url로 이미지 전송하기
[이미지 전송해야할 사이트](https://api.ocr.space/parse/image)로 이미지를 전송해야 합니다.
```
바디(body) 전송할 데이터(payload)와 헤더(header Api정보), url (데이터를 전송할 경로) 세 가지를 http의 post 방식으로
전달합니다.

    var url = 'https://api.ocr.space/parse/image';
    var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}","language" :"kor"};
    var header = {"apikey" :"발급받은 키 번호"};
    
    var post = await http.post(Uri.parse(url), body: payload, headers: header);
    var result = jsonDecode(post.body);
```

## 사이트에서 결과 값 받아오기
```
이미지에서 추출한 텍스트 결과 값을 저장할 함수 밖 전역변수 parsedtext를 정의하고
post.body에 있는 결과 값을 result 에 저장한 후 다시 result의 추출된 결과와 텍스트를 parsedtext에 저장합니다.

var result = jsonDecode(post.body); // 추출 결과를 받아서 result에 저장
    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText']; // 추출결과를 다시 parsedtext로 저장
    });
```

## 가져온 텍스트를 화면에 뿌리기
```
Column의 맨 뒷부분에 Container위젯을 넣어줍니다.
parsedtext값을 Text 위젯을 사용하여 화면에 뿌려줍니다.
```
![image](https://user-images.githubusercontent.com/58906858/213846328-0d0747d2-163c-4a37-9a8a-6d603c11debf.png)

