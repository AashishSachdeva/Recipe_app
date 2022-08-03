import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/Filters';
  final Function setFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.setFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _isVegan;
  late bool _isLactoseFree;
  late bool _isVegetarian;
  late bool _isGlutenFree;
  @override
  void initState() {
    super.initState();
    _isVegan = widget.currentFilters['isVegan'] as bool;
    _isGlutenFree = widget.currentFilters['isGlutenFree'] as bool;
    _isLactoseFree = widget.currentFilters['isLactoseFree'] as bool;
    _isVegetarian = widget.currentFilters['isVegetarian'] as bool;
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    Function(bool) handleSwitch,
    bool value,
  ) {
    return SwitchListTile(
      value: value,
      onChanged: handleSwitch,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'isGlutenFree': _isGlutenFree,
                'isLactoseFree': _isLactoseFree,
                'isVegan': _isVegan,
                'isVegetarian': _isVegetarian,
              };
              widget.setFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selections',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  "Vegan",
                  'Only include vegan meals',
                  (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  },
                  _isVegan,
                ),
                _buildSwitchListTile(
                  "Vegetarian",
                  'Only include vegetarian meals',
                  (newValue) {
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  },
                  _isVegetarian,
                ),
                _buildSwitchListTile(
                  "Gluten-free",
                  'Only include gluten-free meals',
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                  _isGlutenFree,
                ),
                _buildSwitchListTile(
                  "Lactose-free",
                  'Only include lactose-free meals',
                  (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  },
                  _isLactoseFree,
                ),
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
