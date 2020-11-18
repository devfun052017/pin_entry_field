library pin_entry_field;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_field/pin_input_type.dart';

import 'pin_entry_style.dart';

// ignore: must_be_immutable
class PinEntryField extends StatefulWidget {
  final double height;
  final double fieldWidth;
  final int fieldCount;
  final PinEntryStyle fieldStyle;
  final ValueChanged<String> onSubmit;
  final PinInputType inputType;
  final String pinInputCustom;

  PinEntryField({
    this.height = 50,
    this.fieldWidth = 50,
    this.fieldCount = 4,
    @required this.fieldStyle,
    this.inputType = PinInputType.none,
    this.pinInputCustom = "*",
    this.onSubmit,
  });

  @override
  State<StatefulWidget> createState() => _PinEntryFieldState();
}

class _PinEntryFieldState extends State<PinEntryField> {
  FocusNode _focusNode;
  List<String> pinsInputed;
  bool ending = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    pinsInputed = [];
    for (var i = 0; i < widget.fieldCount; i++) {
      pinsInputed.add("");
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
          _getPinDisplay(i),
          style: widget.fieldStyle.textStyle,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: widget.fieldStyle.fieldBackgroundColor,
          border: widget.fieldStyle.fieldBorder,
          borderRadius: widget.fieldStyle.fieldBorderRadius,
        ),
      ),
    );
  }

  String _getPinDisplay(int position) {
    var display = "";
    var value = pinsInputed[position];
    switch (widget.inputType) {
      case PinInputType.password:
        display = "*";
        break;
      case PinInputType.custom:
        display = widget.pinInputCustom;
        break;
      default:
        display = value;
        break;
    }
    return value.isNotEmpty ? display : value;
  }

  void _bindTextIntoWidget(String text) {
    ///Reset value
    for (var i = text.length; i < pinsInputed.length; i++) {
      pinsInputed[i] = "";
    }
    if (text.isNotEmpty) {
      for (var i = 0; i < text.length; i++) {
        pinsInputed[i] = text[i];
      }
    }
  }
}
