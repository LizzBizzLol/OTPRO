import cv2
import sys

#путь к изображению (первый аргумент командной строки или файл по умолчанию)
image_path = sys.argv[1] if len(sys.argv) > 1 else "default_image.jpg"

#загрузка изображения
image = cv2.imread(image_path)
if image is None:
    print("Ошибка: изображение не загружено.")
    sys.exit(1)

#инициализация детектора лиц
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

#поиск
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.1, 4)

#рамки вокруг лиц
for (x, y, w, h) in faces:
    cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)

#сохраняем обработанное изображение
result_image_path = "result_image.jpg"
cv2.imwrite(result_image_path, image)
print(f"Лица обнаружены. Сохранено в '{result_image_path}'.")

#если Docker позволяет использовать X-сервер хост-машины, отображаем изображение
cv2.imshow("Detected Faces", image)
cv2.waitKey(0)
cv2.destroyAllWindows()