from flask import Blueprint, request, jsonify
from models.deteksi import Deteksi
from extensions import db

pendeteksi_bp = Blueprint('pendeteksi', __name__, url_prefix='/pendeteksi')

@pendeteksi_bp.route('/cek', methods=['GET'])
def cek_pendeteksi():
    return jsonify({'message': 'Endpoint pendeteksi aktif!'})

@pendeteksi_bp.route('/deteksi', methods=['POST'])
def deteksi_penyakit_jantung():
    data = request.get_json()

    try:
        tekanan_darah = float(data.get('tekanan_darah'))
        kolesterol = float(data.get('kolesterol'))
        gula_darah = float(data.get('gula_darah'))
    except (ValueError, TypeError):
        return jsonify({'error': 'Input harus berupa angka'}), 400

    # Aturan sederhana untuk diagnosis
    risiko = 'Rendah'
    if tekanan_darah > 140 or kolesterol > 240 or gula_darah > 200:
        risiko = 'Tinggi'
    elif tekanan_darah > 120 or kolesterol > 200 or gula_darah > 140:
        risiko = 'Sedang'

    # Simpan ke database
    data_baru = Deteksi(
        tekanan_darah=tekanan_darah,
        kolesterol=kolesterol,
        gula_darah=gula_darah,
        risiko=risiko
    )
    db.session.add(data_baru)
    db.session.commit()

    hasil = {
        'hasil_persentase': hitung_persentase(tekanan_darah, kolesterol, gula_darah),
        'hasil_status': risiko,
    }

    return jsonify(hasil), 200

def hitung_persentase(tekanan_darah, kolesterol, gula_darah):
    # Logika sederhana untuk menghasilkan angka antara 0 - 100
    total = tekanan_darah + kolesterol + gula_darah
    max_total = 200 + 300 + 250  # Anggap nilai maksimal sebagai pembagi
    persen = (total / max_total) * 100
    return round(min(persen, 100), 2)
