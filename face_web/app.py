from flask import Flask, render_template, request
from face_recognition_module import Load_Photo, Image, Web_cam
import os
import cv2

app = Flask(__name__)
Load_Photo()  # Load dữ liệu khuôn mặt một lần khi server khởi động

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['image']
    filepath = os.path.join('static', 'uploaded.jpg')
    file.save(filepath)

    result = Image(filepath)
    return render_template('index.html', result=result)


@app.route('/upload_webcam', methods=['POST'])
def upload_webcam():
    file = request.files['webcam_image']
    filepath = os.path.join('static', 'webcam.jpg')
    file.save(filepath)

    result = Image(filepath)
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
