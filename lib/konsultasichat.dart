import 'package:flutter/material.dart';
import 'package:flutter_heartguart/konsultasi.dart';

class ChatKonsultasiPage extends StatelessWidget {
  const ChatKonsultasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1CF), // Background pastel
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF1CF),
        elevation: 0,
        automaticallyImplyLeading: false,

        // back‐arrow di leading, bukan di title
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFF8A4E4E),
            size: 28,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const KonsultasiPage()),
            );
          },
        ),

        // judul + subtitle
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Dr. Fara',
              style: TextStyle(
                color: Color(0xFF8A4E4E),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Spesialis Jantung',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),

        // logo + teks HeGu di actions
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('lib/assets/heartguardnobg.png', height: 36),
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

      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('lib/assets/lovebg.png'), // latar love
                  repeat: ImageRepeat.repeat,
                  opacity: 0.2,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  ChatBubble(
                    text: 'Apa yang Anda Rasakan Saat Ini?',
                    isSender: true,
                  ),
                  ChatBubble(
                    text:
                        'Jika saya mengalami nyeri dada di rumah, apa yang harus saya lakukan?',
                    isSender: false,
                  ),
                  ChatBubble(
                    text:
                        'Segera hentikan aktivitas, duduk atau berbaring dengan nyaman, tarik napas perlahan. Jika nyeri tidak membaik dalam 5 menit atau disertai gejala lain seperti sesak napas atau pusing, segera hubungi ambulans atau pergi ke IGD.',
                    isSender: true,
                  ),
                  ChatBubble(
                    text: 'Baik. Terima kasih Dokter.',
                    isSender: false,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.brown),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A4E4E),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kirim',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatBubble({Key? key, required this.text, required this.isSender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xFFFFE0B2) : const Color(0xFFFFCC80),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isSender ? 0 : 16),
            bottomRight: Radius.circular(isSender ? 16 : 0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
    );
  }
}
