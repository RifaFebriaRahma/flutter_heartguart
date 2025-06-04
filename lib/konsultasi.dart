import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pendeteksi.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'konsultasichat.dart';

class KonsultasiPage extends StatefulWidget {
  const KonsultasiPage({Key? key}) : super(key: key);

  @override
  _KonsultasiPageState createState() => _KonsultasiPageState();
}

class _KonsultasiPageState extends State<KonsultasiPage> {
  // Declare the current index for Bottom Navigation
  int _currentIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const DashboardPage()));
        break;
      case 1:
        // Already on KonsultasiPage, no need to navigate
        break;
      case 2:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PendeteksiPage()));
        break;
      case 3:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              _buildSearchBar(),
              const SizedBox(height: 15),
              _buildDoctorImage(),
              _buildMenuSection(context),
              _buildDoctorList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFDF1CF),
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 24,
      title: const Text(
        'Konsultasi',
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
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8A4E4E)),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF8A4E4E), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF8A4E4E), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorImage() {
    return Image.asset(
      'lib/assets/heartdokter.jpg',
      height: 210,
      fit: BoxFit.cover,
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF1CF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _MenuIcon(icon: Icons.message, label: 'Konsultasi'),
                  _MenuIcon(icon: Icons.place, label: 'Location'),
                  _MenuIcon(icon: Icons.home, label: 'Hospital'),
                  _MenuIcon(icon: Icons.grid_view, label: 'More'),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person),
                label: const Text('Konsultasi dengan dokter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 181, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  foregroundColor: Color.fromARGB(255, 141, 82, 82),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 220,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            _DoctorCard(
              image: 'lib/assets/drfara.jpg',
              name: 'Dr. Fara',
              specialty: 'Spesialis Jantung',
            ),
            _DoctorCard(
              image: 'lib/assets/drreva.jpg',
              name: 'Dr. Refa',
              specialty: 'Spesialis Jantung',
            ),
            _DoctorCard(
              image: 'lib/assets/drfira.jpg',
              name: 'Dr. Fira',
              specialty: 'Spesialis Jantung',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
          selectedItemColor: Color.fromARGB(255, 116, 65, 65),
          unselectedItemColor: Color.fromARGB(255, 194, 124, 124),
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
    );
  }
}

class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuIcon({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Color.fromARGB(255, 139, 80, 80), size: 30),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String image;
  final String name;
  final String specialty;

  const _DoctorCard({
    Key? key,
    required this.image,
    required this.name,
    required this.specialty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 112, 73, 73),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              image,
              height: 110,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            specialty,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 100, 100, 100),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                if (name == 'Dr. Fara') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChatKonsultasiPage(),
                    ),
                  );
                }
              },
              child: const Text('Hubungi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 134, 73, 71),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
