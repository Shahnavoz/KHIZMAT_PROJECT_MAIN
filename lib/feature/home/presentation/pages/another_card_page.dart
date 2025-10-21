import 'package:flutter/material.dart';

class AnotherCardPage extends StatefulWidget {
  const AnotherCardPage({super.key});

  @override
  State<AnotherCardPage> createState() => _AnotherCardPageState();
}

class _AnotherCardPageState extends State<AnotherCardPage> {
  List<String> items = ['Apple', 'Banana', 'Orange'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
      
          return Dismissible(
            key: Key(item), // уникальный ключ обязателен!
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
      
            // 🔹 Обязательно реализуем onDismissed:
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index); // удаляем из списка
              });
      
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$item удалён')));
            },
      
            child: ListTile(title: Text(item)),
          );
        },
      ),
    );
  }

  Widget buildCard(Color color, int index) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 250,
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Card $index",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
