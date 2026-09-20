import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/features/auth/presentation/containers/auth_state_container.dart';

import 'package:password_manager/src/features/auth/presentation/widgets/valt_container.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              VaultContainer(
                icon: Icons.lock,
                scale: 50,
                color: AppColors.primary,
              ),
              Text(
                'Welcome Back',
                style: GoogleFonts.fraunces(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              AuthStateContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
