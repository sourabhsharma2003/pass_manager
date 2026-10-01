import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/views/auth_view_switcher.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/error_widget.dart';

import 'package:password_manager/src/features/auth/presentation/widgets/valt_container.dart';

class AuthScreen extends ConsumerWidget {
   Widget vaultContainer() {
    return VaultContainer(
      icon: Icons.lock,
      scale: 60,
      color: AppColors.primary,
    );
  }

  Widget appTitlewidget() {
    return Text(
      'KeyVault',
      style: GoogleFonts.fraunces(
        color: AppColors.primary,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
 
  Future<void> _errordialog(BuildContext context,String error) {
    return showDialog(
    
      context: context,
      builder: (context) => ErrorDialog(
        key: WidgetKeys.loginErrordialog,
        title: 'Login Error',
        content: error,
        onTap: () {
          Navigator.pop(context);
        },
        actionName: 'Retry',
      ),
    );
  }
  
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.listen(authNotifierProvider.select((s) => s.error), (prev, next) async {
      if (next != null &&prev!=next ) {
        
        _errordialog(context,next);
      }
    });
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              vaultContainer(),
              appTitlewidget(),
              
              AuthViewSwitcher(),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
