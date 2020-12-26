import 'package:my_second_flutter_app/components/sidebar_row.dart';
import 'package:my_second_flutter_app/model/sidebar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: SidebarRow(item: sidebarItem[3])
            )
        )
    );
  }
}