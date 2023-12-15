import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class OpenVideoEvent extends ProductDetailEvent {
  final String videoUrl;

  OpenVideoEvent(this.videoUrl);

  @override
  List<Object?> get props => [videoUrl];
}
