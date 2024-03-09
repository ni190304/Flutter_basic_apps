import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopp/categories.dart';
import 'package:shopp/grocery.dart';
import 'package:shopp/new_item.dart';
import 'package:http/http.dart' as http;

class Grocery_list extends StatefulWidget {
  const Grocery_list({super.key});

  @override
  State<Grocery_list> createState() => _Grocery_listState();
}

class _Grocery_listState extends State<Grocery_list> {
  List<GroceryItem> groceryItems = [];

  var _isLoading = true;
  String ? error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'udemyshoppp-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);

    if(response.statusCode >= 400){
      setState(() {
        error = "Couldn't fetch data. Please try again later";
      });

    if(response.body == 'null'){
      setState(() {
      _isLoading = false;
      });
      return;
    }
      
    }
    final Map<String, dynamic> ListData = jsonDecode(response.body);

    final List<GroceryItem> _loadedItems = [];

    for (final item in ListData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      _loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }

    setState(() {
      groceryItems = _loadedItems;
      _isLoading = false;
    });
    // print(response.body);
  }

  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem>(
        context, MaterialPageRoute(builder: (ctx) => NewItem()));

    if(newItem == null){
      return;
    }
    
    setState(() {
      groceryItems.add(newItem);
    });

    // _loadItems();

    // if (newItem == null) {
    //   return null;
    // }

    
  }

  void _removeItem(GroceryItem item) async{
    final index = groceryItems.indexOf(item);
    setState(() {
      groceryItems.remove(item);
    });

    final url = Uri.https(
          'udemyshoppp-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if(response.statusCode >= 400){
      setState(() {
        groceryItems.insert(index,item);
      
    });

    }

    
    
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet. '));

    if(error != null){
      content = Center(child: Text(error!));
    }

    if(_isLoading){
      content = const Center(child: CircularProgressIndicator());
    }

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  _removeItem(groceryItems[index]);
                },
                key: ValueKey(groceryItems[index].id),
                child: ListTile(
                  title: Text(groceryItems[index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: groceryItems[index].category.color,
                  ),
                  trailing: Text(groceryItems[index].quantity.toString()),
                ),
              ));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
