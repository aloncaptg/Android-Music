import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';
import 'package:flutter_application_1/models/song_model.dart';
import 'package:flutter_application_1/providers/favorite_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoriteProvider>();
    final likedCount = favProvider.favoriteIds.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('images/Budiluhur.jpg'),
            ),
            const SizedBox(height: 16),
            const Text('Attar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Music Enthusiast',
              style: TextStyle(color: Colors.grey[500], fontSize: 13)
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF151922), // Adjusted to dark theme color
                borderRadius: BorderRadius.circular(14), // Added border radius for consistency
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('$likedCount', 'Liked'),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.white10,
                  ),
                  _buildStatItem('24h', 'Streamed'),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.white10,
                  ),
                  _buildStatItem('5', 'Playlists'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuItem(
              icon: Icons.favorite_rounded,
              title: 'Favorite Songs',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(allSongs: sampleSongs),
                  ),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.history_rounded,
              title: 'Recently Played',
              onTap: () => _showRecentlyPlayed(context),
            ),
            _buildMenuItem(
              icon: Icons.storage_rounded,
              title: 'Clear Cache Data',
              onTap: () => _showClearCacheDialog(context),
            ),
            _buildMenuItem(
              icon: Icons.settings_rounded,
              title: 'Settings',
              onTap: () => _showSettings(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecentlyPlayed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151922),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final recentSongs = sampleSongs.take(4).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recently Played',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...recentSongs.map(
                (song) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      song.coverUrl,
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(width: 46, height: 46, color: Colors.white12),
                    ),
                  ),
                  title: Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                  trailing: const Icon(Icons.play_circle_fill_rounded,
                      color: Color(0xFF6366F1), size: 30),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF151922),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear Cache Data?'),
        content: const Text(
          'This will reset your local saved favorites and application cache.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<FavoriteProvider>().clearAll();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache & favorites cleared successfully!'),
                  backgroundColor: Color(0xFF151922),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151922),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Settings & Preferences',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.dark_mode_rounded, color: Color(0xFF6366F1)),
                title: const Text('Dark Mode Theme'),
                trailing: Switch(
                  value: true,
                  activeThumbColor: const Color(0xFF6366F1),
                  onChanged: (val) {},
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.high_quality_rounded, color: Color(0xFF6366F1)),
                title: const Text('Streaming Quality'),
                subtitle: const Text('High (320 kbps)', style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline_rounded, color: Color(0xFF6366F1)),
                title: const Text('App Version'),
                trailing: const Text('v1.0.0+1', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration( 
        color: const Color(0xFF151922),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF6366F1), size: 22),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
