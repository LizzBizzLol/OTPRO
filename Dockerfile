# Базовый образ
FROM python:3.8

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk2.0-dev \
    libatlas-base-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Сборка и установка OpenCV
RUN pip install opencv-python-headless

# Копирование приложения
COPY . /app
WORKDIR /app

# Запуск приложения
CMD ["python", "face_detection.py"]
