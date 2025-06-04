import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_heartguart/onboardingpage.dart';
import 'pendeteksi.dart';
import 'dashboard.dart';
import 'konsultasi.dart';
import 'profileedit.dart';
import '../services/auth_service_pro.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;

  String name = '';
  String email = '';
  String gender = '';
  int usia = 0;
  String avatarUrl = '';

  bool isLoading = true;

  final AuthServicePro _authService = AuthServicePro();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId != null && userId > 0) {
      try {
        final result = await _authService.fetchUserProfile(userId);

        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];

          setState(() {
            name = data['name'] ?? 'Nama';
            email = data['email'] ?? 'Email tidak tersedia';
            gender = data['gender'] ?? 'Tidak diketahui';
            usia = data['usia'] ?? 0;
            avatarUrl = ''; // Jika nanti backend mendukung foto, bisa diubah
            isLoading = false;
          });

          // Simpan juga ke SharedPreferences jika diperlukan
          await prefs.setString('user_name', name);
          await prefs.setString('user_email', email);
          await prefs.setString('user_gender', gender);
          await prefs.setInt('user_age', usia);
          await prefs.setString('user_avatar', avatarUrl);
        } else {
          // Jika gagal dari server, coba pakai cache
          _loadCachedUserData(prefs);
        }
      } catch (e) {
        print('Error fetching user data: $e');
        _loadCachedUserData(prefs); // fallback ke data lokal
      }
    } else {
      _loadCachedUserData(prefs);
    }
  }

  void _loadCachedUserData(SharedPreferences prefs) {
    if (mounted) {
      setState(() {
        name = prefs.getString('user_name') ?? 'Nama';
        email = prefs.getString('user_email') ?? 'Email tidak tersedia';
        gender = prefs.getString('user_gender') ?? 'Tidak diketahui';
        usia = prefs.getInt('user_age') ?? 0;
        avatarUrl = prefs.getString('user_avatar') ?? '';
        isLoading = false;
      });
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
          'Profile',
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 35),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 600,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7D6),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: const Color(0xFF8A4E4E), width: 2),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(CupertinoIcons.person_add),
                              color: const Color(0xFF8A4E4E),
                              onPressed: () => _showAccountOptions(context),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(CupertinoIcons.gear),
                              color: const Color(0xFF8A4E4E),
                              onPressed: () => _showSettingsOptions(context),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: (avatarUrl.isNotEmpty)
                                  ? NetworkImage(avatarUrl)
                                  : const AssetImage(
                                          'lib/assets/dranimasi.jpeg')
                                      as ImageProvider,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF8A4E4E),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(email,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(gender),
                                const SizedBox(width: 20),
                                Text(
                                  usia > 0
                                      ? '$usia Tahun'
                                      : 'Usia tidak diketahui',
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfilePage()),
                                ).then((_) => loadUserData());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD77248),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDF1CF),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF5B0000),
          unselectedItemColor: const Color(0xFFA46A69),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() => _currentIndex = index);
            switch (index) {
              case 0:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const DashboardPage()));
                break;
              case 1:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const KonsultasiPage()));
                break;
              case 2:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const PendeteksiPage()));
                break;
              case 3:
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone), label: 'Konsultasi'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Pendeteksi'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  void _showAccountOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SafeArea(child: Wrap(children: [])),
    );
  }

  void _showSettingsOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfilePage()))
                    .then((_) => loadUserData());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text('Logout'),
              onTap: () async {
                await _authService.logout();
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const OnBoardingPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
