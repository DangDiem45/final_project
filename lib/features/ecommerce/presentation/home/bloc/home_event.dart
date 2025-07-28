import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHome extends HomeEvent {}

class LoadProductsByCategory extends HomeEvent {
  final String category;
  const LoadProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class RefreshHome extends HomeEvent {}
