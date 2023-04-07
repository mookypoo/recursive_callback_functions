import 'package:flutter/material.dart';
import 'package:recursive_callback/color_button.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({Key? key, required this.review}) : super(key: key);
  final String review;

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (this.widget.review.isNotEmpty) {
      this._controller.text = this.widget.review;
    }
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        appBar: AppBar(title: const Text("Write A Review!"),),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300.0,
                height: 50.0,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: this._controller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    constraints: BoxConstraints(),
                    border: OutlineInputBorder()
                  ),
                ),
              ),

              ColoredTextButton(
                  text: "Submit",
                  onPressed: () async {
                    /// send data to server
                    Navigator.of(context).pop(this._controller.text.trim());
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
