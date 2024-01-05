import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApprovalBloc extends Bloc<dynamic, ApprovalState> {
  ApprovalBloc() : super(ApprovalState());

  @override
  Stream<ApprovalState> mapEventToState(dynamic event) async* {
    // Xử lý các sự kiện nếu cần
  }
}
