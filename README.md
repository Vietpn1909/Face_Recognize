# Face Recognition System 🎯

Ứng dụng nhận diện khuôn mặt thời gian thực sử dụng thư viện `face_recognition`, `OpenCV` và Python. Dự án cho phép nhận diện khuôn mặt từ webcam dựa trên dữ liệu ảnh đã lưu.

## 🧠 Công nghệ sử dụng
- Python 3.10
- face_recognition
- dlib
- OpenCV
- NumPy

## 📁 Cấu trúc thư mục
project/
├── photo/ # Thư mục chứa các thư mục con theo tên người, mỗi thư mục chứa ảnh khuôn mặt
│ ├── Ronaldo/
│ │ └── ronaldo.jpg
│ └── Messi/
│ └── messi.png
├── main.py # File chính chạy chương trình
├── requirements.txt # Danh sách thư viện cần thiết
└── .gitignore # Loại trừ venv và các file không cần thiết


## 🚀 Hướng dẫn sử dụng cài môi trường ảo

python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python main.py



