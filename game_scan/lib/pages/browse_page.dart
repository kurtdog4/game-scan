import 'package:flutter/material.dart';
import 'package:game_scan/widgets/game_scan_scaffold.dart';

class BrowsePage extends StatefulWidget {
  static const String route = 'browse-page-route';

  const BrowsePage({Key? key}) : super(key: key);

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: scaffoldHeroTag,
      child: GameScanScaffold(
        scaffoldPage: ScaffoldPage.browse,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Browse",
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
      ),
    );
  }
}
