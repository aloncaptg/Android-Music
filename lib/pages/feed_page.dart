import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../widgets/song_card.dart';

enum SortOption { defaultOrder, titleAZ, titleZA, artistAZ, artistZA }

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  SortOption _sortOption = SortOption.defaultOrder;
  String _selectedCategory = 'All';

  List<Song> get _filteredAndSortedSongs {
    final List<Song> songs = _selectedCategory == 'All'
        ? List<Song>.from(sampleSongs)
        : sampleSongs
            .where(
              (song) =>
                  song.tag.toLowerCase() == _selectedCategory.toLowerCase(),
            )
            .toList();

    switch (_sortOption) {
      case SortOption.titleAZ:
        songs.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.titleZA:
        songs.sort((a, b) => b.title.compareTo(a.title));
        break;
      case SortOption.artistAZ:
        songs.sort((a, b) => a.artist.compareTo(b.artist));
        break;
      case SortOption.artistZA:
        songs.sort((a, b) => b.artist.compareTo(a.artist));
        break;
      case SortOption.defaultOrder:
        break;
    }
    return songs;
  }

  @override
  Widget build(BuildContext context) {
    final songs = _filteredAndSortedSongs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Discover Vibes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort_rounded),
            initialValue: _sortOption,
            tooltip: 'Sort songs',
            onSelected: (value) => setState(() => _sortOption = value),
            itemBuilder: (context) => [
              _buildSortMenuItem(SortOption.defaultOrder, 'Default', Icons.shuffle_rounded),
              _buildSortMenuItem(SortOption.titleAZ, 'Title A-Z', Icons.sort_by_alpha_rounded),
              _buildSortMenuItem(SortOption.titleZA, 'Title Z-A', Icons.sort_by_alpha_rounded),
              _buildSortMenuItem(SortOption.artistAZ, 'Artist A-Z', Icons.person_search_rounded),
              _buildSortMenuItem(SortOption.artistZA, 'Artist Z-A', Icons.person_search_rounded),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: const Color(0xFF6366F1),
                    backgroundColor: const Color(0xFF151922),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: songs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.music_off_rounded,
                          size: 56,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No songs found for category "$_selectedCategory"',
                          style: TextStyle(color: Colors.grey[400], fontSize: 15),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];

                      return SongCard(
                        song: song,
                        playlist: songs,
                        index: index,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<SortOption> _buildSortMenuItem(
    SortOption option,
    String title,
    IconData icon,
  ) {
    final isSelected = _sortOption == option;
    return PopupMenuItem<SortOption>(
      value: option,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[400],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFF6366F1) : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check_rounded,
              size: 18,
              color: Color(0xFF6366F1),
            ),
        ],
      ),
    );
  }
}

