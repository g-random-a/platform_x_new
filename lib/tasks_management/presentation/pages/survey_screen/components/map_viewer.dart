import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class MapInputField extends StatefulWidget {
  final String questionId;
  final int inputId;
  final LocationPropertySchema properties;
  final LocationInputValidationSchema validations;

  const MapInputField({
    super.key,
    required this.questionId,
    required this.inputId,
    required this.properties,
    required this.validations,
  });

  @override
  State<MapInputField> createState() => _MapInputFieldState();
}

class _MapInputFieldState extends State<MapInputField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LatLng? _selectedLocation;
  final TextEditingController _controller = TextEditingController();

  void _initFromLocal() {
    final ValueAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context)
            .state
            .answers['${widget.questionId}_${widget.inputId}']
        as ValueAnswer?;
    
    print("********************************************");
    print(answer);
    print("********************************************");

    print("********************************************");
    print(BlocProvider.of<CurrentAnswerBloc>(context)
            .state.answers);
    print("********************************************");

    if (answer != null) {
      final coords = answer.value.split(',');
      setState(() {
        _selectedLocation =
            LatLng(double.parse(coords[0]), double.parse(coords[1]));
        _controller.text = _convertToDMS(_selectedLocation!.latitude, _selectedLocation!.longitude);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.properties.defaultValue != null){
      final coords = widget.properties.defaultValue!.split(',');
      _selectedLocation = LatLng(double.parse(coords[0]), double.parse(coords[1]));
    }
    if (widget.properties.placeholder != null){
      final coords = widget.properties.placeholder!.split(',');
      _selectedLocation = LatLng(double.parse(coords[0]), double.parse(coords[1]));
    }
    _initFromLocal();
  }

  void _updateLocation(LatLng point) {
    setState(() {
      _selectedLocation = point;
      String dmsString = _convertToDMS(point.latitude, point.longitude);
      _controller.text = dmsString;
      BlocProvider.of<CurrentAnswerBloc>(context).add(
        UpdateCurrentAnswerEvent(
          answer: ValueAnswer(value: '${point.latitude}, ${point.longitude}', id: widget.inputId),
          questionId: widget.questionId,
        ),
      );
    });
  }

  String _decimalToDMS(double decimal, {required bool isLatitude}) {
    final degrees = decimal.abs().floor();
    final minutes = ((decimal.abs() - degrees) * 60).floor();
    final seconds = (((decimal.abs() - degrees) * 60 - minutes) * 60).toStringAsFixed(2);

    final direction = isLatitude
        ? (decimal >= 0 ? 'N' : 'S')
        : (decimal >= 0 ? 'E' : 'W');

    return "$degreesº $minutes' $seconds\" $direction";
  }

  String _convertToDMS(double latitude, double longitude) {
    String latDMS = _decimalToDMS(latitude, isLatitude: true);
    String lonDMS = _decimalToDMS(longitude, isLatitude: false);
    return "$latDMS and $lonDMS";
  }

  String? validateText(String? value) {
    if (widget.validations.required && (_controller.text.isEmpty)) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          
          // Map with Shaded Top
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
              ),
            ),
            child: Stack(
              children: [
                // Flutter Map
                Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    // border: Border.all(
                    //     color:
                    //         context.watch<ThemeBloc>().state.appColorTheme.black90002),
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: _selectedLocation ?? LatLng(37.7749, -122.4194),
                      initialZoom: 13.0,
                      onTap: (tapPosition, point) => _updateLocation(point),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      if (_selectedLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _selectedLocation!,
                              width: 40.0,
                              height: 40.0,
                              child: Icon(
                                Icons.location_pin,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                // Shaded Top Gradient
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60.h, // Height of the shade
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white, // Transparent towards bottom
                          Colors.white.withOpacity(0.7), // Dark at the top
                          Colors.white.withOpacity(0), // Dark at the top
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60.h, // Height of the shade
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1,
                        colors: [
                           Colors.white, // Transparent towards bottom
                          Colors.white.withOpacity(0), // D// Dark at the top
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 19.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.h),
            child: Text("Confirm location", 
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                fontSize: 10.38.fSize,
                // height: 13.08 / 10.38,
                color: context.watch<ThemeBloc>().state.appColorTheme.black90002,
            
              )
            ),
          ),
          SizedBox(height: 8.h),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.h),
            child: TextFormField(
              controller: _controller,
              validator: validateText,
              readOnly: true,
              // decoration: InputDecoration(
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
              //   ),
              //   hintText: "Tap on the map to select location",
              // ),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 40 / 15,
                decorationColor: const Color(0xff110505), // Optional underline color
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 1.0,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
                ),
                hintText: "Tap on the map to select location",
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 18.9 / 15,
                  color: Colors.grey,
                ),
                suffix: Icon(
                  Iconsax.location,
                  size: 22.fSize,
                  color: context.watch<ThemeBloc>().state.appColorTheme.black90002,
                ),
                focusColor: context.watch<ThemeBloc>().state.appColorTheme.black90002,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
                  borderSide: BorderSide(
                    color: context.watch<ThemeBloc>().state.appColorTheme.black90002,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
