import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/auth/auth_bloc.dart";
import "../../util/colors.dart";

class AuthLoadingIndicator extends StatelessWidget {
  const AuthLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthLoading) {
          return Container(
            color: Colors.grey.withOpacity(0.5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                color: HWFColors.heading,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
