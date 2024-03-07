import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class ApprovalState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApprovalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ApprovalBloc extends Bloc<ApprovalEvent, ApprovalState> {
  ApprovalBloc() : super(ApprovalState());

  @override
  Stream<ApprovalState> mapEventToState(ApprovalEvent event) async* {
    if (event is CheckUserExistEvent) {
      try {
        final apiUrl = 'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGateForEcore.V10.WA/Ecore/Inos_CheckUserExist';

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'GwUserCode': 'idocNet.idN.MobileGate.Sv',
            'GwPassword': 'idocNet.idN.MobileGate.Sv',
            'NetworkID': '4221896000',
            'OrgID': '4221896000',
            'NetworkId': '4221896000',
            'OrgId': '4221896000',
          },
          body: {
            'UserCode': event.email,
          },
        );

        if (response.statusCode == 200 && response.body['Success'] == true) {
          yield UserExistsState();
        } else {
          yield UserDoesNotExistState();
        }
      } catch (e) {
        yield UserDoesNotExistState();
      }
    } else if (event is RequestTokenEvent) {
      try {
        final apiUrl = 'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGateForEcore.V10.WA/Ecore/Inos_RequestToken';

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'GwUserCode': 'idocNet.idN.MobileGate.Sv',
            'GwPassword': 'idocNet.idN.MobileGate.Sv',
          },
          body: {
            'usercode': event.email,
            'password': event.password,
          },
        );

        if (response.statusCode == 200) {

        } else {

        }
      } catch (e) {
       print('Error api');
      }
    }
  }
}

class RequestTokenEvent {
}

class UserDoesNotExistState {
}

class CheckUserExistEvent {
}
