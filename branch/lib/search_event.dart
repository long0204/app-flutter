import 'package:branch/search_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchButtonPressed extends SearchEvent {
  final String province;
  final String district;
  final String status;

  SearchButtonPressed({
    required this.province,
    required this.district,
    required this.status,
  });

  @override
  List<Object> get props => [province, district, status];
}

class UpdateDistrictList extends SearchEvent {
  final List<District> updatedList;

  UpdateDistrictList({required this.updatedList});

  @override
  List<Object> get props => [updatedList];
}
