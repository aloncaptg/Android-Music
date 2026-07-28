import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatefulWidget {
  const AnimatedLikeButton({super.key});

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton> {
  bool isLiked = false;
  int likeCount = 128;
  double scale = 1.0;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      isLiked ? likeCount++ : likeCount--;
      scale = 1.35;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        scale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleLike,
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? const Color(0xFFEC4899) : Colors.grey,
              size: 20,
            ),
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
    );
  }
}
