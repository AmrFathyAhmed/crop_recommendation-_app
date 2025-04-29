import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../ai_model/presentation/views/widgets/decision_screen.dart';

class AiSendInfoView extends StatefulWidget {
  const AiSendInfoView({super.key});

  @override
  State<AiSendInfoView> createState() => _AiSendInfoViewState();
}

class _AiSendInfoViewState extends State<AiSendInfoView> {
  final TextEditingController phController = TextEditingController();
  final TextEditingController nitrogenController = TextEditingController();
  final TextEditingController phosphorusController = TextEditingController();
  final TextEditingController potassiumController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController rainfallController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Interpreter _interpreter;
  late List<String> _cropLabels;
  String _predictedCrop = "None";
  List<double> _probabilities = [];

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadLabelEncoder();
  }

  Future<void> _loadModel() async {
    try {
      // Load the model from assets
      _interpreter = await Interpreter.fromAsset('assets/model/crop_model (1).tflite');
      print("✅ Model loaded successfully");
    } catch (e) {
      print("❌ Failed to load model: $e");
    }
  }

  Future<void> _loadLabelEncoder() async {
    // Hardcoding the labels because we cannot use pickle in Dart
    _cropLabels = [
      'apple', 'banana', 'blackgram', 'chickpea', 'coconut', 'coffee', 'cotton', 'grapes', 'jute',
      'kidneybeans', 'lentil', 'maize', 'mango', 'mothbeans', 'mungbean', 'muskmelon', 'orange',
      'papaya', 'pigeonpeas', 'pomegranate', 'rice', 'watermelon'
    ];
  }

  void _predictCrop() {
    // Sample input: [N, P, K, temperature, humidity, pH, rainfall]
    final input = Float32List.fromList([
      double.parse(nitrogenController.text),
      double.parse(phosphorusController.text),
      double.parse(potassiumController.text),
      double.parse(temperatureController.text),
      double.parse(humidityController.text),
      double.parse(phController.text),
      double.parse(rainfallController.text),
    ]);
    final inputBuffer = input.reshape([1, 7]); // Shape: [1, 7]

    // Output buffer
    final outputBuffer = List.filled(_cropLabels.length, 0.0).reshape([1, _cropLabels.length]);

    // Run inference
    _interpreter.run(inputBuffer, outputBuffer);

    // Get results
    final output = outputBuffer[0];

    // Ensure output is of the correct type (List<double>)
    List<double> probabilities = List<double>.from(output);

    // Find the index of the highest probability
    final predictedIndex = _findMaxIndex(probabilities);

    setState(() {
      _predictedCrop = _cropLabels[predictedIndex];
      _probabilities = probabilities;
    });

    print("Predicted Crop: $_predictedCrop");
    print("Probabilities: $_probabilities");
  }

  int _findMaxIndex(List<double> list) {
    double max = list[0];
    int index = 0;
    for (int i = 1; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
        index = i;
      }
    }
    return index;
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Details', style: AppTextStyles.title),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/image/Group.svg',
                            width: 30, // Replace with your screenWidth * 0.07 logic if needed
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text('Soil Parameters', style: AppTextStyles.sectionTitle),
                  SoilColorDropdown(),
                  CustomTextField(
                    hintText: 'PH Level (0-14)',
                    iconPath: 'assets/image/ph.svg',
                    controller: phController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }
                      if (number < 0 || number > 14) {
                        return 'Please enter a value between 0 and 14';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text('Nutrient Level (Kg/ha)', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Nitrogen (N)',
                    iconPath: 'assets/image/urine-in-a-flask-for-experimentation-svgrepo-com.svg',
                    controller: nitrogenController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter nitrogen value';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }
                      if (number < 0) {
                        return 'Please enter a value greater than 0';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Phosphorus (P)',
                    iconPath: 'assets/image/urine-in-a-flask-for-experimentation-svgrepo-com.svg',
                    controller: phosphorusController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phosphorus value';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }
                      if (number < 0) {
                        return 'Please enter a value greater than 0';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Potassium (K)',
                    iconPath: 'assets/image/urine-in-a-flask-for-experimentation-svgrepo-com.svg',
                    controller: potassiumController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter potassium value';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }
                      if (number < 0) {
                        return 'Please enter a value greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text('Environmental Parameters', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Temperature (°C)',
                    iconPath: 'assets/image/mdi_temperature.svg',
                    controller: temperatureController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter temperature';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Rainfall (mm)',
                    iconPath: 'assets/image/material-symbols_water-ph-rounded.svg',
                    controller: rainfallController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rainfall';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Humidity (%)',
                    iconPath: 'assets/image/prsantag.svg',
                    controller: humidityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter humidity';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          // Check if the form is valid before triggering prediction
                          if (_formKey.currentState?.validate() ?? false) {
                            // Get all the parameters from controllers

                            final phLevel = double.parse(phController.text);
                            final nitrogen = double.parse(nitrogenController.text);
                            final phosphorus = double.parse(phosphorusController.text);
                            final potassium = double.parse(potassiumController.text);
                            final temperature = double.parse(temperatureController.text);
                            final rainfall = double.parse(rainfallController.text);
                            final humidity = double.parse(humidityController.text);

                            // Perform the prediction
                            _predictCrop();

                            // After prediction, navigate to the next screen with all parameters
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DecisionScreen(
                                 Predict: _predictedCrop,
                                  phLevel: phLevel,
                                  nitrogen: nitrogen,
                                  phosphorus: phosphorus,
                                  potassium: potassium,
                                  temperature: temperature,
                                  rainfall: rainfall,
                                  humidity: humidity,
                                ),
                              ),
                            );
                          } else {
                            // Show a message or error if the form is invalid
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all fields correctly!')),
                            );
                          }
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Get Recommendation', style: AppTextStyles.buttonText),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class CustomTextField extends StatelessWidget {
  final String hintText;
  final String iconPath;
  final TextEditingController? controller;
  final bool readOnly;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.iconPath,
    this.controller,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.06;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: validator,
        keyboardType: TextInputType.number,
        controller: controller,
        readOnly: readOnly,
        style: AppTextStyles.inputText,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xff373737).withOpacity(.4),
          hintText: hintText,
          hintStyle: AppTextStyles.inputText.copyWith(color: const Color(0xff777777)),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              iconPath,
              width: 16,
              height: 16,
              color: const Color(0xff709800),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
class AppTextStyles {
  static final TextStyle title = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static final TextStyle sectionTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
  );

  static final TextStyle inputText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textWhite,
  );

  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryDark,
  );
}

class AppColors {
  static const Color primaryDark = Color(0xFF00261C);
  static const Color secondaryGreen = Color(0xFFBCFF00);
  static const Color textWhite = Colors.white;
  static const Color fieldBackground = Color(0xFF003523);
}
class SoilColorDropdown extends StatelessWidget {
  final List<String> soilColors = [
    'Brown',
    'Red',
    'Black',
    'Yellow',
    'Gray',
    'White',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff373737).withOpacity(.4),
          hintText: 'Soil Color',
          hintStyle: AppTextStyles.inputText.copyWith(color: Color(0xff777777)),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),

        borderRadius: BorderRadius.circular(16),
        style: AppTextStyles.inputText,

        dropdownColor: Color(0xff373737).withOpacity(.8),
        iconEnabledColor: Colors.white,

        items: soilColors.map((color) {
          return DropdownMenuItem(

            value: color,
            child: Text(color, style: AppTextStyles.inputText),
          );
        }).toList(),
        onChanged: (value) {

          print('Selected Soil Color: $value');
        },
      ),
    );
  }
}
