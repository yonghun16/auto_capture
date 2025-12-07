# auto_capture

- 전자책을 캡쳐하여 ebook으로 만듬.
- 이 스크립트는 맥(Mac) 환경에서 실행되어, 전자책 화면을 자동으로 캡처 → JPG 변환 → PDF 병합 → 압축까지 해주는 자동화 쉘 스크립트


## 📌 사용 전 준비

### 1️⃣ 필요한 프로그램 설치

✔ 이미지 변환도구 — ImageMagick
```bash
brew install imagemagick
```

✔ PDF 압축도구 — Ghostscript
```bash
brew install ghostscript
```


### 2️⃣ macOS 접근 권한 설정
1. 자동 캡처, 자동 입력을 위해 다음 앱에 권한필요:
`시스템 설정 → 개인정보 보호 및 보안 → 접근성`
2. Terminal 또는 iTerm2 추가
3. magick 필요하면 추가
`시스템 설정 → 개인정보 보호 및 보안 → 화면 기록`
4. 터미널 추가
`시스템 설정 → 자동화`
`Terminal → System Events 허용`



## 📌 스크립트 사용법
### 1️⃣ 파일로 저장

예: Desktop 에 저장
```bash
vi ~/Desktop/ebook_capture.sh
```
스크립트 내용 그대로 붙여넣고 저장.
```bash
chmod +x ~/Desktop/ebook_capture.sh
```


### 2️⃣ ebook 화면 띄우기
- 페이지가 1페이지에서 시작해야 함.
- 스크립트에서 정한 REGION="000,70,950,1200" 값이 화면 캡처 영역인데, 필요하면 조정.

### 3️⃣ 실행
```bash
./auto_capture.sh
```


##  ⚠️ 실행 중 주의사항
- 스크립트가 마우스 클릭 X, 대신 오른쪽 화살표 자동 입력으로 페이지 넘김.
- 실행 중엔 마우스를 움직이거나 다른 프로그램 커서로 전환하면 깨질 수 있음.


### 📁 결과물
- snap_0001.png …	원본 캡처 이미지들
- jpg_tmp/*.jpg	변환된 JPG 이미지
- ebook_raw.pdf	변환만 된 PDF
- ebook_compressed.pdf	최종 압축된 PDF


### 🎚️ 옵션 변경 방법
- REGION="000,70,950,1200"	상단 부분	캡처 영역 좌표 (x,y,width,height)
- TOTAL_PAGES=558	스크립트 상단	캡처할 페이지 수
- I-NTERVAL=0.8	스크립트 상단	페이지 넘기기 속도 (기기가 느리면 1.2로 증가)
- JPG_QUALITY=50	PNG→JPG 변환단계	숫자 낮을수록 용량↓ 화질↓

### ⭐️ 추천 값
- INTERVAL=1.0
- JPG_QUALITY=60
- TOTAL_PAGES 정확히 입력
