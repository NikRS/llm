from transformers import XLMRobertaTokenizer, XLMRobertaForSequenceClassification

# Загрузка модели и токенизатора
tokenizer = XLMRobertaTokenizer.from_pretrained("xlm-roberta-large")
model = XLMRobertaForSequenceClassification.from_pretrained("xlm-roberta-large")

# Пример текста для анализа
text = "Пример текста на любом языке"

# Токенизация
inputs = tokenizer(text, return_tensors="pt")

# Прогноз
outputs = model(**inputs)
logits = outputs.logits

print(logits)
