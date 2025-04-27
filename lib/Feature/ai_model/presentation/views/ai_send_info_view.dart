import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// Import your AppColors and AppTextStyles here

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

  late Interpreter _interpreter;

  static const int numberOfClasses = 8; // <-- Your model output classes

  List<String> labels = [
    'Sugarcane' 'Jowar' 'Cotton' 'Rice' 'Wheat' 'Groundnut' 'Maize' 'Tur'
        'Urad' 'Moong' 'Gram' 'Masoor' 'Soybean' 'Ginger' 'Turmeric' 'Grapes'
        'rice' 'maize' 'chickpea' 'kidneybeans' 'pigeonpeas' 'mothbeans'
        'mungbean' 'blackgram' 'lentil' 'pomegranate' 'banana' 'mango' 'grapes'
        'watermelon' 'muskmelon' 'apple' 'orange' 'papaya' 'coconut' 'cotton'
        'jute' 'coffee' 'Barley' 'Bean' 'Dagussa' 'Fallow' 'Niger seed' 'Pea'
        'Potato' 'Red Pepper' 'Sorghum' 'Teff' 'Corn' 'Tomato' 'Sunflower'
  ];

  @override
  void initState() {
    super.initState();
    loadModel();
  }


  @override
  void dispose() {
    phController.dispose();
    nitrogenController.dispose();
    phosphorusController.dispose();
    potassiumController.dispose();
    temperatureController.dispose();
    rainfallController.dispose();
    humidityController.dispose();
    super.dispose();
  }

  bool isModelLoaded = false;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('models/crop_model.tflite');
    setState(() {
      isModelLoaded = true;
    });
  }

  Future<void> predict() async {
    if (!isModelLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Model is still loading, please wait...')),
      );
      return;
    }

    try {
      final input = [
        double.parse(phController.text),
        double.parse(nitrogenController.text),
        double.parse(phosphorusController.text),
        double.parse(potassiumController.text),
        double.parse(temperatureController.text),
        double.parse(rainfallController.text),
        double.parse(humidityController.text),
      ];

      var inputTensor = [input];
      var output = List.filled(1 * 8, 0).reshape([1, 8]);

      _interpreter.run(inputTensor, output);

      int predictedIndex = output[0].indexWhere(
            (element) => element == output[0].reduce((curr, next) => curr > next ? curr : next),
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Recommended Crop'),
          content: Text('Prediction: $predictedIndex'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      print('Prediction error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong. Please check your inputs.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                          width: screenWidth * 0.07,
                          height: screenWidth * 0.07,
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
                ),
                CustomTextField(
                  hintText: 'Phosphorus (P)',
                  iconPath: 'assets/image/urine-in-a-flask-for-experimentation-svgrepo-com.svg',
                  controller: phosphorusController,
                ),
                CustomTextField(
                  hintText: 'Potassium (K)',
                  iconPath: 'assets/image/urine-in-a-flask-for-experimentation-svgrepo-com.svg',
                  controller: potassiumController,
                ),
                const SizedBox(height: 24),
                Text('Environmental Parameters', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Temperature (°C)',
                  iconPath: 'assets/image/mdi_temperature.svg',
                  controller: temperatureController,
                ),
                CustomTextField(
                  hintText: 'Rainfall (mm)',
                  iconPath: 'assets/image/material-symbols_water-ph-rounded.svg',
                  controller: rainfallController,
                ),
                CustomTextField(
                  hintText: 'Humidity (%)',
                  iconPath: 'assets/image/prsantag.svg',
                  controller: humidityController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: predict,
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
