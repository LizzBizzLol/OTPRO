# Используем базовый образ Python
FROM python:3.9-slim

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev && \
    pip install opencv-python-headless

# Копируем файлы проекта
WORKDIR /app
COPY app/ app/
COPY image.jpg image.jpg

# Указываем команду запуска
CMD ["python", "app/detect_faces.py", "image.jpg"]
