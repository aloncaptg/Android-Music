import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../pages/detail_page.dart';
import 'animated_like_button.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final List<Song>? playlist;
  final int? index;

  const SongCard({
    super.key, 
    required this.song,
    this.playlist,
    this.index,
  });

  void _openDetail(BuildContext context) {
    final resolvedPlaylist = playlist ?? sampleSongs;
    final resolvedIndex = index ?? resolvedPlaylist.indexOf(song);
    final safeIndex = (resolvedIndex >= 0 && resolvedIndex < resolvedPlaylist.length)
        ? resolvedIndex
        : 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          playlist: resolvedPlaylist,
          initialIndex: safeIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF151922),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openDetail(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: 'cover_${song.id}',
                      child: Image.network(
                        song.coverUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: const Color(0xFF1E2430),
                            child: const Center(
                              child: Icon(
                                Icons.music_note_rounded,
                                size: 50,
                                color: Colors.white24,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: const Color(0xFF1E2430),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          song.tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              song.artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedLikeButton(songId: song.id),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
