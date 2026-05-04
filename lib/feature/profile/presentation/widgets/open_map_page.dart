import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';

class OpenMapPage extends StatelessWidget {
  const OpenMapPage({super.key});

  // Целевая локация (замени на свою)
  static var targetLocation = Coords(41.3111, 69.2797); // пример: Ташкент
  static const targetTitle = "Место встречи";
  static const targetDescription = "Кафе в центре города";

  Future<void> showMapSelectionBottomSheet(BuildContext context) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (availableMaps.isEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("На устройстве нет установленных карт")),
        );
        return;
      }

      if (!context.mounted) return;

      // Показываем красивый bottom sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // чтобы можно было сделать выше
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    // Заголовок и полоса
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Выберите карту",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: availableMaps.length,
                        itemBuilder: (context, index) {
                          final map = availableMaps[index];
                          return ListTile(
                            leading:
                                map.icon != null
                                    ? SvgPicture.asset(
                                      map.icon, // это String — путь к .svg
                                      height: 36,
                                      width: 36,
                                      placeholderBuilder:
                                          (context) =>
                                              const Icon(Icons.map, size: 36),
                                    )
                                    : const Icon(Icons.map, size: 36),
                            title: Text(
                              map.mapName,
                              style: const TextStyle(fontSize: 17),
                            ),
                            onTap: () async {
                              Navigator.pop(context);
                              await map.showMarker(
                                coords: targetLocation,
                                title: targetTitle,
                                description: targetDescription,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      debugPrint("Ошибка при работе с картами: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Открыть локацию")),
    );
  }
}
