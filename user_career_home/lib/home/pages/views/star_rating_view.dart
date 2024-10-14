import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  int? sizeStar;

  StarRating({super.key, required this.rating, this.sizeStar});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (rating == 0)
          Row(
            children: [
              const Text('N/A', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(width: 4),
              _buildStar(0, sizeStar, isNA: true),
            ],
          )
        else
          Row(
            children: List.generate(5, (index) {
              return _buildStar(index, sizeStar);
            }),
          ),
      ],
    );
  }

  Widget _buildStar(int index,  int? sizeStar, {bool isNA = false}) {
    IconData icon;
    if (isNA) {
      icon = Icons.star_border;
    } else if (index < rating) {
      icon = Icons.star;
    } else {
      icon = Icons.star_border;
    }

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: const [
            Colors.amber,
            Colors.grey,
          ],
          stops: _calculateStops(index),
        ).createShader(bounds);
      },
      child: Icon(
        icon,
        color: Colors.white,
        size: sizeStar?.toDouble() ?? 15,
      ),
    );
  }

  List<double> _calculateStops(int index) {
    double fullStars = rating.floorToDouble();
    double partialStar = rating - fullStars;

    if (index < fullStars) {
      return [1.0, 1.0];
    } else if (index == fullStars) {
      return [partialStar, partialStar];
    } else {
      return [0.0, 0.0];
    }
  }
}