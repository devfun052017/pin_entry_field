library pin_entry_field;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pin_entry_style.dart';

// ignore: must_be_immutable
class PinEntryField extends StatefulWidget {
  final double height;
  final double fieldWidth;
  final int fieldCount;
  final PinEntryStyle fieldStyle;
  final ValueChanged<String> onSubmit;

  PinEntryField({
    this.height = 50,
    this.fieldWidth = 50,
    this.fieldCount = 4,
    this.fieldStyle,
    this.onSubmit,
  });

  @override
  State<StatefulWidget> createState() => _PinEntryFieldState();
}

class _PinEntryFieldState extends State<PinEntryField> {
  FocusNode _focusNode;
  List<String> textChanged;
  bool ending = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textChanged = [];
    for (var i = 0; i < widget.fieldCount; i++) {
      textChanged.add("");
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();
    super.dispose();
  }

  _PinEntryFieldState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildBody(context),
        ),
        Opacity(
          child: TextField(
            textInputAction: TextInputAction.done,
            maxLength: widget.fieldCount,
            autofocus: true,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            onSubmitted: (text) {
              print(text);
            },
            onChanged: (text) {
              if (ending && text.length == widget.fieldCount) {
                return;
              }
              _bindTextIntoWidget(text);
              setState(() {});
              ending = text.length == widget.fieldCount;
              if (ending) {
                widget.onSubmit(text);
              }
            },
          ),
          opacity: 0.0,
        )
      ]),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    var tmp = <Widget>[];
    for (var i = 0; i < widget.fieldCount; i++) {
      tmp.add(_buildFieldInput(context, i));
      if (i < widget.fieldCount - 1) {
        tmp.add(SizedBox(
          width: widget.fieldStyle.fieldPadding,
        ));
      }
    }
    return tmp;
  }

  Widget _buildFieldInput(BuildContext context, int i) {
    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        width: widget.fieldWidth,
        alignment: Alignment.center,
        child: Text(
          textChanged[i],
          style: widget.fieldStyle.textStyle,
        ),
        decoration: BoxDecoration(
          color: widget.fieldStyle.fieldBackgroundColor,
          border: widget.fieldStyle.fieldBorder,
          borderRadius: widget.fieldStyle.fieldBorderRadius,
        ),
      ),
    );
  }

  void _bindTextIntoWidget(String text) {
    ///Reset value
    for (var i = text.length; i < textChanged.length; i++) {
      textChanged[i] = "";
    }
    if (text.isNotEmpty) {
      for (var i = 0; i < text.length; i++) {
        textChanged[i] = text[i];
      }
    }
  }
}

