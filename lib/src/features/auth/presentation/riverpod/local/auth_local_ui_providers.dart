import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_local_notifier.dart';

final authLocalUiProvider = NotifierProvider(() => AuthLocalNotifier());
