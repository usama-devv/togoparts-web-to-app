import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {

  String dropDownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DropdownButton<String>(
        value: dropDownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        style: const TextStyle(color: Colors.white),
        onChanged: (String? newValue) {
          setState(() {
            dropDownValue= newValue!;
          });
        },
        items: const [
          DropdownMenuItem<String>(
            value: "One",
            child: Text("Marketplace"),
          ),
          DropdownMenuItem<String>(
            value: "Two",
            child: Text("Rides"),
          ),
          DropdownMenuItem<String>(
            value: "Three",
            child: Text("Magazines"),
          )
        ],
      ),
    );
  }
}

