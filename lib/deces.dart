// ignore_for_file: non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api, avoid_print, unused_field, unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'decede.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'confirmation.dart';
// import 'decede.dart';
import 'utilsdeclaration.dart';
import 'declarant.dart';
import 'app_colors.dart';

class InfoDeces {
  static String Datedeces = '';
  static String HeurDeces = '';
  static String LieuDeces = '';
  static String AdresseDeces = '';
  static String ProvinceDeces = '';
  static String CimetiereDeces = '';
  static String ArrondissementDeces = '';
}

class InformationsDeceForm extends StatefulWidget {
  const InformationsDeceForm({Key? key}) : super(key: key);

  @override
  _InformationsDeceFormState createState() => _InformationsDeceFormState();
}

class _InformationsDeceFormState extends State<InformationsDeceForm> {
  final TextEditingController date_deces_controller = TextEditingController();
  final TextEditingController time_deces_controller = TextEditingController();
  final TextEditingController Adresse_deces_controller =
      TextEditingController();
  final TextEditingController dropdown = TextEditingController();

  bool isHovered = false;
  bool isPressed = false;

  bool _AdresselValid = true;

  String? _selectedOption2;
  String? _selectedOption3;
  String? _selectedOption6;
  String? _selectedOption7;

  String? _selectedOptionprovince;
  List<dynamic> _optionscountries = [];
  List<dynamic> _optionsArrondissement = [];
  String? addressOfDeath;
  String? y;

  List<dynamic> _options2 = [];
  List<dynamic> _options3 = [];
  List<dynamic> _options6 = [];
  List<dynamic> _optionsprovince = [];



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // _fetchOptions();
    _fetchOptions();

    fetchData().then((data) {
      if (data != null) {
        date_deces_controller.text =
            data['declaration']?['death']?['dateOfDeath'] ?? '';
        // y = date_deces_controller.text;
        time_deces_controller.text =
            data['declaration']?['death']?['timeOfDeath'] ?? '';
        Adresse_deces_controller.text =
            data['declaration']?['death']?['addressOfDeath'] ?? '';
   
        y = date_deces_controller.text;
      
      }
    }).catchError((error) {
      print('Error: $error');
      print('Valeur daddressOfDeath: $y');
    });
  }

  @override
  void dispose() {
    Adresse_deces_controller.dispose();
    time_deces_controller.dispose();
    date_deces_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
 
    leading: IconButton(
        icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InformationsDeclarantForm(),
          ),
        );
      },
    ),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('pictures/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
      body: Container(
        height: 1000,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pictures/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
       
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [


                  Image.asset(
                      'pictures/ikram_logo.png',
                      width: 150,
                      height: 70,
                      alignment: Alignment.topLeft,
                    ),
                    buildTabsdeces(),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Les informations sur le décès",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            buildDateTextField(
                              label: 'Date du décès',
                              controller: date_deces_controller,
                              onTap: () => _selectedDate(context),
                            ),
                            buildDateTextField(
                              label: 'Heure du décès',
                              controller: time_deces_controller,
                              onTap: () => _selectedTime(context),
                            ),
                            // _buildDropdownButtonFormField(
                            //   label: 'Lieu du décès',
                            //   options: _options2,
                            //   value: _selectedOption2,
                            //   onChanged: (newValue) {
                            //     setState(() {
                            //       _selectedOption2 = newValue;
                            //     });
                            //   },
                            // ),
                            // _buildDropdownButtonFormField(
                            //   label: 'Préfecture/Province',
                            //   options: _optionsprovince,
                            //   value: _selectedOptionprovince,
                            //   onChanged: (newValue) {
                            //     setState(() {
                            //       _selectedOptionprovince = newValue;
                            //     });
                            //   },
                            // ),
                       
                            // _buildDropdownButtonFormField(
                            //   label: 'Commune/Arrondissement',
                            //   options: _optionsArrondissement,
                            //   value: _selectedOption7,
                            //   onChanged: (newValue) {
                            //     setState(() {
                            //       _selectedOption7 = newValue;
                            //     });
                            //   },
                            // ),
                          

                            buildTextField(
                              label: 'Adresse Habituelle',
                              controller: Adresse_deces_controller,
                              isValid: _AdresselValid,
                            ),
                            _buildDropdownButtonFormField(
                              label: 'Cimetière d\'enterrement',
                              options: _options6,
                              value: _selectedOption6,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedOption6 = newValue;
                                });
                              },
                            ),

                            const SizedBox(height: 30),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                               ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: isPressed
                                     ? const Color(0xFF014a71)
                                     : (isHovered
                                         ? AppColors.primaryColor
                                         : AppColors.primaryColor),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(7),
                                 ),
                               ),
                               onPressed: () {
                                 setState(() {
                                   _AdresselValid = Adresse_deces_controller
                                       .text.isNotEmpty;
                                 });
                             
                                 if (_formKey.currentState!.validate() &&
                                     _AdresselValid) {
                                   InfoDeces.Datedeces =
                                       date_deces_controller.text;
                                   InfoDeces.HeurDeces =
                                       time_deces_controller.text;
                             
                                   InfoDeces.AdresseDeces =
                                       Adresse_deces_controller.text;
                                   InfoDeces.ProvinceDeces =
                                       _selectedOptionprovince ?? '';
                                   InfoDeces.CimetiereDeces =
                                       _selectedOption6 ?? '';
                             
                                   InfoDeces.LieuDeces =
                                       _selectedOption2 ?? '';
                                   InfoDeces.ArrondissementDeces =
                                       _selectedOption7 ?? '';
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) =>
                                           const InformationsDecedeForm(),
                                     ),
                                   );
                                 }
                               },
                               child: const Center(
                                 child: Text(
                                   'Suivant',
                                   style: TextStyle(
                                     fontSize: 20,
                                     color: Colors.white,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                               ),
                             ),
                                                       //     SizedBox(width: 30,),
                                                       //   TextButton(
                                                       //   onPressed: () {
                                                       //     Navigator.pop(context);
                                                       //   },
                                                       //   style: TextButton.styleFrom(
                                                         
                                                       //     backgroundColor: AppColors.primaryColor, 
                             
                                                       //     shape: RoundedRectangleBorder(
                                                       //       borderRadius: BorderRadius.circular(7), 
                                                       //     ),
                                                       //   ),
                                                       //  child: const Center(
                                                       //         child: Text(
                                                       //           'Precedent',
                                                       //           style: TextStyle(
                                                       //             fontSize: 20,
                                                       //             color: Colors.white,
                                                       //             fontWeight: FontWeight.w700,
                                                       //           ),
                                                       //         ),
                                                       //       ),
                                                       
                                                       //   ),
                             
                             
                                                                  
                                          ] ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        
      
    );
  }

  Future<void> _selectedDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        date_deces_controller.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectedTime(BuildContext context) async {
    TimeOfDay time = TimeOfDay.now();
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary:AppColors.primaryColor,
              onPrimary: Colors
                  .white, 
              
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        time_deces_controller.text = selectedTime.format(context);
      });
    }
  }

  Widget _buildDropdownButtonFormField({
    required String label,
    required List<dynamic> options,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.only(right: 22, left: 22),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: options.map<DropdownMenuItem<String>>((dynamic option) {
          return DropdownMenuItem<String>(
            value: option['nameFr'],
            child: Text(option['nameFr']),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: '$label *',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 69, 67, 67),
              fontSize: 16,
              fontWeight: FontWeight.w800),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF014a71))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF014a71))),
        ),
        iconSize: 30,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez sélectionner une option';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _fetchOptions() async {
    try {
      final response2 = await http
          .get(Uri.parse('http://98.71.95.115/referential-api/death_place'));
      final response3 = await http.get(Uri.parse(
          'http://98.71.95.115/referential-api/administrative-hierarchies'));
      final response6 = await http.get(
          Uri.parse('http://98.71.95.115/referential-api/cemeteries/by-bch/1'));
      final response7 = await http
          .get(Uri.parse('http://98.71.95.115/referential-api/countries'));
      final response8 = await http.get(Uri.parse(
          'http://98.71.95.115/referential-api/administrative-hierarchies/1'));

      final response9 = await http.get(Uri.parse(
          'http://98.71.95.115/referential-api/administrative-hierarchies/by-parent/14'));

      if (response2.statusCode == 200) {
        setState(() {
          _options2 = json.decode(response2.body);
        });
      }
      if (response3.statusCode == 200) {
        setState(() {
          _options3 = json.decode(response3.body);
        });
      }

      if (response6.statusCode == 200) {
        setState(() {
          _options6 = json.decode(response6.body);
        });
      }
      if (response7.statusCode == 200) {
        _optionscountries = json.decode(response7.body);
      }
      if (response9.statusCode == 200) {
        _optionsArrondissement = json.decode(response9.body);
      }
      if (response8.statusCode == 200) {
        setState(() {
          _optionsprovince = json.decode(response8.body);
        });
      }
      // setState(() {
      //   _selectedOption2 = _options2.first;

      // });
    } catch (error) {
      print(error);
    }
  }
}
