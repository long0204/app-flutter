import 'package:equatable/equatable.dart';

abstract class Tab6Event extends Equatable {
  const Tab6Event();

  @override
  List<Object> get props => [];
}

class SearchTextChanged extends Tab6Event {
  final String keyword;

  const SearchTextChanged({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class SearchPerformed extends Tab6Event {
  final String keyword;

  const SearchPerformed({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
