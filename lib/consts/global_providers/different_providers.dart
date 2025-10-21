import 'package:flutter_riverpod/flutter_riverpod.dart';

final dotIndexProvider = StateProvider((ref) => 0);

final obsecureTextProvider = StateProvider<bool>((ref) => true);

final seeAllProviders = StateProvider<bool>((ref) => false);
