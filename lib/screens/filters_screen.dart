import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {

  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;


  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }


  Widget _buildSwitchListTile(String title, String description, bool currentValue, updateValue){
    return  SwitchListTile(title: Text(title),
      value:currentValue ,
      subtitle: Text(description),
      onChanged: updateValue);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Filters',
        ),
        actions: [
          IconButton(onPressed: () {
            final selectedFilter = {
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            };
            widget.saveFilters(selectedFilter);
          }, icon: Icon(Icons.save))
        ],

      ),
      drawer: MainDrawer(),
      body:Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(child: 
          ListView(
            children: [
             _buildSwitchListTile('Gluten-free', 'Only include gluten-free meals', _glutenFree, (newValue) {
               setState(() {
                 _glutenFree=newValue;
               });
             } ),
             _buildSwitchListTile('Lactose-free', 'Only include lactose-free meals', _lactoseFree, (newValue) {
               setState(() {
                 _lactoseFree=newValue;
               });
             } ),
             _buildSwitchListTile('Vegetarian', 'Only include vegetarian meals', _vegetarian, (newValue) {
               setState(() {
                 _vegetarian=newValue;
               });
             } ),
             _buildSwitchListTile('Vegan', 'Only include vegan meals', _vegan, (newValue) {
               setState(() {
                 _vegan=newValue;
               });
             } ),

            ],
          )
          
          )
        ],
      )
    );
  }
}
