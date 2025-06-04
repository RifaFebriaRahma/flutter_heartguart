import re
from flask import Blueprint, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from models.user import User
from app import db

auth_bp = Blueprint('auth', __name__, url_prefix='/auth')

# Regex validasi email
EMAIL_REGEX = re.compile(r"[^@]+@[^@]+\.[^@]+")

@auth_bp.route('/register', methods=['POST'])
def register():
    try:
        data = request.get_json()
        if not data:
            return jsonify({'success': False, 'message': 'Request JSON tidak ditemukan'}), 400

        name = data.get('name', '').strip()
        usia = data.get('usia')
        gender = data.get('gender', '').strip()
        email = data.get('email', '').strip()
        password = data.get('password', '').strip()

        # Validasi input
        if not all([name, usia, gender, email, password]):
            return jsonify({'success': False, 'message': 'Semua field wajib diisi'}), 400

        if not EMAIL_REGEX.match(email):
            return jsonify({'success': False, 'message': 'Format email tidak valid'}), 400

        if len(password) < 6:
            return jsonify({'success': False, 'message': 'Password minimal 6 karakter'}), 400

        if User.query.filter_by(email=email).first():
            return jsonify({'success': False, 'message': 'Email sudah terdaftar'}), 409

        hashed_password = generate_password_hash(password)

        new_user = User(
            name=name,
            usia=int(usia),
            gender=gender,
            email=email,
            password=hashed_password
        )

        db.session.add(new_user)
        db.session.commit()

        return jsonify({'success': True, 'message': 'Registrasi berhasil'}), 201

    except Exception as e:
        db.session.rollback()
        print(f"Error saat register: {e}")
        return jsonify({'success': False, 'message': f'Terjadi kesalahan pada server: {str(e)}'}), 500


@auth_bp.route('/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        if not data:
            return jsonify({'success': False, 'message': 'Request JSON tidak ditemukan'}), 400

        email = data.get('email', '').strip()
        password = data.get('password', '').strip()

        if not email or not password:
            return jsonify({'success': False, 'message': 'Email dan password wajib diisi'}), 400

        user = User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password, password):
            access_token = create_access_token(identity=str(user.id))
            return jsonify({
                'success': True,
                'message': 'Login berhasil',
                'access_token': access_token,
                'user': {
                    'id': user.id,
                    'name': user.name,
                    'usia': user.usia,
                    'gender': user.gender,
                    'email': user.email
                }
            }), 200
        else:
            return jsonify({'success': False, 'message': 'Email atau password salah'}), 401

    except Exception as e:
        print(f"Error saat login: {e}")
        return jsonify({'success': False, 'message': f'Terjadi kesalahan pada server: {str(e)}'}), 500


@auth_bp.route('/profile', methods=['GET'])
@jwt_required()
def profile():
    try:
        user_id_str = get_jwt_identity()
        if not user_id_str:
            return jsonify({'success': False, 'message': 'Token tidak valid atau kedaluwarsa'}), 401

        user = User.query.get(int(user_id_str))
        if not user:
            return jsonify({'success': False, 'message': 'Pengguna tidak ditemukan'}), 404

        return jsonify({
            'success': True,
            'message': 'Data profil berhasil diambil',
            'data': {
                'id': user.id,
                'name': user.name,
                'usia': user.usia,
                'gender': user.gender,
                'email': user.email
            }
        }), 200

    except Exception as e:
        print(f"Error saat mengambil profil: {e}")
        return jsonify({'success': False, 'message': f'Terjadi kesalahan pada server: {str(e)}'}), 500

@auth_bp.route('/check-email', methods=['POST'])
def check_email():
    data = request.get_json()
    email = data.get('email', '').strip()
    if not email:
        return jsonify({'exists': False, 'message': 'Email diperlukan'}), 400

    exists = User.query.filter_by(email=email).first() is not None
    return jsonify({'exists': exists}), 200

@auth_bp.route("/user/<int:user_id>", methods=["GET"])
def get_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user:
        return jsonify({
            "name": user.name,
            "email": user.email,
            "age": user.age,
            "gender": user.gender
        }), 200
    return jsonify({"message": "User not found"}), 404

@auth_bp.route('/logout', methods=['POST'])
def logout():
    # Jika menggunakan token/cookies, tambahkan logika revoke/blacklist di sini
    response = jsonify({'message': 'Logout berhasil'})
    response.status_code = 200
    return response
