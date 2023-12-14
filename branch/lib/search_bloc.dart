import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'search_event.dart'; // Import the correct file

class District {
  final String districtCode;
  final String provinceCode;
  final String districtName;
  final String flagActive;

  District({
    required this.districtCode,
    required this.provinceCode,
    required this.districtName,
    required this.flagActive,
  });
}

class Province {
  final String provinceCode;
  final String provinceName;
  final String flagActive;

  Province({
    required this.provinceCode,
    required this.provinceName,
    required this.flagActive,
  });
}

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<District> searchResults;

  SearchSuccess({required this.searchResults});

  @override
  List<Object> get props => [searchResults];
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure({required this.error});

  @override
  List<Object> get props => [error];
}


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<District> sampleDistricts = [
    District(
      districtCode: "10101",
      provinceCode: "101",
      districtName: "Quận Ba Đình",
      flagActive: "1",
    ),
    District(
      districtCode: "10103",
      provinceCode: "101",
      districtName: "Quận Tây Hồ",
      flagActive: "1",
    ),
    District(
      districtCode: "10105",
      provinceCode: "101",
      districtName: "Quận Hoàn Kiếm",
      flagActive: "1",
    ),
    District(
      districtCode: "10106",
      provinceCode: "101",
      districtName: "Quận Long Biên",
      flagActive: "1",
    ),
  ];

  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchButtonPressed) {
      yield SearchLoading();

      try {
        // Thực hiện logic tìm kiếm
        final results = _performSearch(event);

        // Sau khi có kết quả, phát ra trạng thái SearchSuccess
        yield SearchSuccess(searchResults: results);
      } catch (e) {
        // Nếu có lỗi, phát ra trạng thái SearchFailure
        yield SearchFailure(error: "Error: $e");
      }
    } else if (event is UpdateDistrictList) {
      sampleDistricts = event.updatedList;
      // You may want to emit a state indicating that the list has been updated
      yield SearchSuccess(searchResults: sampleDistricts);
    }
  }

  List<District> _performSearch(SearchButtonPressed event) {
    bool matchesProvince ;
    return sampleDistricts.where((district) {
      if( event.province=='0') { matchesProvince = true;}
      else
      { matchesProvince = district.provinceCode == event.province;}
      bool matchesDistrict = district.districtName.toLowerCase().contains(event.district.toLowerCase());
      bool matchesStatus = district.flagActive == event.status;
      // Trả về true nếu tất cả các điều kiện đều đúng
      return matchesProvince && matchesDistrict && matchesStatus;
      
     
    }).toList();
  }
}
