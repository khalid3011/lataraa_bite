import 'package:movie_house/export/export.dart';

import 'search_result.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TabController _tabsController;

  final List<String> tabs = [
    "multi",
    "Movie",
    "Tv",
    "People",
    "company",
    "keyword",
    "collection",
  ];

  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "search here...",
              hintStyle: TextStyle(color: Colors.white),
            ),
            onSubmitted: (String str) {
              setState(() {
                text = str;
              });
            }),
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: ColorPalette.primary,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: ColorPalette.primary,
              bottom: TabBar(
                controller: _tabsController,
                indicatorColor: ColorPalette.secondary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: ColorPalette.title,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: tabs.map((String tab) {
                  return Container(
                    padding: EdgeInsets.only(
                      bottom: 15.0,
                      top: 10.0,
                    ),
                    child: Text(
                      tab.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(.5),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabsController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SearchResult(query: text, section: 0),
              SearchResult(query: text, section: 1),
              SearchResult(query: text, section: 2),
              SearchResult(query: text, section: 3),
              SearchResult(query: text, section: 4),
              SearchResult(query: text, section: 5),
              SearchResult(query: text, section: 6),
            ],
          ),
        ),
      ),
    );
  }
}
