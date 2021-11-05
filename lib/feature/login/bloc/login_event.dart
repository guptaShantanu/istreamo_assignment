part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SubmitLoginEvent extends LoginEvent {
  final bool authResult;

  const SubmitLoginEvent({required this.authResult});
  @override
  List<Object?> get props => [];
}

class ResetLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
