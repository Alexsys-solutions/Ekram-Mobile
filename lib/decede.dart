// ignore_for_file: duplicate_import, duplicate_ignore, prefer_final_fields, unused_field, non_constant_identifier_names, unused_element, avoid_print, depend_on_referenced_packages


import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'constatation.dart';
import 'constatation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'utilsdeclaration.dart';
import 'app_colors.dart';
import 'deces.dart';

class InfoDecede {
  static String nomDecede = '';
  static String nomArabeDecede = '';
  static String prenomDecede = '';
  static String prenomArabeDecede = '';
  static String numPieceIdentiteDecede = '';

  static String DateNaiss = '';
  static String Nationa = '';
  static String pays = '';
  static String adresse = '';
  static String Province = '';
  static String Commune = '';
  static String typePiece = '';
}

class InformationsDecedeForm extends StatefulWidget {
  const InformationsDecedeForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InformationsDecedeFormState createState() => _InformationsDecedeFormState();
}

class _InformationsDecedeFormState extends State<InformationsDecedeForm> {
  final _formKey = GlobalKey<FormState>();
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
    } catch (error) {
      print(error);
    }
  }

  bool isHovered = false;
  bool isPressed = false;

  bool _nomValid = true;
  bool _nomArabeValid = true;
  bool _prenomValid = true;
  bool _prenomArabeValid = true;
  bool _numPieceValid = true;
  bool _telValid = true;

  String? _selectedOption2;
  String? _selectedOption3;
  String? _selectedOption6;
  String? _selectedOption5;
  String? _selectedOptionprovince;
  String? _selectedOptioncountries;
  String? _selectedOptioncommune;
  String? _selectedOptionresidence;
  String? _uu;

  List<dynamic> _options2 = [];
  List<dynamic> _options3 = [];
  List<dynamic> _options6 = [];
  List<dynamic> _optionsprovince = [];
  List<dynamic> _optionscountries = [];
  List<dynamic> _optionsArrondissement = [];

  final List<String> _situationFamiliale = [
    'Célibataire(e)',
    'Marié(e)',
    'Divorcé(e)',
    'Veuf(e)'
  ];

  String? _selectedSituationFamiliale;
  String? _selectedIdType;
  String? _selectedNationalite;
  String? _selectedProvince;

  final List<String> _idTypeOptions = [
    'Carte d\'identité nationale',
    'Passeport',
    'Carte de séjour',
  ];

  String _nouveauNeValue = 'Non';
  String _nouveauValue = 'Non';
  String _selectedGender = '';

  final TextEditingController Nom_decede = TextEditingController();
  final TextEditingController Nom_arabe_decede = TextEditingController();
  final TextEditingController Prenom_decede = TextEditingController();
  final TextEditingController Prenom_arabe_decede = TextEditingController();
  final TextEditingController date_naissance_decede = TextEditingController();
  final TextEditingController date_Naissance_Controller =
      TextEditingController();
  final TextEditingController lieu_Naissance_Controller_decede =
      TextEditingController();
  final TextEditingController Num_piece_identite_decede =
      TextEditingController();
  final TextEditingController Type_piece_identite_decede =
      TextEditingController();
  final TextEditingController Copie_piece_identite_decede =
      TextEditingController();
  final TextEditingController Copie_piece_identite_recto_decede =
      TextEditingController();
  final TextEditingController Adresse_decede_controller =
      TextEditingController();
  final TextEditingController Nombre_Jours_vecu_decede_controller =
      TextEditingController();
  final TextEditingController Poids_Naissance_decede_controller =
      TextEditingController();
  final TextEditingController Nom_complet_Mom_controller =
      TextEditingController();
  final TextEditingController Nom_Complet_Mom_Arabe = TextEditingController();
  final TextEditingController date_Naissance_Mom_Controller =
      TextEditingController();
  final TextEditingController Num_piece_identite_Mom = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchOptions();
    fetchData().then((data) {
      if (data != null) {
        Nom_decede.text = data['declaration']?['deceased']?['name'] ?? '';
        Nom_arabe_decede.text =
            data['declaration']?['deceased']?['nameAr'] ?? '';
        Prenom_decede.text =
            data['declaration']?['deceased']?['firstName'] ?? '';
        Prenom_arabe_decede.text =
            data['declaration']?['deceased']?['firstNameAr'] ?? '';
        date_Naissance_Controller.text =
            data['declaration']?['deceased']?['dateOfBirth'] ?? '';
        lieu_Naissance_Controller_decede.text =
            data['declaration']?['death']?['placeOfBirth'] ?? '';
        Adresse_decede_controller.text =
            data['declaration']?['deceased']?['homeAddress'] ?? '';
        Num_piece_identite_decede.text =
            data['declaration']?['deceased']?['nationalID'] ?? '';
        Nombre_Jours_vecu_decede_controller.text =
            data['declaration']?['deceased']?['daysOfLife'] ?? '';
        Poids_Naissance_decede_controller.text =
            data['declaration']?['deceased']?['birthWeight'] ?? '';
        _selectedProvince = data['declaration']?['deceased']
                ?['addressSecondLevelAdminAreaId'] ??'';
            
        _uu = data['declaration']?['deceased']?['firstNameAr'] ?? '';
      }
    }).catchError((error) {
      print('Error: $error');
      print('Errorgg: $_uu ');
    });
  }

  @override
  void dispose() {
    Adresse_decede_controller.dispose();
    date_naissance_decede.dispose();
    lieu_Naissance_Controller_decede.dispose();

    Prenom_arabe_decede.dispose();
    Prenom_decede.dispose();
    Nom_arabe_decede.dispose();
    Nom_decede.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InformationsDeceForm(),
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'pictures/ikram_logo.png',
                    width: 150,
                    height: 70,
                  ),
                  const SizedBox(height: 10),
                 buildTabsdecede(),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pictures/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                   
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
                              "Les informations sur le décédé",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Est-ce qu\'il s\'agit d\'un nouveau-né ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                               color:  Color.fromARGB(255, 69, 67, 67),
                                fontSize: 15,
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                          
                         child:Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio<String>(
                                    value: 'Non',
                                    groupValue: _nouveauValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _nouveauValue = value!;
                                      });
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                  const Text(
                                    'Non',
                                    style: TextStyle(fontSize: 16,      color:  Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                  ),
                                  Radio<String>(
                                    value: 'Oui',
                                    groupValue: _nouveauValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _nouveauValue = value!;
                                      });
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                  const Text(
                                    'Oui',
                                   style: TextStyle(fontSize: 16,      color:  Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                  ),
                                ],
                              ),
                          ),
                            if (_nouveauValue == "Non") ...{
                              buildTextField(
                                  label: 'Nom',
                                  controller: Nom_decede,
                                  isValid: _nomValid),
                              buildTextField2(
                                label: 'Nom en Arabe',
                                controller: Nom_arabe_decede,
                                isValid: _nomArabeValid,
                                isArabicRequired: true,
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                              buildTextField(
                                  label: 'Prénom',
                                  controller: Prenom_decede,
                                  isValid: _prenomValid),
                              buildTextField2(
                                label: 'Prénom en Arabe',
                                controller: Prenom_arabe_decede,
                                isValid: _prenomArabeValid,
                                isArabicRequired: true,
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: TextFormField(
                                  controller: date_Naissance_Controller,
                                  decoration: const InputDecoration(
                                    labelText: 'Date de naissance *',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 69, 67, 67),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Color(0xFF014a71)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Color(0xFF014a71)),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: AppColors.primaryColor,
                                              onPrimary: Colors.white,
                                            ),
                                            dialogBackgroundColor: Colors.white,
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        date_Naissance_Controller.text =
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                      });
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Non',
                                      groupValue: _nouveauNeValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _nouveauNeValue = value!;
                                        });
                                      },
                                      activeColor: AppColors.primaryColor,
                                    ),
                                    const Text(
                                      'Homme',
                                       style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                    Radio<String>(
                                      value: 'Oui',
                                      groupValue: _nouveauNeValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _nouveauNeValue = value!;
                                        });
                                      },
                                      activeColor: AppColors.primaryColor,
                                    ),
                                    const Text(
                                      'Femme',
                                       style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              buildDropdownButtonFormField(
                                label: 'Situation familiale',
                                items: _situationFamiliale,
                                value: _selectedSituationFamiliale,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSituationFamiliale = value;
                                  });
                                },
                              ),
                            buildDropdownButtonFormField(
                                label: 'Type de pièce d\'identité',
                                items: _idTypeOptions,
                                value: _selectedIdType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIdType = value;
                                  });
                                },
                              ),
                              buildTextField(
                                  label: 'Numéro de pièce d\'identité',
                                  controller: Num_piece_identite_decede,
                                  isValid: _numPieceValid),
                              _buildDropdownButtonFormField(
                                label: 'Nationalité',
                                options: _optionscountries,
                                value: _selectedOptioncountries,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOptioncountries = newValue;
                                  });
                                },
                              ),
                              _buildDropdownButtonFormField(
                                label: 'Pays de résidence',
                                options: _optionscountries,
                                value: _selectedOptionresidence,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOptionresidence = newValue;
                                  });
                                },
                              ),
                              _buildDropdownButtonFormField(
                                label: 'Préfecture/Province',
                                options: _optionsprovince,
                                value: _selectedOptionprovince,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOptionprovince = newValue;
                                  });
                                },
                              ),
                              _buildDropdownButtonFormField(
                                label: 'Commune/Arrondissement',
                                options: _optionsArrondissement,
                                value: _selectedOptioncommune,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOptioncommune = newValue;
                                  });
                                },
                              ),
                              buildTextField(
                                  label: 'Adresse Habituelle',
                                  controller: Adresse_decede_controller,
                                  isValid: _telValid),
                              const SizedBox(height: 20),
                            } else ...{
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 2,
                                color: Colors.black12,
                              ),
                              // ignore: equal_elements_in_set
                              const SizedBox(
                                height: 20,
                              ),

                              const Text(
                                '+Informations concernant le Mort-né/Nouveau-né',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Row(
                               
                                  children: [
                                    Radio(
                                      value: 'Nouveau-né',
                                      activeColor: AppColors.primaryColor,
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value as String;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Nouveau-né',
                                       style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                    Radio(
                                      value: 'Mort-né',
                                      activeColor: AppColors.primaryColor,
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value as String;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Mort-né',
                                      style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              buildTextField(
                                  label: 'Nombre de jours vécus',
                                  controller:
                                      Nombre_Jours_vecu_decede_controller,
                                  keyboardType:
                                      const TextInputType.numberWithOptions()),
                              // ignore: equal_elements_in_set
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  ' Grossesse multiple ?',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Center(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio(
                                      value: 'Oui',
                                      activeColor: AppColors.primaryColor,
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value as String;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Oui',
                                      style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                    Radio(
                                      value: 'Non',
                                      activeColor: AppColors.primaryColor,
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value as String;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Non',
                                      style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                    Radio(
                                      value: 'Inconnue',
                                      activeColor: AppColors.primaryColor,
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value as String;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Inconnue',
                                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 69, 67, 67),fontWeight:FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              buildTextField(
                                  label: 'Poids à la naissance)',
                                  controller: Poids_Naissance_decede_controller,
                                  keyboardType:
                                      const TextInputType.numberWithOptions()),
                              // ignore: equal_elements_in_set
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                height: 2,
                                color: Colors.black12,
                              ),
                              // ignore: equal_elements_in_set
                              const SizedBox(height: 20),

                              // ignore: equal_elements_in_set
                              const Text(
                                '+Données personnelles de la mère',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              buildTextField(
                                  label: 'Nom complet',
                                  controller: Nom_complet_Mom_controller),
                              buildTextField2(
                                label: 'Nom complet en Arabe',
                                controller: Nom_Complet_Mom_Arabe,
                                isArabicRequired: true,
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                              buildTextField(
                                  label: 'Date de naissance',
                                  controller: date_Naissance_Mom_Controller),
                            buildDropdownButtonFormField(
                                label: 'Type de pièce d\'identité',
                                items: _idTypeOptions,
                                value: _selectedIdType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIdType = value;
                                  });
                                },
                              ),
                              buildTextField(
                                  label: 'Numéro de pièce d\'identité',
                                  controller: Num_piece_identite_Mom),
                              // ignore: equal_elements_in_set
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                height: 2,
                                color: Colors.black12,
                              ),
                              // ignore: equal_elements_in_set
                              const SizedBox(height: 20),

                              // ignore: equal_elements_in_set
                              const Text(
                                '+Données d\'adresse',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 82, 53, 43),
                                ),
                              ),
                              // ignore: equal_elements_in_set
                              // const SizedBox(height: 10),
                              buildDropdownButtonFormField(
                                label: 'Lieu du décès',
                                items: _idTypeOptions,
                                value: _selectedIdType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIdType = value;
                                  });
                                },
                              ),
                              _buildDropdownButtonFormField(
                                label: 'Préfecture/Province',
                                options: _optionsprovince,
                                value: _selectedOptionprovince,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOptionprovince = newValue;
                                  });
                                },
                              ),

                              _buildDropdownButtonFormField(
                                label: 'Commune/Arrondissement',
                                options: _optionsArrondissement,
                                value: _selectedOptioncommune,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOptioncommune = newValue;
                                  });
                                },
                              ),
                              buildTextField(
                                  label: 'Adresse Habituelle',
                                  controller: Adresse_decede_controller,
                                  isValid: _telValid),
                               // ignore: equal_elements_in_set
                               const SizedBox(height: 20),
                            },
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 70),
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isPressed
                                      ? const Color(0xFF014a71)
                                      : (isHovered
                                          ? const Color.fromARGB(
                                              255, 118, 79, 66)
                                          : const Color.fromARGB(
                                              255, 118, 79, 66)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _nomValid = Nom_decede.text.isNotEmpty;
                                    _nomArabeValid =
                                        Nom_arabe_decede.text.isNotEmpty;
                                    _prenomValid =
                                        Prenom_decede.text.isNotEmpty;
                                    _prenomArabeValid =
                                        Prenom_arabe_decede.text.isNotEmpty;
                                    _numPieceValid = Num_piece_identite_decede
                                        .text.isNotEmpty;
                                    _telValid = Adresse_decede_controller
                                        .text.isNotEmpty;
                                  });

                                  if (_formKey.currentState!.validate()) {
                                    InfoDecede.nomDecede = Nom_decede.text;
                                    InfoDecede.nomArabeDecede =
                                        Nom_arabe_decede.text;
                                    InfoDecede.prenomDecede =
                                        Prenom_decede.text;
                                    InfoDecede.prenomArabeDecede =
                                        Prenom_arabe_decede.text;
                                    InfoDecede.Nationa =
                                        _selectedOptioncountries ?? '';
                                    InfoDecede.pays =
                                        _selectedOptionresidence ?? '';
                                    InfoDecede.Province =
                                        _selectedOptionprovince ?? '';
                                    InfoDecede.DateNaiss =
                                        date_Naissance_Controller.text;
                                    InfoDecede.numPieceIdentiteDecede =
                                        Num_piece_identite_decede.text;
                                    InfoDecede.typePiece =
                                        _selectedIdType ?? '';
                                    InfoDecede.Commune =
                                        _selectedOptioncommune ?? '';
                                    InfoDecede.adresse =
                                        Adresse_decede_controller.text;

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RapportDeDeces(),
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
                            ),
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
        ),
      ),
    );
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
