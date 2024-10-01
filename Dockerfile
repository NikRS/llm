# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
RUN mkdir /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any necessary packages, including transformers
RUN pip install --upgrade pip \
    && pip install transformers \
    && pip install torch \
    && pip install flask

# Открываем порт для Flask-сервера
EXPOSE 5000

# Запуск Flask API
CMD ["python", "app.py"]
