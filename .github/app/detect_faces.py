import cv2
import sys

def detect_faces(image_path):
    # Загружаем классификатор для распознавания лиц
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")
    
    # Загружаем изображение
    image = cv2.imread(image_path)
    if image is None:
        print("Error: Image not found or unable to read.")
        sys.exit(1)
    
    # Преобразуем изображение в оттенки серого
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # Находим лица
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
    
    # Выводим результат
    print(f"Found {len(faces)} face(s) in the image.")
    for i, (x, y, w, h) in enumerate(faces):
        print(f"Face {i + 1}: Position ({x}, {y}), Size ({w}x{h})")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python detect_faces.py <image_path>")
        sys.exit(1)
    detect_faces(sys.argv[1])
