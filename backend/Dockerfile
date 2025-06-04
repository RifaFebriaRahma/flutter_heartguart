# Menggunakan image Python 3.9
FROM python:3.9-slim

# Set direktori kerja
WORKDIR /app

# Salin file aplikasi dan requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .

# Menjalankan aplikasi menggunakan Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]