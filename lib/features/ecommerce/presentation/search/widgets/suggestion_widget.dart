import 'package:final_project/features/ecommerce/presentation/home/bloc/home_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_event.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Suggestions extends StatelessWidget {
  final Function(String) onSuggestionSelected;

  const Suggestions({super.key, required this.onSuggestionSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.query!.isNotEmpty && state.suggestions!.isNotEmpty) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: state.suggestions!.map((suggestion) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(suggestion, style: const TextStyle(fontSize: 16)),
                  onTap: () {
                    context.read<SearchBloc>().add(
                      PerformSearch(
                        suggestion,
                        context.read<HomeBloc>().state.products,
                      ),
                    );
                    onSuggestionSelected(suggestion);
                  },
                );
              }).toList(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
