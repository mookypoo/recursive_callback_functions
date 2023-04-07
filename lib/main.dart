import 'package:flutter/material.dart';
import 'package:recursive_callback/color_button.dart';
import 'package:recursive_callback/write_review_page.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColoredTextButton(
          text: "Write a Review",
          onPressed: () async {

            Future<void> _recursive({String review = ""}) async {
              final String _review = await Navigator.of(context).push<String>(MaterialPageRoute(
                  builder: (BuildContext ctx) => WriteReviewPage(review: review)
              )) ?? "";

              if (_review.isEmpty) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Your review has been submitted.",
                  style: TextStyle(fontSize: 16.0 ),), duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: "Modify",
                    onPressed: () async => await _recursive(review: _review),
                  ),
                ),
              );
            }

            await _recursive();

          },
        ),
      ),
    );
  }
}

