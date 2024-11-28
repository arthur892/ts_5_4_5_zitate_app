import 'package:flutter/material.dart';
import 'package:ts_5_4_5_zitate_app/quotes/model/quotes_model.dart';

class QuotesWidget extends StatelessWidget {
  final QuotesModel quote;
  const QuotesWidget({
    super.key,
    required this.quote,
  });

  Row formatText({required String label, required String data}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            data,
            softWrap: true,
            //maxLines: 5,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formatText(label: "Author", data: quote.author),
        formatText(label: "Category", data: quote.category),
        formatText(label: "Quote", data: quote.quote)
      ],
    );
  }
}
