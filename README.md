# OCR-Api
```
OCR Api를 사용하여 사진에서 문자를 추출하는 기능을 제공하는 앱을 제작해보겠습니다.
```
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
