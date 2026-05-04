import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Инициализация уведомлений — вызывается один раз при запуске приложения
Future<void> initNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ); // стандартная иконка приложения

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  // Инициализируем плагин
  bool? initialized = await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // Обработка нажатия на уведомление
      final String? payload = response.payload;
      if (payload != null) {
        print('Нажато уведомление, открываем файл: $payload');
        // Здесь можно добавить открытие файла: await OpenFilex.open(payload);
      }
    },
  );

  print('Notifications initialized: $initialized');

  // Создаём канал уведомлений (обязательно!)
  await _createNotificationChannel();

  // Запрос разрешения на Android 13+
  if (isAndroid) {
    final androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidPlugin?.requestNotificationsPermission();
  }
}

// Создаём канал с явной важностью (это решает NullPointerException)
Future<void> _createNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'downloads_channel', // id канала
    'Загрузки документов', // название
    description: 'Уведомления о сохранении файлов',
    importance: Importance.max, // ← важно! max/high/default
    playSound: true,
    enableVibration: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
}

// Функция показа уведомления (вызывается после сохранения файла)
Future<void> showDownloadNotification({
  required String title,
  required String body,
  required String filePath, // payload — путь к файлу
}) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'downloads_channel',
    'Загрузки документов',
    channelDescription: 'Уведомления о сохранении файлов',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'Файл сохранён',
    showWhen: true,
    enableVibration: true,
    playSound: true,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  try {
    await flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch % 100000, // уникальный id
      title: title, // 'Файл сохранён'
      body: body,
      payload: filePath, // путь к файлу
    );
  } catch (e) {
    print('Ошибка показа уведомления: $e');
  }
}


bool get isAndroid {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.android;
}

bool get isIOS {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.iOS;
}

// или вообще один флаг
bool get isMobile => !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
