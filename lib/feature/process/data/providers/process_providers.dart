import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/process/data/models/process_state.dart';
import 'package:khizmat_new/feature/process/data/notifiers/process_notifier.dart';

// ─────────────────────────────────────────────────────────────────────────────
// processProvider
// ─────────────────────────────────────────────────────────────────────────────
//
// Single instance per page (autoDispose cleans up when StepsPage leaves the
// navigator stack, preventing stale application state).
//
// Usage in StepsPage:
//   final processAsync = ref.watch(processProvider);
//   ref.read(processProvider.notifier).start(docId, locale);
//   ref.read(processProvider.notifier).next(values: stepFields);
//   ref.read(processProvider.notifier).back();
//   ref.read(processProvider.notifier).cancel();

final processProvider =
    NotifierProvider.autoDispose<ProcessNotifier, AsyncValue<ProcessState>>(
  ProcessNotifier.new,
);
