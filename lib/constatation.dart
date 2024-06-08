// ignore_for_file: unused_field, unused_element, use_super_parameters

import 'package:flutter/material.dart';
import 'confirmation.dart';
import 'app_colors.dart';
import 'utilsdeclaration.dart';
import 'decede.dart';

class InfoConstatation {
  static String Circonstance_du_deces = '';
  static String Cause_du_deces = '';
  static String Date_de_survenue = '';
  static String Lieu_de_survenue = '';
  static String Date_operation = '';
  static String Circonstances_de_survenue = '';
  static String Motif_operation = '';
  static String intervalle = '';
}

class RapportDeDeces extends StatefulWidget {
  const RapportDeDeces({
    Key? key,
  }) : super(key: key);

  @override
  State<RapportDeDeces> createState() => _RapportDeDecesState();
}

class _RapportDeDecesState extends State<RapportDeDeces> {
  bool isHovered = false;
  bool isPressed = false;
  final List<Map<String, String>> _valuesSaisies = [];

  bool _erreurCause = false;
  bool _erreurIntervalle = false;
  bool _erreurTypeIntervalle = false;

  String choice = '';
  String choices = '';
  String? _cause;
  String? _intervalle;

  // ignore: non_constant_identifier_names
  final List<String> _TypeOptionsDecesFemme = [
    'Au cours de grossesse',
    // 'Dans un délai de 42 jours apres la terminaison de la grossesse',
    // 'Plus de 42 jours mais moins d\'un an apres la terminaison de la grossesse ',
  ];
  String? _selectedOptionDeces;

  String _nouveauNeValue = 'Non';
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _intervalleController = TextEditingController();
  final TextEditingController _dateOperationController =
      TextEditingController();
  final TextEditingController _dateDecesController = TextEditingController();
  final TextEditingController _motifOperationController =
      TextEditingController();
  final TextEditingController dateSurvenueController = TextEditingController();

  String? _selectedTypeIntervalle;
  String? _selectedCirconstanceDeces;

  final List<String> _typeIntervalle = ['Années', 'Mois', 'Jours', 'Heures'];
  final List<String> _lieuSurvenue = [
    'Domicile',
    'Etablissement collectif',
    'Ecole/administration public',
    'Lieu de sport',
    'Voie publique',
    'Zone de commerce / service',
    'Local industriel /chantier',
    'Exploitation agricole',
    'Autre'
  ];
  String? _selectedLieuSurvenue;

  final List<String> _circonstanceDeces = [
    'Maladie',
    'Suicide',
    'Accident',
    'Homicide',
    'Intention indéterminée'
  ];

  String get selectedValue {
    return selectedValue;
  }

  bool _tousChampsRemplis() {
    return _causeController.text.isNotEmpty &&
        _intervalleController.text.isNotEmpty &&
        _selectedTypeIntervalle != null;
  }

  void _removeItem(int index) {
    setState(() {
      _valuesSaisies.removeAt(index);
    });
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
                  builder: (context) => const InformationsDecedeForm(),
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
                  buildTabsConstatation(),
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
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
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
                            "Compléter la constatation",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              'Y a-t-il un obstacle médico-légal (OML) dans cette situation?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 54, 54, 54),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 70),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Oui',
                                  groupValue: _nouveauNeValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _nouveauNeValue = value ?? '';
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const Text('Oui',
                                    style: TextStyle(fontSize: 16)),
                                Radio<String>(
                                  value: 'Non',
                                  groupValue: _nouveauNeValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _nouveauNeValue = value ?? '';
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const Text('Non',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(height: 2, color: Colors.black12),
                          const SizedBox(height: 20),
                          const Text(
                            '+Causes de décès',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              children: [
                                buildTextField(
                                  label: 'La cause',
                                  controller: _causeController,
                                  onChanged: (value) {
                                    setState(() {
                                      _cause = value;
                                    });
                                  },
                                ),
                                buildTextField(
                                  label: 'L\'intervalle',
                                  controller: _intervalleController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  onChanged: (value) {
                                    setState(() {
                                      _intervalle = value;
                                    });
                                  },
                                ),
                                // if (_erreurIntervalle)
                                //   const SizedBox(
                                //     height: 7,
                                //   ),
                                // const Text(
                                //   'Ce champ est obligatoire',
                                //   style: TextStyle(
                                //     color: Color.fromARGB(255, 199, 49, 39),
                                //     fontSize: 12,
                                //   ),
                                // ),
                                buildDropdownButtonFormField(
                                  label: 'Unité de l\'intervalle',
                                  items: _typeIntervalle,
                                  value: _selectedTypeIntervalle,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTypeIntervalle = value;
                                    });
                                  },
                                ),
                                // if (_erreurTypeIntervalle)
                                //   const SizedBox(
                                //     height: 7,
                                //   ),
                                // const Text(
                                //   'Ce champ est obligatoire',
                                //   style: TextStyle(
                                //     color: Color.fromARGB(255, 133, 22, 14),
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.only(left: 45, right: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isPressed
                                        ? AppColors.primaryColor
                                        : (isHovered
                                            ? AppColors.primaryColor
                                            : const Color.fromARGB(
                                                255, 82, 53, 43)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _erreurCause = false;
                                      _erreurIntervalle = false;
                                      _erreurTypeIntervalle = false;

                                      if (_causeController.text.isEmpty) {
                                        _erreurCause = true;
                                      }

                                      if (_intervalleController.text.isEmpty) {
                                        _erreurIntervalle = true;
                                      }

                                      if (_selectedTypeIntervalle == null) {
                                        _erreurTypeIntervalle = true;
                                      }

                                      if (_erreurCause ||
                                          _erreurIntervalle ||
                                          _erreurTypeIntervalle) {
                                        return;
                                      }

                                      _valuesSaisies.add({
                                        'Cause': _causeController.text,
                                        'Intervalle':
                                            _intervalleController.text,
                                        'Type d\'intervalle':
                                            _selectedTypeIntervalle ?? '',
                                      });

                                      _causeController.clear();
                                      _intervalleController.clear();
                                      _selectedTypeIntervalle = null;
                                    });
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Ajouter',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (_valuesSaisies.isNotEmpty) ...[
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _valuesSaisies.length,
                                    itemBuilder: (context, index) {
                                      final row = _valuesSaisies[index];
                                      return _buildTableRow(
                                          row['Cause'],
                                          row['Intervalle'],
                                          row['Type d\'intervalle'],
                                          index
                                          );
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(height: 2, color: Colors.black12),
                          const SizedBox(height: 20),
                          const Text(
                            '+Informations complémentaires',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          buildDropdownButtonFormField(
                            label: 'Circonstance du décès',
                            items: _circonstanceDeces,
                            value: _selectedCirconstanceDeces,
                            onChanged: (value) {
                              setState(() {
                                _selectedCirconstanceDeces = value;
                              });
                            },
                          ),
                          const SizedBox(height: 25),
                          Container(height: 2, color: Colors.black12),
                          const SizedBox(height: 20),
                          const Text(
                            '+En cas de cause externe',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          buildDateTextField(
                            label: 'Date du décès',
                            controller: _dateDecesController,
                            onTap: () => _selectedDate(context),
                          ),
                          buildDropdownButtonFormField(
                            label: 'Lieu de survenue',
                            items: _lieuSurvenue,
                            value: _selectedLieuSurvenue,
                            onChanged: (value) {
                              setState(() {
                                _selectedLieuSurvenue = value;
                              });
                            },
                          ),
                          const SizedBox(height: 25),
                          Container(height: 2, color: Colors.black12),
                          const SizedBox(height: 20),
                          const Text(
                            '+Intervention chirurgicale récente',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: const Text(
                              'Une opération a-t-elle été effectuée au cours des 4 dernières semaines?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 54, 54, 54),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 90),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'oui',
                                  groupValue: choice,
                                  onChanged: (value) {
                                    setState(() {
                                      choice = value!;
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const Text(
                                  'Oui',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Radio<String>(
                                  value: 'non',
                                  groupValue: choice,
                                  onChanged: (value) {
                                    setState(() {
                                      choice = value!;
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const Text(
                                  'Non',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          if (choice == 'oui') ...[
                            buildDateTextField(
                              label: 'Date de l\'opération',
                              controller: _dateOperationController,
                              onTap: () => _selectedDate(context),
                            ),
                            const SizedBox(height: 10),
                            buildTextField(
                              label: 'Motif de l\'opération',
                              controller: _motifOperationController,
                            ),
                          ],
                          const SizedBox(height: 20),
                          Container(height: 2, color: Colors.black12),
                          const SizedBox(height: 20),
                          const Text(
                            '+Décès d\'une femme âgée de 12 à 54 ans',
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: const Text(
                              'Le décès est-il survenu pendant une grossesse ou moins d\'un an après sa terminaison?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 54, 54, 54),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 90),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'oui',
                                  groupValue: choices,
                                  onChanged: (value) {
                                    setState(() {
                                      choices = value!;
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const Text(
                                  'Oui',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Radio<String>(
                                  value: 'non',
                                  groupValue: choices,
                                  onChanged: (value) {
                                    setState(() {
                                      choices = value!;
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const Text(
                                  'Non',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          if (choices == 'oui') ...[
                            buildDropdownButtonFormField(
                              label: 'Le décès de la femme est-il survenu',
                              items: _TypeOptionsDecesFemme,
                              value: _selectedOptionDeces,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOptionDeces = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'La grossesse a-t-elle contribué au décès ?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 54, 54, 54),
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 90),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'oui',
                                    groupValue: choices,
                                    onChanged: (value) {
                                      setState(() {
                                        choices = value!;
                                      });
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                  const Text(
                                    'Oui',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Radio<String>(
                                    value: 'non',
                                    groupValue: choices,
                                    onChanged: (value) {
                                      setState(() {
                                        choices = value!;
                                      });
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                  const Text(
                                    'Non',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          Container(
                            margin: const EdgeInsets.only(
                                left: 70, right: 70, top: 20),
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              onPressed: () {
                                InfoConstatation.Cause_du_deces =
                                    _causeController.text;
                                InfoConstatation.intervalle =
                                    _intervalleController.text;
                                InfoConstatation.Date_operation =
                                    _dateOperationController.text;
                                InfoConstatation.Motif_operation =
                                    _motifOperationController.text;
                                InfoConstatation.Date_de_survenue =
                                    dateSurvenueController.text;
                                InfoConstatation.Lieu_de_survenue =
                                    _selectedLieuSurvenue ?? '';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ConfirmDeclaration(),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  'Continuer',
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
        dateSurvenueController.text = picked.toString().split(" ")[0];
        _dateOperationController.text = picked.toString().split(" ")[0];
        _dateDecesController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Widget _buildTableRow(
      String? cause, String? intervalle, String? typeIntervalle, int index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Cause: ${cause ?? ''}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeItem(index),
            ),
          ),
          ListTile(
            title: Text(
              'Intervalle: ${intervalle ?? ''}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Type d\'intervalle: ${typeIntervalle ?? ''}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
