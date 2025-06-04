from extensions import db

class Deteksi(db.Model):
    __tablename__ = 'deteksi'  # ini penting, sesuai dengan yang error
    id = db.Column(db.Integer, primary_key=True)
    tekanan_darah = db.Column(db.Float, nullable=False)
    kolesterol = db.Column(db.Float, nullable=False)
    gula_darah = db.Column(db.Float, nullable=False)
    risiko = db.Column(db.String(50), nullable=False)
