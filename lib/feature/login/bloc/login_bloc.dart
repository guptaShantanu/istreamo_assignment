import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SubmitLoginEvent) {
      yield* performAuth(event);
    } else if (event is ResetLoginEvent) {
      yield LoginInitialState();
    }
  }

  Stream<LoginState> performAuth(SubmitLoginEvent event) async* {
    if (event.authResult) {
      yield LoginSuccessState();
    } else {
      yield LoginErrorState();
    }
  }
}
