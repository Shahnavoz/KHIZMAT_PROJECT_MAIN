import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Провайдеры
// ─────────────────────────────────────────────────────────────────────────────
final actionLoadingProvider = StateProvider.family<bool, String>((ref, name) => false);

final formValuesProvider = StateNotifierProvider<FormValuesNotifier, Map<String, dynamic>>(
  (ref) => FormValuesNotifier(),
);

class FormValuesNotifier extends StateNotifier<Map<String, dynamic>> {
  FormValuesNotifier() : super({});

  void updateValue(String key, dynamic value, {bool readonly = false}) {
    state = {
      ...state,
      key: {
        'key': key,
        'value': value,
        'readonly': readonly,
      },
    };
  }

  void update(Map<String, dynamic> Function(Map<String, dynamic>) updater) {
    state = updater(Map.from(state));
  }
}

// Параметры для загрузки опций и эффекта (можно сделать более типобезопасными)
class ActionParams {
  final int applicationId;
  final String name;
  final String? loadOptionsKey;
  final String? actionKey;
  final String actionId;
  final Locale language;

  ActionParams({
    required this.applicationId,
    required this.name,
    this.loadOptionsKey,
    this.actionKey,
    required this.actionId,
    required this.language,
  });
}

// Пример провайдера опций (замените на реальную реализацию)
final actionOptionsProvider = FutureProvider.family<List<Map<String, dynamic>>, ActionParams>(
  (ref, params) async {
    // Здесь ваша реальная логика загрузки опций
    await Future.delayed(const Duration(milliseconds: 700));
    return [
      {'code': 'opt1', 'name': {'ru': 'Вариант 1', 'en': 'Option 1'}},
      {'code': 'opt2', 'name': {'ru': 'Вариант 2', 'en': 'Option 2'}},
      {'code': 'opt3', 'name': {'ru': 'Вариант 3', 'en': 'Option 3'}},
    ];
  },
);

// Пример провайдера эффекта при изменении значения
final actionEffectProvider = FutureProvider.family<void, ActionEffectParams>(
  (ref, params) async {
    // Здесь ваша реальная логика серверного эффекта
    await Future.delayed(const Duration(milliseconds: 1200));

    // Пример обновления других полей
    ref.read(formValuesProvider.notifier).update((state) {
      final newState = Map<String, dynamic>.from(state);

      if (params.value == 'opt2') {
        newState['dependent_field'] = {
          'key': 'dependent_field',
          'value': 'auto_value_123',
          'readonly': true,
        };
      }

      return newState;
    });
  },
);

class ActionEffectParams {
  final String value;
  final String actionId;
  final String actionKey;
  final int applicationId;
  final Locale language;

  ActionEffectParams({
    required this.value,
    required this.actionId,
    required this.actionKey,
    required this.applicationId,
    required this.language,
  });
}

// ──────────────────────────────────────────────────────────────────────────────
// Виджет
// ──────────────────────────────────────────────────────────────────────────────

class ActionSelect extends ConsumerWidget {
  final int applicationId;
  final String name;
  final String label;
  final String? hintText;
  final bool disabled;
  final bool required;
  final String? loadOptionsKey;
  final String? actionKey;
  final String actionId;

  const ActionSelect({
    super.key,
    required this.applicationId,
    required this.name,
    required this.label,
    this.hintText,
    this.disabled = false,
    this.required = false,
    this.loadOptionsKey,
    this.actionKey,
    required this.actionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider); // ← возьмите из вашей системы локализации

    // Текущее значение поля
    final currentValue = ref.watch(
      formValuesProvider.select((state) => state[name]?['value'] as String?),
    );

    final isLoading = ref.watch(actionLoadingProvider(name));

    // Опции
    final optionsAsync = ref.watch(
      actionOptionsProvider(
        ActionParams(
          applicationId: applicationId,
          name: name,
          loadOptionsKey: loadOptionsKey,
          actionKey: actionKey,
          actionId: actionId,
          language: language,
        ),
      ),
    );

    // Реакция на изменение значения нашего поля
    ref.listen<String?>(
      formValuesProvider.select((state) => state[name]?['value'] as String?),
      (previous, next) {
        if (next == previous || next == null || next.isEmpty || actionKey == null) {
          return;
        }

        ref.read(actionLoadingProvider(name).notifier).state = true;

        ref
            .read(
              actionEffectProvider(
                ActionEffectParams(
                  value: next,
                  actionId: actionId,
                  actionKey: actionKey!,
                  applicationId: applicationId,
                  language: language,
                ),
              ).future,
            )
            .then((_) {
          ref.read(actionLoadingProvider(name).notifier).state = false;
        }).catchError((error) {
          ref.read(actionLoadingProvider(name).notifier).state = false;
          // Можно добавить показ ошибки пользователю
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка обновления: $error')),
          );
        });
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label${required ? ' *' : ''}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: currentValue,
          hint: Text(hintText ?? 'Выберите значение...'),
          isExpanded: true,
          isDense: true,
          items: optionsAsync.when(
            data: (options) => options.map((opt) {
              final nameMap = opt['name'] as Map<String, dynamic>?;
              final displayName = nameMap?[language] ?? nameMap?['ru'] ?? '—';

              return DropdownMenuItem<String>(
                value: opt['code'] as String?,
                child: Text(displayName),
              );
            }).toList(),
            loading: () => [],
            error: (_, __) => [],
          ),
          onChanged: (disabled || isLoading)
              ? null
              : (newValue) {
                  if (newValue == null) return;
                  ref.read(formValuesProvider.notifier).updateValue(
                        name,
                        newValue,
                        readonly: false,
                      );
                },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            errorText: required && currentValue == null ? 'Обязательное поле' : null,
          ),
        ),
      ],
    );
  }
}