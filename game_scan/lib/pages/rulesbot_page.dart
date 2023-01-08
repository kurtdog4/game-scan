import 'package:flutter/material.dart';
import 'package:game_scan/widgets/game_scan_scaffold.dart';

class RulesbotPage extends StatefulWidget {
  static const String route = 'rulesbot';

  const RulesbotPage({Key? key}) : super(key: key);

  @override
  State<RulesbotPage> createState() => _RulesbotPageState();
}

class _RulesbotPageState extends State<RulesbotPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: scaffoldHeroTag,
      child: GameScanScaffold(
        scaffoldPage: ScaffoldPage.rulesbot,
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
      ),
    );
  }
}
