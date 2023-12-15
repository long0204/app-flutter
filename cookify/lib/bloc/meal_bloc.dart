import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object?> get props => [];
}

class DaySelected extends MealEvent {
  final String selectedDay;

  const DaySelected(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

// State
class MealState extends Equatable {
  final String selectedDay;
  final int totalVA;
  final int totalVB;
  final int totalWA;

  const MealState({
    required this.selectedDay,
    required this.totalVA,
    required this.totalVB,
    required this.totalWA,
  });

  @override
  List<Object?> get props => [selectedDay, totalVA, totalVB, totalWA];
}

// Bloc
class MealBloc extends Bloc<MealEvent, MealState> {
  final List<Map<String, String>> products;

  MealBloc({required this.products})
      : super(MealState(
          selectedDay: 'Mon',
          totalVA: 0,
          totalVB: 0,
          totalWA: 0,
        ));

  @override
  Stream<MealState> mapEventToState(MealEvent event) async* {
    if (event is DaySelected) {
      yield _calculateTotalNutrients(event.selectedDay);
    }
  }

  MealState _calculateTotalNutrients(String selectedDay) {
    int totalVA = 0;
    int totalVB = 0;
    int totalWA = 0;

    List<Map<String, dynamic>> dailyInfo = [
     {
        "Day": "Mon",
        "Bfcode": "CFSL001",
        "Luchcode": "CFSL003",
        "Snackcode": "CFSL005",
        "Dinnercode": "CFSL002",
        "Bftime": "6:30",
        "Lunchtime": "6:30",
        "Snacktime": "6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Tue",
       "Bfcode": "CFSL001",
        "Luchcode": "CFSL002",
        "Snackcode": "CFSL003",
        "Dinnercode": "CFSL004",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Wed",
      "Bfcode": "CFSL005",
        "Luchcode": "CFSL006",
        "Snackcode": "CFSL007",
        "Dinnercode": "CFSL008",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Thu",
       "Bfcode": "CFSL008",
        "Luchcode": "CFSL005",
        "Snackcode": "CFSL002",
        "Dinnercode": "CFSL004",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Fri",
        "Bfcode": "CFSL007",
        "Luchcode": "CFSL008",
        "Snackcode": "CFSL001",
        "Dinnercode": "CFSL003",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Sat",
       "Bfcode": "CFSL008",
        "Luchcode": "CFSL004",
        "Snackcode": "CFSL006",
        "Dinnercode": "CFSL002",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Sun",
       "Bfcode": "CFSL001",
        "Luchcode": "CFSL005",
        "Snackcode": "CFSL007",
        "Dinnercode": "CFSL005",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      } 
    ];

    List<Map<String, dynamic>> selectedDayInfo = dailyInfo
        .where((info) => info['Day'].toLowerCase() == selectedDay.toLowerCase())
        .toList();

    selectedDayInfo.forEach((info) {
      Map<String, dynamic>? productInfoA =
          products.firstWhere((product) => product['Productcode'] == info['Bfcode']);
      Map<String, dynamic>? productInfoB =
          products.firstWhere((product) => product['Productcode'] == info['Luchcode']);
      Map<String, dynamic>? productInfoC =
          products.firstWhere((product) => product['Productcode'] == info['Snackcode']);
      Map<String, dynamic>? productInfoD =
          products.firstWhere((product) => product['Productcode'] == info['Dinnercode']);

      totalVA += int.tryParse(productInfoA['VA'] ?? '0') ?? 0;
      totalVA += int.tryParse(productInfoB['VA'] ?? '0') ?? 0;
      totalVA += int.tryParse(productInfoC['VA'] ?? '0') ?? 0;
      totalVA += int.tryParse(productInfoD['VA'] ?? '0') ?? 0;

      totalVB += int.tryParse(productInfoA['VB'] ?? '0') ?? 0;
      totalVB += int.tryParse(productInfoB['VB'] ?? '0') ?? 0;
      totalVB += int.tryParse(productInfoC['VB'] ?? '0') ?? 0;
      totalVB += int.tryParse(productInfoD['VB'] ?? '0') ?? 0;

      totalWA += int.tryParse(productInfoA['WA'] ?? '0') ?? 0;
      totalWA += int.tryParse(productInfoB['WA'] ?? '0') ?? 0;
      totalWA += int.tryParse(productInfoC['WA'] ?? '0') ?? 0;
      totalWA += int.tryParse(productInfoD['WA'] ?? '0') ?? 0;
    });

    return MealState(
      selectedDay: selectedDay,
      totalVA: totalVA,
      totalVB: totalVB,
      totalWA: totalWA,
    );
  }
}
