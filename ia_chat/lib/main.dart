import 'package:flutter/material.dart';
import 'package:ia_chat/provider/chat_provider.dart';
import 'package:ia_chat/repository/chat_repository.dart';
import 'package:ia_chat/screens/home_screen_page.dart';
import 'package:ia_chat/sevice/chat_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatProvider(ChatService(ChatRepository())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iaChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
