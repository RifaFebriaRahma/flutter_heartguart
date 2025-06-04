from flask import Blueprint, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError
from backend.models.user import User  # pastikan models.py ada dan User model sudah benar

profile_bp = Blueprint('profile', __name__)

@profile_bp.route('/api/user/profile', methods=['GET'])
@jwt_required()
def get_user_profile():
    try:
        user_id = get_jwt_identity()
        user = User.query.get_or_404(user_id, description='Pengguna tidak ditemukan')

        avatar_url = f"https://api.dicebear.com/6.x/initials/svg?seed={user.name}" if user.name else None

        return jsonify({
            'success': True,
            'message': 'Data profil berhasil diambil',
            'data': {
                'id': user.id,
                'name': user.name,
                'email': user.email,
                'gender': user.gender,
                'age': user.usia,  # perbaikan dari user.usia ke user.age
                'avatarUrl': avatar_url
            }
        }), 200

    except SQLAlchemyError as e:
        return jsonify({'success': False, 'message': f'Kesalahan database: {str(e)}'}), 500
    except Exception as e:
        return jsonify({'success': False, 'message': f'Terjadi kesalahan server: {str(e)}'}), 500
