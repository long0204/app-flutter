import 'package:bloc/bloc.dart';

class AppBloc extends Bloc<int, int> {
  AppBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
