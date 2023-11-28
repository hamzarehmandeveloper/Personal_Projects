import 'package:flutter/material.dart';
import '../usersMode/screens/service_finder_services.dart';
import '../usersMode/screens/home_screen/home.dart';
import '../usersMode/screens/profile_screen/profile_screen.dart';
import '../usersMode/screens/select_service.dart';
import '../usersMode/screens/work_description_screen.dart';

class TabContainer extends StatefulWidget {
  const TabContainer({Key? key}) : super(key: key);

  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  late List<Widget> originalList;
  late Map<int, bool> originalDic;
  late List<Widget> listScreens;
  late List<int> listScreensIndex;

  int tabIndex = 0;
  Color tabColor = const Color(0xff94959b);
  Color selectedTabColor = Colors.black;

  @override
  void initState() {
    super.initState();
    originalList = [
      const HomePage(),
      const SelectService(),
      SubmitWorkScreen(),
      ServiceFinderServices(),
      ProfileScreen(),
    ];
    originalDic = {0: true, 1: false, 2: false, 3: false, 4: false};
    listScreens = [originalList.first];
    listScreensIndex = [0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: listScreensIndex.indexOf(tabIndex), children: listScreens),
      bottomNavigationBar: _buildTabBar(),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _selectedTab(int index) {
    if (originalDic[index] == false) {
      listScreensIndex.add(index);
      originalDic[index] = true;
      listScreensIndex.sort();
      listScreens = listScreensIndex.map((index) {
        return originalList[index];
      }).toList();
    }

    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    var listItems = [
      BottomAppBarItem(iconData: Icons.home, text: 'Home'),
      BottomAppBarItem(iconData: Icons.category_rounded, text: 'Categories'),
      BottomAppBarItem(iconData: Icons.add_circle, text: 'Post Job'),
      BottomAppBarItem(iconData: Icons.my_library_books, text: 'My Services'),
      BottomAppBarItem(iconData: Icons.person, text: 'Profile'),
    ];

    var items = List.generate(listItems.length, (int index) {
      return _buildTabItem(
        item: listItems[index],
        index: index,
        onPressed: _selectedTab,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    var color = tabIndex == index ? selectedTabColor : tabColor;
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: 24),
                Text(
                  item.text,
                  style: TextStyle(color: color, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({required this.iconData, required this.text});

  IconData iconData;
  String text;
}
