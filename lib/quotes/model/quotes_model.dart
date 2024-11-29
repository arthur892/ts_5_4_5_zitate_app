class QuotesModel {
  final String quote;
  final String author;
  final String category;

  QuotesModel(
      {required this.quote, required this.author, required this.category});

  factory QuotesModel.fromJson(Map<String, dynamic> json) {
    final quote = json['quote'] as String;
    final author = json['author'] as String;
    final category = json['category'] as String;
    return QuotesModel(quote: quote, author: author, category: category);
  }

  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'author': author,
      'category': category,
    };
  }

  List<String> toSharedPref() {
    return [quote, author, category];
  }

  factory QuotesModel.fromSharedPref(List<String> data) {
    return QuotesModel(quote: data[0], author: data[1], category: data[2]);
  }
}
