from flask import Flask, request, jsonify
from transformers import AutoModelForSequenceClassification, AutoTokenizer
import torch

app = Flask(__name__)

# Загрузка модели и токенизатора
model_name = "MoritzLaurer/mDeBERTa-v3-base-xnli-multilingual-nli-2mil7"
model = AutoModelForSequenceClassification.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

@app.route("/predict", methods=["POST"])
def predict():
    data = request.json
    text = data["text"]

    # Токенизация входного текста
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)
    
    # Прогнозирование
    with torch.no_grad():
        outputs = model(**inputs)
        probs = torch.softmax(outputs.logits, dim=-1).tolist()[0]

    # Форматируем ответ
    labels = ["entailment", "neutral", "contradiction"]
    result = {label: prob for label, prob in zip(labels, probs)}
    return jsonify(result)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
