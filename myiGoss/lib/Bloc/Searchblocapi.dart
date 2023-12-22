import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Event/Event.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'Statesearch.dart';

class Tab6Bloc extends Bloc<Tab6Event, Tab6State> {
  Tab6Bloc() : super(Tab6Initial());

  @override
  Stream<Tab6State> mapEventToState(
      Tab6Event event,
      ) async* {
    if (event is SearchTextChanged) {
      yield* _mapSearchTextChangedToState(event);
    } else if (event is SearchPerformed) {
      yield* _mapSearchPerformedToState(event);
    }
  }

  Stream<Tab6State> _mapSearchTextChangedToState(SearchTextChanged event) async* {
    yield Tab6Loading();
    // You can perform any additional logic here before performing the search
    // For example, debounce the input or perform validation
    yield state.copyWith(searchResults: [], isLoading: false);
  }

  Stream<Tab6State> _mapSearchPerformedToState(SearchPerformed event) async* {
    try {
      yield Tab6Loading();
      final searchResults = await _search(event.keyword);
      yield Tab6Loaded(searchResults: searchResults);
    } catch (e) {
      yield Tab6Error();
    }
  }

  Future<List<dynamic>> _search(String keyword) async {
    final response = await http.post(
      Uri.parse('https://devsyscm.inos.vn:12089/idocNet.Test.MobileGate.V10.WA/iGoss/iGoss_KBSearch'),
      headers: {
        'GwUserCode': 'idocNet.idN.MobileGate.Sv',
        'GwPassword': 'idocNet.idN.MobileGate.Sv',
        'NetworkID': '4221896000',
        'OrgID': '4221896000',
      },
      body: {
        'NetworkID': '4221896000',
        'OrgID': '4221896000',
        'CategoryId': '0',
        'Id': '0',
        'Keyword': keyword,
        'pageIndex': '0',
        'pageSize': '10',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Check if there is a list before assigning
      if (jsonResponse['item'] != null) {
        return jsonResponse['item'];
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final tab6Bloc = Tab6Bloc();
