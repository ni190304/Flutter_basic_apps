import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sqflite_prac/sql_helper.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> _journals = [];

  bool is_loading = true;

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _journals = data;
      is_loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    print(".. number of items ${_journals.length}");
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _addItem() async {
    await SQLHelper.createItem(_titleController.text, _descController.text);
    _refreshJournals();
    print(".. number of items ${_journals.length}");
  }

  Future<void> _updateItm(int? id) async {
    await SQLHelper.updateItem(
        id!, _titleController.text, _descController.text);
    _refreshJournals();
    print(".. number of items ${_journals.length}");
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descController.text = existingJournal['description'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await _addItem();
                        }
                        if (id != null) {
                          await _updateItm(id);
                        }

                        _titleController.text = '';
                        _descController.text = '';

                        Navigator.pop(context);
                      },
                      child: Text(id == null ? 'Create New' : 'Update'))
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL'),
      ),
      body: ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) => Card(
              color: Colors.orange,
              margin: EdgeInsets.all(15),
              child: ListTile(
                title: Text(_journals[index]['title']),
                subtitle: Text(_journals[index]['description']),
                onTap: () => _showForm(_journals[index]['id']),
              ))),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: () => _showForm(null)),
    );
  }
}
