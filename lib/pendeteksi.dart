import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dashboard.dart';
import 'konsultasi.dart';
import 'profile.dart';
import 'pendeteksihasil.dart';

class PendeteksiPage extends StatefulWidget {
  const PendeteksiPage({super.key});

  @override
  _PendeteksiPageState createState() => _PendeteksiPageState();
}

class _PendeteksiPageState extends State<PendeteksiPage> {
  int _currentIndex = 2;

  final TextEditingController tekananDarahController = TextEditingController();
  final TextEditingController kolesterolController = TextEditingController();
  final TextEditingController gulaDarahController = TextEditingController();
  final TextEditingController diagnosisController =
      TextEditingController(); // Tidak dipakai dalam submit

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const KonsultasiPage()),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  Future<void> submitData() async {
    final url = Uri.parse('http://10.0.2.2:5000/pendeteksi/deteksi');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tekanan_darah': tekananDarahController.text,
          'kolesterol': kolesterolController.text,
          'gula_darah': gulaDarahController.text,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final double hasilPersen =
            result['hasil_persentase']?.toDouble() ?? 0.0;
        final String hasilStatus = result['hasil_status'] ?? "Tidak diketahui";

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PendeteksiHasilPage(
              hasilPersentase: hasilPersen,
              hasilStatus: hasilStatus,
            ),
          ),
        );
      } else {
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memproses data')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan jaringan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF1CF),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: const Text(
          'Pendeteksi',
          style: TextStyle(
            color: Color(0xFF8A4E4E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/assets/heartguardnobg.png',
                  height: 36,
                ),
                const SizedBox(width: 6),
                const Text(
                  'HeGu',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Color(0xFF8A4E4E),
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Color(0x55000000),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF8A4E4E),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'Isi Data Pendeteksi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF8A4E4E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    _buildTextField('Tekanan darah', tekananDarahController),
                    const SizedBox(height: 18),
                    _buildTextField('Kadar kolesterol', kolesterolController),
                    const SizedBox(height: 18),
                    _buildTextField('Kadar gula darah', gulaDarahController),
                    const SizedBox(height: 185),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submitData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8A4E4E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Periksa',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: ImageAssetHeart(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFDF1CF),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: const Color.fromARGB(255, 116, 65, 65),
            unselectedItemColor: const Color.fromARGB(255, 194, 124, 124),
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0
                      ? const Color(0xFF5B0000)
                      : const Color(0xFFA46A69),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.phone,
                  color: _currentIndex == 1
                      ? const Color(0xFF5B0000)
                      : const Color(0xFFA46A69),
                ),
                label: 'Konsultasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _currentIndex == 2
                      ? const Color(0xFF5B0000)
                      : const Color(0xFFA46A69),
                ),
                label: 'Pendeteksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _currentIndex == 3
                      ? const Color(0xFF5B0000)
                      : const Color(0xFFA46A69),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(0xFF8A4E4E),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF8A4E4E),
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF8A4E4E),
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class ImageAssetHeart extends StatelessWidget {
  const ImageAssetHeart({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/lovee.png',
      height: 60,
    );
  }
}
