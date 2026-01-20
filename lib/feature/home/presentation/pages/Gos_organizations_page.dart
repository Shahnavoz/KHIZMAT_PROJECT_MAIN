import 'package:flutter/material.dart';

class GosOrganizationsPage extends StatefulWidget {
  const GosOrganizationsPage({super.key});

  @override
  State<GosOrganizationsPage> createState() => _GosOrganizationsPageState();
}

class _GosOrganizationsPageState extends State<GosOrganizationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: Icon(Icons.home),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}