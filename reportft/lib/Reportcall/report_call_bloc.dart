import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Sự kiện
abstract class ReportCallEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadReportCall extends ReportCallEvent {
  final String typeCallCode;

  LoadReportCall(this.typeCallCode);

  @override
  List<Object?> get props => [typeCallCode];
}

// Trạng thái
abstract class ReportCallState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReportCallInitial extends ReportCallState {}

class ReportCallLoaded extends ReportCallState {
  final List<Map<String, String>> reportData;

  ReportCallLoaded(this.reportData);

  @override
  List<Object?> get props => [reportData];
}

class ReportCallBloc extends Bloc<ReportCallEvent, ReportCallState> {
  ReportCallBloc() : super(ReportCallInitial());

  @override
  Stream<ReportCallState> mapEventToState(ReportCallEvent event) async* {
    if (event is LoadReportCall) {
      // Thực hiện xử lý để tải dữ liệu cho typeCallCode
      // Trong trường hợp thực tế, bạn có thể gọi API hoặc thực hiện các bước khác để lấy dữ liệu
      // Dưới đây, mình chỉ trả về dữ liệu mẫu
      yield ReportCallLoaded([
        {"Date": "2023-12-01 00:00", "countcall": "10"},
        {"Date": "2023-12-01 01:00", "countcall": "10"},
        {"Date": "2023-12-01 02:00", "countcall": "10"},
        {"Date": "2023-12-01 03:00", "countcall": "10"},
        {"Date": "2023-12-01 04:00", "countcall": "10"},
        {"Date": "2023-12-01 05:00", "countcall": "10"},
        {"Date": "2023-12-01 06:00", "countcall": "10"},
        {"Date": "2023-12-01 07:00", "countcall": "10"},
        {"Date": "2023-12-01 08:00", "countcall": "10"},
        {"Date": "2023-12-01 09:00", "countcall": "10"},
        {"Date": "2023-12-01 10:00", "countcall": "10"},
        {"Date": "2023-12-01 11:00", "countcall": "10"},
        {"Date": "2023-12-01 12:00", "countcall": "10"},
        {"Date": "2023-12-01 13:00", "countcall": "10"},
        {"Date": "2023-12-01 14:00", "countcall": "10"},
        {"Date": "2023-12-01 15:00", "countcall": "10"},
        {"Date": "2023-12-01 16:00", "countcall": "10"},
        {"Date": "2023-12-01 17:00", "countcall": "10"},
        {"Date": "2023-12-01 18:00", "countcall": "10"},
        {"Date": "2023-12-01 19:00", "countcall": "10"},
        {"Date": "2023-12-01 20:00", "countcall": "10"},
        {"Date": "2023-12-01 21:00", "countcall": "10"},
        {"Date": "2023-12-01 22:00", "countcall": "10"},
        {"Date": "2023-12-01 23:00", "countcall": "10"},
      ]);
    }
  }
}
