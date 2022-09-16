import 'package:flutter/material.dart';
import 'package:game_scan/widgets/game_scan_scaffold.dart';

class SearchPage extends StatefulWidget {
  static const String route = 'search-page-route';

  // final String title;
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GameScanScaffold(
      scaffoldPage: ScaffoldPage.search,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Search",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => null,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
