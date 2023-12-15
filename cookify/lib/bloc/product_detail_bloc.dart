import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class OpenVideoEvent extends ProductDetailEvent {
  final String videoUrl;

  OpenVideoEvent(this.videoUrl);

  @override
  List<Object> get props => [videoUrl];
}

// States
abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}


class InitialState extends ProductDetailState {}

class VideoOpenState extends ProductDetailState {
  final String videoUrl;

  VideoOpenState(this.videoUrl);

  @override
  List<Object> get props => [videoUrl];
}

// BLoC
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(InitialState());

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is OpenVideoEvent) {
      yield VideoOpenState(event.videoUrl);
    }
  }
}
