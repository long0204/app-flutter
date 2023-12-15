import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class CategorySelected extends CategoriesEvent {
  final String selectedCategory;

  CategorySelected(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

// States
class CategoriesState {
  final String selectedCategory;

  CategoriesState(this.selectedCategory);
}

// Bloc
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(String initialCategory)
      : super(CategoriesState(initialCategory));

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is CategorySelected) {
      yield CategoriesState(event.selectedCategory);
    }
  }
}
