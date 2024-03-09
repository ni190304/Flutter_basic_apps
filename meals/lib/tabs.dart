import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Drawer.dart';
import 'package:meals/categories.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/filt.dart';
import 'package:meals/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/provider/mealprov.dart';
import 'package:riverpod/riverpod.dart';
import 'package:meals/provider/fav_prov.dart';

const kInitFilt = {
    Filter.glutenFreeset : false,
    Filter.lactoseFreeset : false,
    Filter.veget : false,
    Filter.vegan : false,

  };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedIndex = 0;
  
  Map<Filter,bool> _selfilt = kInitFilt;


  

  void _selectpage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _selScr(String iden) async{
    if(iden == 'filters'){
      Navigator.pop(context);
      final result = await Navigator.push<Map<Filter,bool>>(context, MaterialPageRoute(builder: (ctx)=> FilterScreen(currentFilter: _selfilt,)));

      setState(() {
        _selfilt = result ?? kInitFilt ;
      });

      

      // print(result);

    }
    else{
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealprovider);
    final availMeals = meals.where((meal) {
      if(_selfilt[Filter.glutenFreeset]! && !meal.isGlutenfree){
        return false;
      }
      if(_selfilt[Filter.lactoseFreeset]! && !meal.isLactosefree){
        return false;
      }
      if(_selfilt[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      if(_selfilt[Filter.veget]! && !meal.isVegetarian){
        return false;
      }

      return true;

    }).toList();
    
    Widget active_page = CategoriesScreen(availMeals: availMeals);
    var activepagetitle = 'Categories';

    if (selectedIndex == 1){
      final favmeals = ref.watch(favprovider);
      active_page = MealsScreen(meals: favmeals,);
      activepagetitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer:  MainDrawer(onSelScr: _selScr,),
      body: active_page,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_purple500_sharp), label: 'Favorites')
        ],
      ),
    );
  }
}
