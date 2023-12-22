import 'package:equatable/equatable.dart';

class Tab6State extends Equatable {
  final List<dynamic> searchResults;
  final bool isLoading;

  const Tab6State({required this.searchResults, required this.isLoading});

  @override
  List<Object> get props => [searchResults, isLoading];

  Tab6State copyWith({List<dynamic>? searchResults, bool? isLoading}) {
    return Tab6State(
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class Tab6Initial extends Tab6State {
  Tab6Initial() : super(searchResults: [], isLoading: false);
}


class Tab6Loading extends Tab6State {
  const Tab6Loading({List<dynamic> searchResults = const []})
      : super(searchResults: searchResults, isLoading: true);
}

class Tab6Loaded extends Tab6State {
  const Tab6Loaded({required List<dynamic> searchResults})
      : super(searchResults: searchResults, isLoading: false);
}

class Tab6Error extends Tab6State {
  Tab6Error() : super(searchResults: [], isLoading: false);
}

