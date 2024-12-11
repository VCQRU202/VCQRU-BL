import 'package:flutter/material.dart';


class OptionRadio extends StatefulWidget {
  String? text = "";
  int? index;
  int? selectedButton;
  Function press;

  OptionRadio({super.key,required this.text,this.index,required this.press,this.selectedButton});
  @override
  _OptionRadioState createState() => _OptionRadioState();
}

class _OptionRadioState extends State<OptionRadio> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.press(widget.index);
      },
      child: Container(
        child: Container(
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.grey,
              disabledColor: Colors.blue,
            ),
            child: RadioListTile(
              title: Text(
                "${widget.text}",
                style: TextStyle(color: Colors.black, fontSize: 11),
                softWrap: false,
              ),
              groupValue: widget.selectedButton,
              value: widget.index,
              activeColor: Colors.red,
              onChanged: (val) {
                widget.press(widget.index);
              },
              toggleable: true,
            ),
          ),
        ),
      ),
    );
  }
}
