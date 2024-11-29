import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts_5_4_5_zitate_app/auth/api_keys.dart';
import 'package:ts_5_4_5_zitate_app/quotes/model/enum_quote_categorys.dart';
import 'package:ts_5_4_5_zitate_app/quotes/model/quotes_model.dart';

class QuotesRepo {
  final SharedPreferencesAsync savedData = SharedPreferencesAsync();
  final keyquote = "quote";

  void saveQuote(QuotesModel quote) async {
    try {
      await savedData.setStringList(keyquote, quote.toSharedPref());
    } catch (e) {
      throw Exception("QuoteRepo.saveQuote ${e.toString()}");
    } finally {}
  }

  Future<QuotesModel> loadQuote() async {
    try {
      final quoteAsList = await savedData.getStringList(keyquote);

      return QuotesModel.fromSharedPref(quoteAsList!);
    } catch (e) {
      throw Exception("QuoteRepo.loadQoute ${e.toString()}");
    }
  }

  Future<void> deleteQuote() async {
    try {
      await savedData.remove(keyquote);
    } catch (e) {
      dev.log("QuoteRepo.deleteQuote ${e.toString()}");
    }
  }

  Future<QuotesModel> getQuoteAPI(QuoteCategorys category) async {
    Map<String, String> queryheaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Api-Key': api_quote
    };

    Map<String, dynamic> queryParameters;
    final Uri uri;

    //https://api.api-ninjas.com/v1/quotes?category=best

    //Request Category
    //If all is seleceted, the query has to be empty
    dev.log('Category selected: $category');
    if (category == QuoteCategorys.all) {
      uri = Uri.https('api.api-ninjas.com', '/v1/quotes');
    } else {
      queryParameters = {'category': category.label};
      uri = Uri.https('api.api-ninjas.com', '/v1/quotes', queryParameters);
    }

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

    try {
      if (response.statusCode == 200) {
        //Json decoden
        final List<dynamic> decodedJson = jsonDecode(response.body);
        dev.log("Fetch data: $decodedJson");

        final quote = QuotesModel.fromJson(decodedJson[0]);
        saveQuote(quote);
        await Future.delayed(const Duration(milliseconds: 100));
        return quote;
      } else {
        throw Exception('Failed with code ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('ClientException: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('FormatException: ${e.message}');
    } catch (e) {
      throw Exception('QuoteRepo.getQuoteAPI: $e');
    }
  }
}
