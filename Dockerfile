# Базовый образ Python
FROM python:3.9-slim

# Обновление пакетов и установка системных зависимостей
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка pip-зависимостей
RUN pip install --upgrade pip

# Установка нужных библиотек
RUN pip install --no-cache-dir transformers torch

# Предварительная загрузка модели
RUN python -c "from transformers import XLMRobertaTokenizer, XLMRobertaModel; XLMRobertaModel.from_pretrained('xlm-roberta-large'); XLMRobertaTokenizer.from_pretrained('xlm-roberta-large')"

# Рабочая директория
WORKDIR /app

# Копирование вашего кода в контейнер
COPY . /app

# Команда по умолчанию для запуска
CMD ["python", "main.py"]
