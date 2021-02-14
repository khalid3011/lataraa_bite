import 'package:movie_house/export/export.dart';
import 'package:movie_house/screen/account/account_screen.dart';

import 'tab/home/home_tab.dart';
import 'tab/movie/movie_tab.dart';
import 'tab/tv/tv_tab.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _pages = [
    HomeTab(),
    MovieTab(),
    TvTab(),
    AccountScreen(),
  ];

  int _selectedIndex = 0;

  _onTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[..._pages],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[300],
        type: BottomNavigationBarType.fixed,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Movie",
            icon: Icon(Icons.movie),
          ),
          BottomNavigationBarItem(
            label: "Tv",
            icon: Icon(Icons.tv),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
