// ignore_for_file: dead_code, avoid_print, use_key_in_widget_constructors, unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utilsdeclaration.dart';
import 'app_colors.dart';

class SearchDeclaration extends StatefulWidget {
  const SearchDeclaration({Key? key});

  @override
  State<SearchDeclaration> createState() => _SearchDeclarationState();
}

class _SearchDeclarationState extends State<SearchDeclaration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Card> _declarationCards = [];
  bool isLoading = false;
  final TextEditingController dateControllerStart = TextEditingController();
  final TextEditingController dateControllerEnd = TextEditingController();
  final TextEditingController numIdentiteController = TextEditingController();

  bool isPressed = false;

  String? _selectedStatut;

  final List<String> _statuts = [
    'En constatation',
    'En validation constatation',
    'En signature attestation de deces',
    'En signature permis d\'inhumer',
  ];

  final Map<String, int> _statutsMap = {
    'En constatation': 1,
    'En validation constatation': 2,
    'En signature attestation de deces': 3,
    'En signature permis d\'inhumer': 4,
  };

  Future<List<Card>> _chercherDeclaration(
      String dateDebut, String dateFin, int idStatut, String idIdentite) async {
    int pageNumber = 1;
    const pageSize = 10;

    final String url =
        'http://98.71.95.115/declaration-api/declarations?AssignmentBCH=1&StatusId=$idStatut&DateOfDeathStart=$dateDebut&DateOfDeathEnd=$dateFin&DeceasedNationalID=$idIdentite';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Pagenumber': pageNumber.toString(),
        'X-Pagesize': pageSize.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      List<dynamic> declarations = jsonDecode(response.body)['data'];
      List<Card> cartes = [];

      if (declarations.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Column(children: [
                    Text(
                      'Pas de déclaration trouvée',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Icon(
                      Icons.help_outline,
                      size: 50,
                      color: Colors.white,
                    ),
                  ]),
                ),
              ],
            ),
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.primaryColor,
          ),
        );

        return [];
      }

      for (var declaration in declarations) {
        Card carte = Card(
          color: const Color.fromARGB(255, 248, 242, 227),
          elevation: 5,
          child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: ListTile(
              title: Text(
                '${declaration['deceased']?['name']} ${declaration['deceased']?['firstName']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: AppColors.primaryColor,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'N°: ${declaration['declarationNumber'] ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Date de décès: ${declaration['death']?['dateOfDeath'] ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Age de défunt: ${declaration['deceased']?['age'] ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
        );

        cartes.add(carte);
      }

      return cartes;
    } else {
      print('Response body: ${response.body}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 2000,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pictures/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  buildTextField(
                    label: 'Numéro d\'identité',
                    controller: numIdentiteController,
                  ),
                  _buildDateField(
                    label: 'Date de décès (Début) *',
                    controller: dateControllerStart,
                  ),
                  _buildDateField(
                    label: 'Date de décès (Fin) *',
                    controller: dateControllerEnd,
                  ),
                buildDropdownButtonFormField(
                    label: 'Statut',
                    items: _statuts,
                    value: _selectedStatut,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatut = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSubmitButton(),
                  const SizedBox(height: 20),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    height: 2000,
                    child: ListView.builder(
                      itemCount: _declarationCards.length,
                      itemBuilder: (context, index) {
                        return _declarationCards[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    bool isValid = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        readOnly: true,
        controller: controller,
        onTap: () {
          _selectedDate(context, controller);
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 69, 67, 67),
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isPressed
              ? AppColors.primaryColor
              : AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          minimumSize: Size(MediaQuery.of(context).size.width, 50),
        ),
        onPressed: () async {
          setState(() {
            isPressed = true;
          });
          await Future.delayed(const Duration(seconds: 2));

          if (_formKey.currentState?.validate() ??
              false && _selectedStatut != null) {
            final String dateOfDeathStart = dateControllerStart.text;
            final String dateOfDeathEnd = dateControllerEnd.text;
            final String ID = numIdentiteController.text;
            final selectedId = _statutsMap[_selectedStatut]!;
            List<Card> cards = await _chercherDeclaration(
                dateOfDeathStart, dateOfDeathEnd, selectedId, ID);
            setState(() {
              _declarationCards = cards;
            });
          } else {
            print("Please select a status");
          }

          setState(() {
            isPressed = false;
          });
        },
        child: isPressed
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                'Filtrer',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Future<void> _selectedDate(
      BuildContext context, TextEditingController controller) async {
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
        controller.text = picked.toString().split(" ")[0];
      });
    }
  }
}
