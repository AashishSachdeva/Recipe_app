import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

// class TabBarScreen extends StatefulWidget {
//   @override
//   _TabBarScreenState createState() => _TabBarScreenState();
// }

// class _TabBarScreenState extends State<TabBarScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         initialIndex: 0,
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text("Meals"),
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.category),
//                   text: 'Categories',
//                 ),
//                 Tab(
//                   icon: Icon(Icons.star),
//                   text: 'Favorites',
//                 )
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [CategoriesScreen(), FavoritesScreen()],
//           ),
//         ));
//   }
// }to add navigation Bar at Top

class TabBarScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabBarScreen(this.favoriteMeals);
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<Map<String, Object>> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
  }

  int _selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _selectPage,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            label: 'Favorites',
            icon: Icon(Icons.star),
          )
        ],
      ),
    );
  }
}
