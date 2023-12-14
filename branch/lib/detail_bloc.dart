import 'package:branch/search_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DetailEvent {}

class LoadDetail extends DetailEvent with EquatableMixin {
  final District districtCode;

  LoadDetail(this.districtCode);

  @override
  List<Object?> get props => [districtCode];
}

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoaded extends DetailState {
  final District district;

  DetailLoaded(this.district);
}

class DetailError extends DetailState {
  final String error;

  DetailError(this.error);
}

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  // Thay thế bằng logic lấy chi tiết thực tế từ nguồn dữ liệu của bạn
  Future<District> fetchDetail(District districtCode) async {
    // Logic lấy dữ liệu chi tiết ở đây
    return Future.delayed(Duration(seconds: 1), () {
      return District(
        districtCode: districtCode.districtCode.toString(),
        provinceCode: districtCode.provinceCode.toString(), 
        districtName: districtCode.districtName.toString(),
        flagActive: districtCode.flagActive.toString(),
      );
    });
  }

  DetailBloc() : super(DetailInitial()); 

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is LoadDetail) {
      yield DetailInitial(); // Trạng thái ban đầu

      try {
        final district = await fetchDetail(event.districtCode);
        yield DetailLoaded(district); // Trạng thái khi dữ liệu chi tiết đã được tải
      } catch (error) {
        yield DetailError('Failed to load detail: $error');
      }
    }
  }
}
