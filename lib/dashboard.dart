import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino Icons
import 'konsultasi.dart';
import 'pendeteksi.dart';
import 'profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0; // Pindahkan _currentIndex ke sini!

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
          'Hello!',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF8A4E4E)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF8A4E4E),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF8A4E4E),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                'lib/assets/hearttangan.jpg',
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ayo, Periksa Jantung Anda!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A4E4E),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pemeriksaan yang Akurat',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF8A4E4E)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF1CF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF8A4E4E),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(11),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'lib/assets/ukurdetak.jpg',
                            fit: BoxFit.cover,
                            height: 160,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8A4E4E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const PendeteksiPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Pemeriksaan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
          boxShadow: [
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
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF5B0000),
            unselectedItemColor: const Color(0xFFA46A69),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              switch (index) {
                case 0:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const DashboardPage()),
                  );
                  break;
                case 1:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const KonsultasiPage()),
                  );
                  break;
                case 2:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const PendeteksiPage()),
                  );
                  break;
                case 3:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                  break;
              }
            },
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
}
