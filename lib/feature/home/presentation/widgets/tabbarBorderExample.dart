import 'package:flutter/material.dart';

class GradientTabBarExample extends StatefulWidget {
  @override
  _GradientTabBarExampleState createState() => _GradientTabBarExampleState();
}

class _GradientTabBarExampleState extends State<GradientTabBarExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = ['Уведомления', 'Заявления', 'Документы'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(tabs.length, (index) {
            final selected = _tabController.index == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _tabController.index = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: selected
                      ? LinearGradient(
                          colors: [Colors.amber, Colors.red],
                        )
                      : null,
                  border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey,
                    width: 2,
                  ),
                  color: selected ? null : Colors.blueGrey[700],
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text('Уведомления контент')),
              Center(child: Text('Заявления контент')),
              Center(child: Text('Документы контент')),
            ],
          ),
        ),
      ],
    );
  }
}
