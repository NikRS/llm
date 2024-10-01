# Используем базовый образ с Python
FROM python:3.9-slim

# Установим необходимые системные зависимости
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем библиотеки
RUN pip install --no-cache-dir transformers torch

# Скачиваем модель заранее, чтобы избежать скачивания при каждом запуске контейнера
RUN python -c "from transformers import XLMRobertaModel; XLMRobertaModel.from_pretrained('xlm-roberta-large')"

# Определим рабочую директорию
WORKDIR /app

# Копируем ваш код в контейнер
COPY . /app

# Определим команду запуска (например, скрипт main.py)
CMD ["python", "main.py"]
