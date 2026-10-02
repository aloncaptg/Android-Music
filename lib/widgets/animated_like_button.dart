import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/favorite_provider.dart';

class AnimatedLikeButton extends StatefulWidget {
  final String songId;
  const AnimatedLikeButton({super.key, required this.songId});

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton> {
  double scale = 1.0;

  void _toggleLike() {
    context.read<FavoriteProvider>().toggleFavorite(widget.songId);
    setState(() {
      scale = 1.35;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          scale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = context.watch<FavoriteProvider>().isFavorite(widget.songId);
    final likeCount = 128 + (isLiked ? 1 : 0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleLike,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? const Color(0xFFEC4899) : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$likeCount',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
