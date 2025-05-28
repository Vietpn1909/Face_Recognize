import os
import face_recognition
import pickle

known_face_names = []
known_face_encodings = []
DIR = 'photo'

for person_name in os.listdir(DIR):
    person_folder = os.path.join(DIR, person_name)
    for image in os.listdir(person_folder):
        image_path = os.path.join(person_folder, image)
        
        image = face_recognition.load_image_file(image_path)
        encodings = face_recognition.face_encodings(image)
        known_face_encodings.append(encodings[0])
        known_face_names.append(person_name)
        
with open("encoding.pkl", "wb") as f:
    pickle.dump({"encodings": known_face_encodings, "names": known_face_names}, f)
        