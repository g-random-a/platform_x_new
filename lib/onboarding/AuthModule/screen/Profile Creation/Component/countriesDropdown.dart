import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/onboarding/AuthModule/miscellaneous/countries.dart';

class CountryDropdown extends StatefulWidget {

  final Map<String, dynamic> dataMap;

  const CountryDropdown({super.key, required this.dataMap});


  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {

  String selectedCountryCode = 'ET';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: selectedCountryCode,
            icon: const Icon(Icons.arrow_downward),
            decoration: const InputDecoration(
              labelText: 'Country',
              border: OutlineInputBorder(),
            ),
            isExpanded: true,
            items: countries.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black),),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCountryCode = newValue!;
              });
              widget.dataMap['country'] = newValue;
            },
          ),
        ],
      ),
    );
  }
}
