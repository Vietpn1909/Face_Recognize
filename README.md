# Face Recognition System 🎯

Ứng dụng nhận diện khuôn mặt thời gian thực sử dụng thư viện `face_recognition`, `OpenCV` và Python. Hỗ trợ nhận diện từ webcam, quản lý người dùng, điểm danh và xuất báo cáo.

## 🧠 Công nghệ sử dụng

- Python 3.10
- face_recognition
- dlib
- OpenCV
- NumPy
- Tkinter (GUI)
- Pandas (Báo cáo Excel)

## 📁 Cấu trúc dự án

```
Face_Recognize/
├── main.py                  # Chạy ứng dụng dòng lệnh (CLI)
├── gui_app.py               # Chạy ứng dụng giao diện (GUI)
├── requirements.txt         # Danh sách thư viện cần cài
├── FaceRecognition_Installer.bat  # File cài đặt tự động
├── modules/                 # Các module xử lý
│   ├── face_loader.py       # Tải và mã hóa khuôn mặt
│   ├── webcam.py            # Nhận diện qua webcam
│   ├── image_processor.py   # Nhận diện từ ảnh
│   ├── attendance.py        # Hệ thống điểm danh
│   ├── user_management.py   # Quản lý người dùng
│   ├── camera_utils.py      # Tiện ích camera
│   ├── menu_management.py   # Quản lý menu CLI
│   └── attendance_management.py
├── photo/                   # Thư mục chứa ảnh khuôn mặt (tự tạo khi chạy)
├── data/                    # Dữ liệu hệ thống (tự tạo khi chạy)
└── reports/                 # Báo cáo điểm danh (tự tạo khi chạy)
```

## 🚀 Cài đặt nhanh (Tự động)

Chạy file `FaceRecognition_Installer.bat` - installer sẽ tự động:
1. Kiểm tra Git và Python 3.10
2. Clone source code từ GitHub
3. Tạo môi trường ảo
4. Tải và cài đặt dlib + các thư viện cần thiết
5. Tạo shortcut trên Desktop

> **Yêu cầu**: [Git](https://git-scm.com/) và [Python 3.10](https://www.python.org/downloads/release/python-3100/) đã được cài đặt.

## 🔧 Cài đặt thủ công

### 1. Clone repository

```bash
git clone https://github.com/Vietpn1909/Face_Recognize.git
cd Face_Recognize
```

### 2. Tạo môi trường ảo

```bash
py -3.10 -m venv venv
venv\Scripts\activate
```

### 3. Cài đặt dlib

Tải file wheel phù hợp với Python 3.10:
- [dlib-19.22.99-cp310-cp310-win_amd64.whl](https://github.com/z-mahmud22/Dlib_Windows_Python3.x/raw/main/dlib-19.22.99-cp310-cp310-win_amd64.whl)

```bash
pip install dlib-19.22.99-cp310-cp310-win_amd64.whl
```

### 4. Cài đặt các thư viện còn lại

```bash
pip install -r requirements.txt
```

### 5. Chạy ứng dụng

```bash
# Chạy giao diện GUI
python gui_app.py

# Hoặc chạy dòng lệnh CLI
python main.py
```

## 📸 Hướng dẫn sử dụng

### Thêm người dùng mới
1. Mở ứng dụng GUI → Tab **Quản Lý Người Dùng**
2. Nhấn **Thêm Người Dùng** → Nhập tên, tuổi, địa chỉ
3. Chọn **Webcam** để chụp ảnh hoặc **File ảnh** để tải ảnh có sẵn
4. Hệ thống sẽ tự động mã hóa khuôn mặt và lưu vào cơ sở dữ liệu

### Nhận diện khuôn mặt
- **Qua Webcam**: Nhấn "Nhận Diện Qua Webcam" → Nhấn `q` để thoát
- **Từ Ảnh**: Nhấn "Nhận Diện Từ Ảnh" → Chọn file ảnh

### Điểm danh
- **Check-in**: Tab Điểm Danh → Nhấn "Check-in"
- **Check-out**: Tab Điểm Danh → Nhấn "Check-out"
- **Xuất báo cáo**: Tab Báo Cáo → Chọn ngày → Nhấn "Xuất Excel"

## ⚠️ Lưu ý

- Ứng dụng tự động tạo các thư mục `photo/`, `data/`, `reports/` khi chạy lần đầu
- Mỗi người dùng cần ít nhất **1 ảnh** chứa khuôn mặt rõ ràng (khuyến nghị 3-5 ảnh)
- Hỗ trợ định dạng ảnh: `.jpg`, `.jpeg`, `.png`
- Yêu cầu camera/webcam để sử dụng chức năng nhận diện trực tiếp
