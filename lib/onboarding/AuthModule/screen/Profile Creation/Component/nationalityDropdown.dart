import 'package:flutter/material.dart';

import '../../../miscellaneous/nationalities.dart';

class NationalityDropdown extends StatefulWidget {
  final Map<String, dynamic> dataMap;
  
  const NationalityDropdown({super.key, required this.dataMap});

  @override
  _NationalityDropdownState createState() => _NationalityDropdownState();
}

class _NationalityDropdownState extends State<NationalityDropdown> {

  String selectedNationality = 'Ethiopia';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField<String>(
            value: selectedNationality,
            icon: const Icon(Icons.arrow_downward),
            decoration: const InputDecoration(
              labelText: 'Nationality',
              border: OutlineInputBorder(),
            ),
            isExpanded: true,
            items: nationalities.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value, overflow: TextOverflow.ellipsis, style:TextStyle(color: Colors.black),),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedNationality = newValue!;
              });
              widget.dataMap['nationality'] = newValue;
            },
          ),
        ],
      ),
    );
  }
}