#базовый образ
FROM python:3.9-slim

#устанавливаем зависимости для сборки OpenCV из исходников
RUN apt-get update && apt-get install -y \
    cmake \
    libgtk2.0-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libatlas-base-dev \
    gfortran \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libqtgui4 \
    libqt4-test

#скачиваем и собираем OpenCV
RUN mkdir /opencv && cd /opencv && \
    git clone https://github.com/opencv/opencv.git && \
    cd opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

#устанавливаем Python-библиотеки
COPY requirements.txt .
RUN pip install -r requirements.txt

#копируем приложение
WORKDIR /app
COPY face_detection.py .
COPY default_image.jpg .

#запуск по умолчанию
ENTRYPOINT ["python", "face_detection.py"]
