from flask import Blueprint, request, jsonify

konsultasi_bp = Blueprint('konsultasi', __name__, url_prefix='/konsultasi')

@konsultasi_bp.route('/cek', methods=['GET'])
def cek_konsultasi():
    return jsonify({'message': 'Konsultasi endpoint aktif!'})

@konsultasi_bp.route('/tanya', methods=['POST'])
def tanya_dokter():
    data = request.get_json()
    pertanyaan = data.get('pertanyaan', '').lower()

    if not pertanyaan:
        return jsonify({'error': 'Pertanyaan kosong'}), 400

    # Logika jawaban otomatis sederhana
    if "nyeri dada" in pertanyaan:
        jawaban = (
            "Segera hentikan aktivitas, duduk atau berbaring dengan nyaman, "
            "tarik napas perlahan, dan jika nyeri tidak membaik dalam 5 menit "
            "atau disertai gejala lain seperti sesak napas atau pusing, segera "
            "hubungi ambulans atau pergi ke IGD."
        )
    elif "terima kasih" in pertanyaan:
        jawaban = "Sama-sama. Semoga sehat selalu!"
    else:
        jawaban = "Terima kasih atas pertanyaannya. Dokter akan segera menanggapi."

    return jsonify({
        'pertanyaan': pertanyaan,
        'jawaban': jawaban
    }), 200
