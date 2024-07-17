import 'package:flutter/material.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const MainLayout({required this.child, required this.selectedIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(scaffoldKey: scaffoldKey, selectedIndex: selectedIndex),
      appBar: AppBar(
        title: const Text('Teslo Shop'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: child,
    );
  }
}
