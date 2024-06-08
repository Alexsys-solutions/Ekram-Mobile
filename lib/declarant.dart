// ignore_for_file: non_constant_identifier_names, use_super_parameters, avoid_print, duplicate_ignore, unused_element, unused_field, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'app_colors.dart';
import 'deces.dart';
import 'utilsdeclaration.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';

class DataHolder {
  static String nomDeclarant = '';
  static String nomArabeDeclarant = '';
  static String prenomDeclarant = '';
  static String prenomArabeDeclarant = '';
  static String numPieceIdentiteDeclarant = '';
  static String telephoneDeclarant = '';
  static String type_piece = '';
  static String lien_affiliation = '';
}

class InformationsDeclarantForm extends StatefulWidget {
  const InformationsDeclarantForm({Key? key}) : super(key: key);

  @override
  State<InformationsDeclarantForm> createState() =>
      _InformationsDeclarantFormState();
}

class _InformationsDeclarantFormState extends State<InformationsDeclarantForm> {
  final _formKey = GlobalKey<FormState>();

  bool _nomValid = true;
  bool _nomArabeValid = true;
  bool _prenomValid = true;
  bool _prenomArabeValid = true;
  bool _numPieceValid = true;
  bool _telValid = true;

  bool isHovered = false;
  bool isPressed = false;

  final TextEditingController Nom_declarant = TextEditingController();
  final TextEditingController Nom_arabe_declarant = TextEditingController();
  final TextEditingController Prenom_declarant = TextEditingController();
  final TextEditingController Prenom_arabe_declarant = TextEditingController();
  final TextEditingController Telephone_declarant = TextEditingController();
  final TextEditingController Num_piece_identite_declarant =
      TextEditingController();

  final List<String> _idTypeOptions = [
    'Carte d\'identité nationale',
    'Passeport',
    'Carte de séjour',
  ];

  final List<String> _lienAffiliation = [
    'Conjoint',
    'Père',
    'Mère',
    'Frère',
    'Sœur',
    'Autre',
  ];

  List<dynamic> _options4 = [];

  bool isLoading = false;

  Future<void> _fetchOptions() async {
    try {
      final response4 = await http
          .get(Uri.parse('http://98.71.95.115/referential-api/affiliations'));

      if (response4.statusCode == 200) {
        setState(() {
          _options4 = json.decode(response4.body);
        });
      }
    } catch (error) {
      print(error);
    }
  }

  String? _selectedIdTypee = 'Carte d\'identité nationale';
  String? _selectedLienAffiliation = 'Conjoint';




  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      if (data != null) {
        Nom_declarant.text = data['declaration']?['declarant']?['name'] ?? '';
        Nom_arabe_declarant.text =
            data['declaration']?['declarant']?['nameAr'] ?? '';
        Prenom_declarant.text =
            data['declaration']?['declarant']?['firstName'] ?? '';
        Prenom_arabe_declarant.text =
            data['declaration']?['declarant']?['firstNameAr'] ?? '';
        Telephone_declarant.text =
            data['declaration']?['declarant']?['phoneNumber'] ?? '';
        Num_piece_identite_declarant.text =
            data['declaration']?['declarant']?['nationalID'] ?? '';
       
      }
    }).catchError((error) {
      print('Error: $error');
      print('$_selectedIdTypee');
    });
  }

  @override
  void dispose() {
    Nom_declarant.dispose();
    Nom_arabe_declarant.dispose();
    Num_piece_identite_declarant.dispose();
    Telephone_declarant.dispose();
    Prenom_declarant.dispose();
    Prenom_arabe_declarant.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pictures/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
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
                    buildTabsdeclarant(),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Les informations sur le déclarant",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextField(
                              label: 'Nom',
                              controller: Nom_declarant,
                              isValid: _nomValid,
                            ),
                            buildTextField2(
                              label: 'Nom en Arabe',
                              controller: Nom_arabe_declarant,
                              isValid: _nomArabeValid,
                              isArabicRequired: true,
                            ),
                            buildTextField(
                              label: 'Prénom',
                              controller: Prenom_declarant,
                              isValid: _prenomValid,
                            ),
                            buildTextField2(
                              label: 'Prénom en Arabe',
                              controller: Prenom_arabe_declarant,
                              isValid: _prenomArabeValid,
                              isArabicRequired: true,
                            ),
                            // filePickerDemo( context),
                            buildDropdownButtonFormField(
                              label: 'Type de pièce d\'identité',
                              items: _idTypeOptions,
                              value: _selectedIdTypee,
                              onChanged: (value) {
                                setState(() {
                                  _selectedIdTypee = value;
                                });
                              },
                            ),
                            buildTextField(
                              label: 'Numéro de pièce d\'identité',
                              controller: Num_piece_identite_declarant,
                              isValid: _numPieceValid,
                            ),
                            
                            buildTextField(
                              label: 'Téléphone',
                              controller: Telephone_declarant,
                              keyboardType: TextInputType.number,
                              isValid: _telValid,
                            ),
                            buildDropdownButtonFormField(
                              label: 'Lien d\'affiliation',
                              items: _lienAffiliation,
                              value: _selectedLienAffiliation,
                              onChanged: (value) {
                                setState(() {
                                  _selectedLienAffiliation = value;
                                });
                              },
                            ),

                   
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 70, right: 70),
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isPressed
                                      ? const Color(0xFF014a71)
                                      : (isHovered
                                          ?AppColors.primaryColor
                                          : AppColors.primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _nomValid = Nom_declarant.text.isNotEmpty;
                                    _nomArabeValid =
                                        Nom_arabe_declarant.text.isNotEmpty;
                                    _prenomValid =
                                        Prenom_declarant.text.isNotEmpty;
                                    _prenomArabeValid =
                                        Prenom_arabe_declarant.text.isNotEmpty;
                                    _numPieceValid =
                                        Num_piece_identite_declarant
                                            .text.isNotEmpty;
                                    _telValid =
                                        Telephone_declarant.text.isNotEmpty;
                                    isLoading = true;
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      estArabe(
                                          texte: Prenom_arabe_declarant.text)) {
                                    DataHolder.nomDeclarant =
                                        Nom_declarant.text;
                                    DataHolder.nomArabeDeclarant =
                                        Nom_arabe_declarant.text;
                                    DataHolder.prenomDeclarant =
                                        Prenom_declarant.text;
                                    DataHolder.prenomArabeDeclarant =
                                        Prenom_arabe_declarant.text;
                                    DataHolder.numPieceIdentiteDeclarant =
                                        Num_piece_identite_declarant.text;
                                    DataHolder.telephoneDeclarant =
                                        Telephone_declarant.text;
                                    DataHolder.type_piece =
                                       _selectedIdTypee?? '';
                                    DataHolder.lien_affiliation =
                                        _selectedLienAffiliation ?? '';
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const InformationsDeceForm(),
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
                            const SizedBox(
                              height: 30,
                            ),
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
