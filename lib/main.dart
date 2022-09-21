import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/router/route_manager.dart';

import 'providers/cars_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CarsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Sqlite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: RouteNames.root,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
