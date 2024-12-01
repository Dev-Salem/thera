import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:thera/src/core/router/go_route.dart';
import 'package:thera/src/features/user/data/user_repository.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return SupaEmailAuth(
                // redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
                onSignInComplete: (response) async {
                  ref.read(goRouterProvider).go("home");
                  ToastService.showSuccessToast(
                    context,
                    length: ToastLength.medium,
                    expandedHeight: 100,
                    message: "Sign in successfully",
                  );
                },
                onSignUpComplete: (response) async {
                  ref.read(goRouterProvider).go("home");
                  // ref.refresh(goRouterProvider);
                  // ref.read(goRouterProvider).go("home");
                  ToastService.showSuccessToast(
                    context,
                    length: ToastLength.long,
                    expandedHeight: 100,
                    message: "Account was created successfully, Now Sign In",
                  );
                },
              );
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 12),
    );
  }
}
