import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('iaChat')),
      drawer: _buildDrawer(),
      body: _buildBody(provider),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: Text('Opção 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Opção 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBody(HomeProvider provider) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Text(provider.responseMessage, style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
        _buildTextInput(provider),
      ],
    );
  }

  Widget _buildTextInput(HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite sua mensagem...',
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: provider.sendMessage,
          ),
        ],
      ),
    );
  }
}
