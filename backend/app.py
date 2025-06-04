from flask import Flask
from flask_migrate import Migrate
from flask_cors import CORS
from config import Config
from extensions import db, jwt  # jwt hanya kalau digunakan

migrate = Migrate()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Inisialisasi ekstensi
    CORS(app)
    db.init_app(app)
    jwt.init_app(app)
    migrate.init_app(app, db)

    # Import semua model agar dikenali oleh Flask-Migrate
    from models import user
    from models import deteksi  # pastikan ini ada

    # Import blueprint
    from auth.routes import auth_bp
    from konsultasi.routes import konsultasi_bp
    from pendeteksi.routes import pendeteksi_bp

    # Register blueprint
    app.register_blueprint(auth_bp)
    app.register_blueprint(konsultasi_bp)
    app.register_blueprint(pendeteksi_bp)

    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0', port=5000)
