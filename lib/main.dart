import 'package:flutter/material.dart';
import 'package:flutter_application/constants/constants.dart';
import 'package:flutter_application/providers/chats_provider.dart';
import 'package:flutter_application/providers/models_provider.dart';
import 'package:flutter_application/screens/chat_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_)=> ModelsProvider(),
        ),
        ChangeNotifierProvider(
            create: (_)=> ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(color: cardColor)
        ),
        home: ChatScreen(),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}