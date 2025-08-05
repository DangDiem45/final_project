import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  final List<String> recentSearches;
  final Function(String) onRemove;
  final Function(String) onTap;

  const RecentSearches({
    super.key,
    required this.recentSearches,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  recentSearches.forEach(onRemove);
                },
                child: const Text(
                  'Clear all',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                final search = recentSearches[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  title: Text(search, style: const TextStyle(fontSize: 16)),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                    onPressed: () => onRemove(search),
                  ),
                  onTap: () => onTap(search),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
