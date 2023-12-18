import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Define events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class BookHotelEvent extends HomeEvent {
  final Map<String, String> hotel;

  BookHotelEvent(this.hotel);

  @override
  List<Object> get props => [hotel];
}

// Define states
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitialHomeState extends HomeState {}

class HotelBookedState extends HomeState {}

// Define the bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Map<String, String>> bookedHotels;

  HomeBloc(this.bookedHotels) : super(InitialHomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is BookHotelEvent) {
      // Check if the hotel is already booked
      bool isAlreadyBooked = bookedHotels.any((bookedHotel) {
        return bookedHotel['Hocode'] == event.hotel['Hocode'];
      });

      if (isAlreadyBooked) {
        // Return a state indicating the hotel is already booked
        yield InitialHomeState();
      } else {
        // Add the hotel to the bookedHotels list
        bookedHotels.add({
          "Hocode": event.hotel["Hocode"] ?? "",
          "Honame": event.hotel["Honame"] ?? "",
          "Checkin": DateTime.now().toString(), // Use the current date
          "Percount": "2",
          "Price": event.hotel["Price"] ?? "",
        });

        // Return a state indicating the hotel is booked
        yield HotelBookedState();
      }
    }
  }
}
