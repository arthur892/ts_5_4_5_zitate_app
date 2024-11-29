import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:ts_5_4_5_zitate_app/quotes/data/quotes_repo.dart';
import 'package:ts_5_4_5_zitate_app/quotes/enum_quote_categorys.dart';
import 'package:ts_5_4_5_zitate_app/quotes/quotes_widget.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  QuotesRepo quotes = QuotesRepo();
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController categorysController = TextEditingController();
  QuoteCategorys? selectedCategory = QuoteCategorys.all;

  //final SharedPreferencesAsync savedData = SharedPreferencesAsync();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            child: FutureBuilder(
                future: quotes.loadQuote(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    dev.log('Error: ${snapshot.error}');
                    return const Center(
                        child: Text(
                      'Noch keine Zitate geladen!',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('NoData'));
                  }
                  return QuotesWidget(
                    quote: snapshot.data!,
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(
                width: 200,
                menuHeight: 400,
                initialSelection: QuoteCategorys.all,
                onSelected: (QuoteCategorys? category) {
                  selectedCategory = category;
                },
                dropdownMenuEntries:
                    QuoteCategorys.values.map((QuoteCategorys category) {
                  return DropdownMenuEntry<QuoteCategorys>(
                    value: category, // Das Enum als Wert
                    label: category.label, // Label aus der Enum-Instanz
                  );
                }).toList(), // Map liefert Iterable, also in eine Liste umwandeln
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await quotes.getQuoteAPI(selectedCategory!);
                      setState(() {});
                    } catch (e) {
                      final String errorText = 'Failed fetch $selectedCategory';
                      dev.log(errorText);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 8),
                          content: Text("$errorText\n$e",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.error))));
                      dev.log('$e');
                    }
                  },
                  child: const Text("Load form API")),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                await quotes.deleteQuote();
                setState(() {});
              },
              child: const Text("Delete from SharedPref"))
        ],
      ),
    );
  }
}
