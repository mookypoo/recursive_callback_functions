import 'package:flutter/material.dart';
import 'package:recursive_callback/api_service.dart';
import 'package:recursive_callback/color_button.dart';

import 'main.dart' show navigatorKey;

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({Key? key, required this.review, this.isRecursive = true}) : super(key: key);
  final String review;
  final bool isRecursive;

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final TextEditingController _controller = TextEditingController();
  /// this would usually be in provider, but it is in view for this concise example
  final APIService _service = APIService();

  @override
  void initState() {
    super.initState();
    if (this.widget.review.isNotEmpty) this._controller.text = this.widget.review;
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
        appBar: AppBar(title: const Text("Write A Review! - Recursive Function"),),
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

              this.widget.isRecursive
                ? ColoredTextButton(
                    text: "Submit",
                    onPressed: () async {
                      /// send data to server
                      Navigator.of(context).pop(this._controller.text.trim());
                    }
                  )
                : ColoredTextButton(
                  text: "Submit",
                  onPressed: () async {
                    final BuildContext? _appContext = navigatorKey.currentContext;
                    if (_appContext == null) return;
                    await _service.postToServer(
                        path: "/review",
                        accessToken: "",
                        body: {"review": this._controller.text.trim()},
                        errorCb: (String errorMsg) async {
                          await showDialog(
                            /// if you use context of this WriteReviewPage, because the page already got disposed, an error occurs
                              context: _appContext,
                              builder: (_) => Dialog(child: Text(errorMsg))
                          );
                        },
                        successCb: (String successMsg) async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(successMsg,
                              style: const TextStyle(fontSize: 16.0 ),), duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                    );
                    print("popped");
                    Navigator.of(context).pop();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
