class Config:
    SQLALCHEMY_DATABASE_URI = 'postgresql://rifapost:123456@localhost:5432/db_heartguard'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    JWT_SECRET_KEY = 'your_secret_key'  # Ganti dengan secret key yang aman
