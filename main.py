import face_recognition
import cv2
import numpy as np
import os
import pickle

# Thư mục gốc chứa các thư mục tên người
# DIR = 'photo'
with open("encoding.pkl", "rb") as f:
    data = pickle.load(f)

known_face_encodings = data["encodings"]
known_face_names = data["names"]

# def Load_Photo():
#     # Duyệt từng thư mục con trong photo
#     for person_name in os.listdir(DIR):
#         person_folder = os.path.join(DIR, person_name)

#         # Duyệt từng ảnh trong thư mục con
#         for filename in os.listdir(person_folder):
#             if filename.endswith(('.jpg', '.jpeg', '.png')):
#                 image_path = os.path.join(person_folder, filename)
#                 image = face_recognition.load_image_file(image_path)
                    
#                 encodings = face_recognition.face_encodings(image)

#                 known_face_encodings.append(encodings[0])
#                 known_face_names.append(person_name)
                
def Web_cam():
    # Mở webcam
    video_capture = cv2.VideoCapture(0)

    process = True

    while True:
        ret, frame = video_capture.read()

        if not ret:
            break

        if process:
            small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)  #Giảm size đi 1/4
            rgb_small_frame = small_frame[:, :, ::-1]  #giữ width và height nhưng đảo màu BGR -> RGB dùng cho face_recognition

            face_locations = face_recognition.face_locations(rgb_small_frame) #tìm mặt
            face_encodings = face_recognition.face_encodings(rgb_small_frame, face_locations)

            face_names = []
            for face_encoding in face_encodings:
                matches = face_recognition.compare_faces(known_face_encodings, face_encoding)
                name = "Unknown"

                face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
                best_match_index = np.argmin(face_distances)
                if matches[best_match_index]:
                    name = known_face_names[best_match_index]

                face_names.append(name)

        process = not process

        for (top, right, bottom, left), name in zip(face_locations, face_names):
            top *= 4
            right *= 4
            bottom *= 4
            left *= 4

            if name == 'Unknown':
                cv2.rectangle(frame, (left, top), (right, bottom), (0, 0, 255), 2)
                cv2.putText(frame, name, (left, top-10), cv2.FONT_HERSHEY_DUPLEX, 1.0, (0, 0, 255), 2)
            else:
                cv2.rectangle(frame, (left, top), (right, bottom), (0, 255, 0), 2)
                cv2.putText(frame, name, (left, top-10), cv2.FONT_HERSHEY_DUPLEX, 1.0, (0, 255, 0), 2)
            
        cv2.imshow('Video', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    video_capture.release()
    cv2.destroyAllWindows()
    
def Image(path):
    img = face_recognition.load_image_file(path)
    face_locations = face_recognition.face_locations(img)
    face_encodings = face_recognition.face_encodings(img, face_locations)
    
    for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
        compare = face_recognition.compare_faces(known_face_encodings, face_encoding)
        name = 'Unknown'
        
        face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
        match_index = np.argmin(face_distances)
        if compare[match_index]:
            name = known_face_names[match_index]
        
        if name == 'Unknown':
            cv2.rectangle(img, (left, top), (right, bottom), (0, 0, 255), 2)
            cv2.putText(img, name, (left, top-10), cv2.FONT_HERSHEY_DUPLEX, 1.0, (0, 0, 255), 2)
        else:
            cv2.rectangle(img, (left, top), (right, bottom), (0, 255, 0), 2)
            cv2.putText(img, name, (left, top-10), cv2.FONT_HERSHEY_DUPLEX, 1.0, (0, 255, 0), 2)        
        image_bgr = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)
        cv2.imshow('Image', image_bgr)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
        
                
if __name__ == '__main__':
    # print(type(known_face_encodings[0]))
    # print(type(known_face_names[0]))
    x = input('Choose (1 = webcam, 2 = photo): ')
    if x == '1':
        Web_cam()
    elif x == '2':
        path = input('Nhap duong dan: ')
        Image(path)
    else:
        print('Error')