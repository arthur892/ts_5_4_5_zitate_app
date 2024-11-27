import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ts_5_4_5_zitate_app/auth/api_keys.dart';
import 'package:ts_5_4_5_zitate_app/quotes/model/quotes_model.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    super.initState();
    //quote = getQuote();
  }

  Future<QuotesModel> getQuote() async {
    Map<String, String> queryheaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Api-Key': api_quote
    };

    //https://api.api-ninjas.com/v1/quotes?category=best

    final Uri uri = Uri.https('api.api-ninjas.com', '/v1/quotes');
    final http.Response response = await http.get(uri, headers: queryheaders);

    //Response
    /*
[
{
...
},
  {
    "quote": "Knowledge is power. Information is liberating. Education is the premise of progress, in every society, in every family.",
    "author": "Kofi Annan",
    "category": "knowledge"
  }
]
*/

    if (response.statusCode == 200) {
      //Json decoden
      final List<dynamic> decodedJson = jsonDecode(response.body);
      log("Fetch data: $decodedJson");
      log(decodedJson[0]["category"]);
      final quote = QuotesModel.fromJson(decodedJson[0]);
      return quote;
    }
    throw TimeoutException("Status Code != 200");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: getQuote(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('NoData'));
                }
                return Text(snapshot.data!.author);
              }),
          ElevatedButton(onPressed: getQuote, child: const Text("Laden"))
        ],
      ),
    );
  }
}
