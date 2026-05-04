import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/deeplink/notifier.dart';
import 'package:khizmat_new/deeplink/stateModel.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref),
);