import 'package:final_project/core/di/injection_container.dart';
import 'package:final_project/core/utils/app_router.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_event.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  final homeBloc = sl<HomeBloc>();
  final savedBloc = sl<SavedBloc>();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: homeBloc),
        BlocProvider(create: (_) => sl<SearchBloc>()),
        BlocProvider.value(value: savedBloc),
      ],
      child: const MyApp(),
    ),
  );
  homeBloc.add(LoadHome());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
