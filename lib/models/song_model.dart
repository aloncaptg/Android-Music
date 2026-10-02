class Song {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final String tag;
  final String audioUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.tag,
    required this.audioUrl,
  });
}

final List<String> categories = ['All', 'Trending', 'Popular', 'Relax'];

final List<Song> sampleSongs = [
  Song(
    id: '1',
    title: 'Midnight Coding Beats',
    artist: 'Lo-Fi Chill Hop',
    coverUrl: 'https://picsum.photos/id/145/800/600',
    tag: 'Trending',
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', // 6:12
  ),
  Song(
    id: '2',
    title: 'Cyberpunk Synthwave',
    artist: 'Neon Vibe Studio',
    coverUrl: 'https://picsum.photos/id/1067/800/600',
    tag: 'Popular',
    audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3', // 2:27
  ),
  Song(
    id: '3',
    title: 'Acoustic Coffee Break',
    artist: 'Indie Chill',
    coverUrl: 'https://picsum.photos/id/225/800/600',
    tag: 'Relax',
    audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__Natura_Trance.mp3', // 4:13
  ),
  Song(
    id: '4',
    title: 'Late Night Drive',
    artist: 'Retro Synth',
    coverUrl: 'https://picsum.photos/id/122/800/600',
    tag: 'Trending',
    audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg', // 1:55
  ),
  Song(
    id: '5',
    title: 'Morning Acoustic',
    artist: 'Sunrise Cafe',
    coverUrl: 'https://picsum.photos/id/212/800/600',
    tag: 'Popular',
    audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/riceracer_assets/music/race1.ogg', // 1:26
  ),
  Song(
    id: '6',
    title: 'Deep Focus Study',
    artist: 'Brain Waves',
    coverUrl: 'https://picsum.photos/id/201/800/600',
    tag: 'Relax',
    audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/riceracer_assets/music/race2.ogg', // 1:23
  ),
  Song(
    id: '7',
    title: 'Lofi Hip Hop Mix',
    artist: 'Chill Cow',
    coverUrl: 'https://picsum.photos/id/301/800/600',
    tag: 'Trending',
    audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/riceracer_assets/music/menu.ogg', // 1:11
  ),
];
