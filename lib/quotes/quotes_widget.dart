import 'package:flutter/material.dart';
import 'package:ts_5_4_5_zitate_app/quotes/model/quotes_model.dart';
import 'package:ts_5_4_5_zitate_app/theme/const_theme.dart';

class QuotesWidget extends StatelessWidget {
  final QuotesModel quote;
  const QuotesWidget({
    super.key,
    required this.quote,
  });

  Row formatText({required String label, required String data}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Text(
                data,
                softWrap: true,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formatText(label: "Category", data: quote.category),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              quote.quote,
              overflow: TextOverflow.ellipsis,
              maxLines: 7,
              style: const TextStyle(
                  fontFamily: fontFamilyBeautyMountains, fontSize: 30),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
            child: Text(
              "- ${quote.author}",
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ),

        // Container(
        //     decoration: BoxDecoration(color: Colors.grey.withOpacity(0.15)),
        //     child: formatText(label: "Quote", data: quote.quote)),
      ],
    );
  }
}
