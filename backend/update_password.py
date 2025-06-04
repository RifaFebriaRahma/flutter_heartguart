from app import app, db, User  # import app juga
from werkzeug.security import generate_password_hash

def update_password(email, new_password):
    with app.app_context():  # pakai context aplikasi
        user = User.query.filter_by(email=email).first()
        if user:
            user.password = generate_password_hash(new_password)
            db.session.commit()
            print(f"Password untuk {email} sudah dihash dan disimpan.")
        else:
            print("User tidak ditemukan.")

if __name__ == "__main__":
    update_password('rifa@example.com', '123456')
