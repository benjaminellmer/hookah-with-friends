import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/auth/auth_bloc.dart";
import "../components/dialogs/set_username_dialog.dart";

class AuthBlocListener extends StatelessWidget {
  const AuthBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthRequireUsername) {
          showDialog(
              context: context,
              builder: (BuildContext contextWithoutBloc) {
                return BlocProvider<AuthBloc>.value(
                  value: context.read<AuthBloc>(),
                  child: SetUsernameDialog(),
                );
              });
        }
        if (state is AuthAuthenticated) {
          Navigator.of(context).popUntil((Route route) => route.isFirst);
        }
        if (state is AuthUnauthenticated) {
          if (state.statusMessage != null) {
            final SnackBar snackBar = SnackBar(
              content: Center(
                child: Text(state.statusMessage!),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: child,
    );
  }
}
