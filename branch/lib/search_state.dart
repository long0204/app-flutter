import 'package:branch/district_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<District> searchResults;

  SearchSuccess({required this.searchResults});

  @override
  List<Object?> get props => [searchResults];
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
