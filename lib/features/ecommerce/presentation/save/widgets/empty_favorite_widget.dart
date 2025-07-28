import 'package:flutter/material.dart';

class EmptyFavoriteWidget extends StatelessWidget {
  const EmptyFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No Saved Items!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You don’t have any saved items.\nGo to home and add some.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
