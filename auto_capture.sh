#!/bin/bash

# -------------------------------
# 설정
# -------------------------------
SAVE_DIR="$HOME/ebook_screenshots"
mkdir -p "$SAVE_DIR"
JPG_DIR="$SAVE_DIR/jpg_tmp"
mkdir -p "$JPG_DIR"

INTERVAL=0.8               # 캡처 간격 (초)
REGION="000,70,950,1200"  # 캡처 영역
TOTAL_PAGES=558           # 총 페이지 수

# JPG 품질 (1~100, 화면용은 80 정도 추천)
JPG_QUALITY=50

# PDF 최종 이름
PDF_FILE="$SAVE_DIR/ebook_compressed.pdf"

# -------------------------------
# 1. 화면 캡처
# -------------------------------
echo "📸 캡처 시작..."
for ((i=1; i<=TOTAL_PAGES; i++))
do
    FILENAME="$SAVE_DIR/snap_$(printf "%04d" $i).png"
    screencapture -x -R $REGION "$FILENAME"
    echo "Captured $FILENAME"

    # 페이지 넘김 (오른쪽 화살표)
    osascript -e 'tell application "System Events" to key code 124'

    sleep $INTERVAL
done

# -------------------------------
# 2. PNG → JPG 변환
# -------------------------------
echo "🖼 PNG → JPG 변환..."
for f in "$SAVE_DIR"/*.png; do
    BASENAME=$(basename "$f" .png)
    magick "$f" -quality $JPG_QUALITY "$JPG_DIR/$BASENAME.jpg"
done

# -------------------------------
# 3. PDF 생성
# -------------------------------
echo "📄 JPG → PDF 생성..."
cd "$JPG_DIR"
magick *.jpg "$SAVE_DIR/ebook_raw.pdf"

# -------------------------------
# 4. PDF 압축 (GhostScript)
# -------------------------------
echo "🔧 PDF 압축 중..."
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
   -dNOPAUSE -dBATCH -sOutputFile="$PDF_FILE" "$SAVE_DIR/ebook_raw.pdf"

echo "✅ 완료! 최종 PDF: $PDF_FILE"
