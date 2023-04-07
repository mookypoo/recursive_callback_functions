import 'package:flutter/material.dart';

class ColoredTextButton extends StatelessWidget {
  const ColoredTextButton({Key? key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.fontSize,
    this.padding,
    this.enabledColor = Colors.indigoAccent
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final bool enabled;
  final double? fontSize;
  final EdgeInsets? padding;
  final Color enabledColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: this.enabled ? this.enabledColor : Colors.grey,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.65),
          borderRadius: BorderRadius.circular(5.0),
          onTap: this.enabled ? this.onPressed : null,
          child: Container(
            padding: this.padding ?? const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
            child: Text(this.text,
              style: TextStyle(color: Colors.white, fontSize: this.fontSize ?? 15.0, fontWeight: FontWeight.w500,),
            ),
            //height: 40.0,
          ),
        ),
      ),
    );
  }
}