import 'package:flutter/material.dart';
import 'package:meals/Drawer.dart';
import 'package:meals/tabs.dart';

enum Filter {
  glutenFreeset,
  lactoseFreeset,
  veget,
  vegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key,required this.currentFilter});

  final Map<Filter,bool> currentFilter ;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  var _glutenFreeset = false;
  var _lactoseFreeset = false;
  var veget = false;
  var vegan = false;

  @override
  void initState() {

    super.initState();
    _glutenFreeset = widget.currentFilter[Filter.glutenFreeset]!;
    _lactoseFreeset = widget.currentFilter[Filter.lactoseFreeset]!;
    vegan = widget.currentFilter[Filter.vegan]!;
    veget = widget.currentFilter[Filter.veget]!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(onSelScr: (iden){
        Navigator.pop(context);
        if(iden == 'meals'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> TabsScreen()));
        }
      }),
      body: WillPopScope(
        onWillPop:  () async{
          Navigator.of(context).pop({
            Filter.glutenFreeset: _glutenFreeset,
            Filter.lactoseFreeset : _lactoseFreeset,
            Filter.veget : veget,
            Filter.vegan : vegan,

          });

          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeset,
              onChanged: (isChecked){
                setState(() {
                  _glutenFreeset = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20,right: 30),
            ),
      
            SwitchListTile(
              value: _lactoseFreeset,
              onChanged: (isChecked){
                setState(() {
                  _lactoseFreeset = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20,right: 30),
            ),
      
            SwitchListTile(
              value: veget,
              onChanged: (isChecked){
                setState(() {
                  veget = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Vegetarian meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20,right: 30),
            ),
      
            SwitchListTile(
              value: vegan,
              onChanged: (isChecked){
                setState(() {
                  vegan = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Vegan meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20,right: 30),
            ),
      
      
          ],
        ),
      ),
    );
  }
}
