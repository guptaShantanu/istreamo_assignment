import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istreamodemo/feature/login/bloc/login_bloc.dart';
import 'package:istreamodemo/feature/profile/ui/profile_screen.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  late LocalAuthentication localAuth;

  @override
  void initState() {
    loginBloc = LoginBloc();
    localAuth = LocalAuthentication();
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    bool isSupport = await localAuth.isDeviceSupported();
    if (canCheckBiometrics && isSupport) {
      var localAuth = LocalAuthentication();
      bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance');
      if (didAuthenticate) {
        loginBloc.add(SubmitLoginEvent(authResult: didAuthenticate));
      } else {
        loginBloc.add(SubmitLoginEvent(authResult: didAuthenticate));
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      loginBloc.add(const SubmitLoginEvent(authResult: true));
    }
  }

  void _onSuccess() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              _onSuccess();
            }
          },
          bloc: loginBloc,
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoginErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        loginBloc.add(ResetLoginEvent());
                        checkAuth();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.black,
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is LoginInitialState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.fingerprint,
                      size: 80.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Please authorize yourself',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            } else if (state is LoginSuccessState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.fingerprint,
                      size: 80.0,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      width: 100.0,
                      child: LinearProgressIndicator(),
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
