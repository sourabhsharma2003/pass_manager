import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/images.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/bio_auth_widget.dart';

class BioAuthView extends ConsumerStatefulWidget {
  const BioAuthView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BioAuthView();
}

class _BioAuthView extends ConsumerState<BioAuthView> {
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(authNotifierProvider.notifier).bioAuth();
  });
  }

  @override
  Widget build(BuildContext context) {
    return BioAuthWidget(image: Images.bioasset);
  }
}
