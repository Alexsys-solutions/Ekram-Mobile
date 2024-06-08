import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget buildCircleButton(String text, Color color) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget buildDivider() {
  return Container(
    width: 29,
    height: 2,
    color: const Color(0xFFc9b079),
  );
}

Widget buildTabsdecede() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton('3', const Color.fromARGB(255, 82, 53, 43)),
        buildDivider(),
        buildCircleButton('4', const Color.fromARGB(255, 189, 184, 182)),
        buildDivider(),
        buildCircleButton('5', const Color.fromARGB(255, 189, 184, 182)),
      ],
    ),
  );
}

Widget buildTextField({
  required String label,
  required TextEditingController controller,
  bool isValid = true,
  TextInputType? keyboardType,
  void Function(String)? onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: '$label ${isValid ? '*' : ''}',
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 69, 67, 67),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
            ),
          ),
        ),
        if (!isValid)
          const Padding(
            padding: EdgeInsets.only(top: 4, left: 4),
            child: Text(
              'Ce champ est obligatoire',
              style: TextStyle(
                color: Color.fromARGB(255, 199, 49, 39),
                fontSize: 12,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget buildDateTextField(
    {required String label,
    required TextEditingController controller,
    required VoidCallback onTap}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: '$label *',
        filled: true,
        fillColor: Colors.transparent,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 69, 67, 67),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    ),
  );
}

Widget buildDropdownButtonFormField({
  required String label,
  required List<String> items,
  required String? value,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    padding: const EdgeInsets.only(right: 22, left: 22),
    child: DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: '$label *',
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 69, 67, 67),
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF014a71),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF014a71)),
        ),
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

Widget buildCircleButton2(Icon icon) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 189, 184, 182),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
        ],
      ),
    ),
  );
}

Future<Map<String, dynamic>?> fetchData() async {
 
  final response = await http.get(
    Uri.parse(
        'http://98.71.95.115/orchestrator-api/processings/declaration-details/e40a702c-aeb7-4ad6-b81e-c81ca3d7839f?assignmentBCH=1'),
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InJhYmF0X2NvbnN0YXRldXIiLCJmaXJzdE5hbWUiOiJDb25zdGF0ZXVyIiwibGFzdE5hbWUiOiJSYWJhdCIsInVzZXJJZCI6ImQzYjc1MjhjLWQwNjMtNDMyNC04NWI0LTgxMGM5NjcyN2JhZSIsImFzc2lnbm1lbnRCQ0giOiIxIiwicmVzcG9uc2libGVCY2hJZHMiOiIxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT2JzZXJ2ZXIiLCJleHAiOjE3MTc4NTg3NjIsImlzcyI6InlvdXJfaXNzdWVyIiwiYXVkIjoieW91cl9hdWRpZW5jZSJ9.X453k8sdzsG7ay6h9IyBQGfUTWmG1vg6ckd6DiwcEJg',
    },
  );
  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    return json.decode(response.body);
  } else {
    print('Failed to load data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load data');
  }
}

Widget buildDropdown(String label, List<dynamic> options) {
  return Container(
    padding: const EdgeInsets.only(right: 22, left: 22),
    child: DropdownButtonFormField<String>(
      value: null,
      onChanged: (value) {},
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
          fontWeight: FontWeight.w800,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF014a71)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF014a71)),
        ),
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

Widget buildTextField2({
  required String label,
  required TextEditingController controller,
  bool isValid = true,
  bool isArabicRequired = false,
  TextInputType? keyboardType,
  void Function(String)? onChanged,
}) {
  final isArabic = estArabe(texte: controller.text);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: '$label ${isValid ? '*' : ''}',
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 69, 67, 67),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF014a71)),
            ),
          ),
        ),
        if (!isValid)
          const Padding(
            padding: EdgeInsets.only(top: 4, left: 4),
            child: Text(
              'Ce champ est obligatoire',
              style: TextStyle(
                color: Color.fromARGB(255, 199, 49, 39),
                fontSize: 12,
              ),
            ),
          ),
        if (!isArabic && controller.text.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 4, left: 4),
            child: Text(
              'Ce champ doit être en arabe',
              style: TextStyle(
                color: Color.fromARGB(255, 199, 49, 39),
                fontSize: 12,
              ),
            ),
          ),
      ],
    ),
  );
}

bool estArabe({required String texte}) {
  final test = RegExp(r'^[\u0621-\u064A\u0660-\u0669\s\d]+$').hasMatch(texte);
  return test;
}

Widget buildTabsdeces() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton('2', const Color.fromARGB(255, 82, 53, 43)),
        buildDivider(),
        buildCircleButton('3', const Color.fromARGB(255, 189, 184, 182)),
        buildDivider(),
        buildCircleButton('4', const Color.fromARGB(255, 189, 184, 182)),
        buildDivider(),
        buildCircleButton('5', const Color.fromARGB(255, 189, 184, 182)),
      ],
    ),
  );
}

Widget buildTabsdeclarant() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCircleButton('1', const Color.fromARGB(255, 82, 53, 43)),
        buildDivider(),
        buildCircleButton('2', const Color.fromARGB(255, 189, 184, 182)),
        buildDivider(),
        buildCircleButton('3', const Color.fromARGB(255, 189, 184, 182)),
        buildDivider(),
        buildCircleButton('4', const Color.fromARGB(255, 189, 184, 182)),
        buildDivider(),
        buildCircleButton('5', const Color.fromARGB(255, 189, 184, 182)),
      ],
    ),
  );
}

Widget buildTabsConstatation() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton('4', const Color.fromARGB(255, 82, 53, 43)),
        buildDivider(),
        buildCircleButton('5', const Color.fromARGB(255, 189, 184, 182)),
      ],
    ),
  );
}

Widget buildTabsConfirmation() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton2(const Icon(
          Icons.verified,
          size: 27,
        )),
        buildDivider(),
        buildCircleButton('5', const Color.fromARGB(255, 82, 53, 43)),
      ],
    ),
  );
}


// Widget filePickerDemo(BuildContext context) {
//   String? _fileName;
//   String? _path;
//   String? _imageUrl;

//   void _openFileExplorer() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();

//       if (result != null) {
//         File file = File(result.files.single.path!);
//         _fileName = file.path.split('/').last;
//         _path = result.files.single.path!;
//         _imageUrl = _path;
//       }
//     } catch (e) {
//       // print("Error picking file: $e");
//     }
//   }

//   void _showImage() {
//     if (_path != null) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           content: Image.file(File(_path!)),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Fermer'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       ElevatedButton.icon(
//         onPressed: _openFileExplorer,
//         icon: const Icon(Icons.file_upload),
//         label: const Text('Sélectionner un fichier'),
//       ),
//       const SizedBox(height: 20),
//       if (_fileName != null)
//         Column(
//           children: [
//             Text(
//               'Nom du fichier: $_fileName\nChemin: $_path',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _showImage,
//               child: const Text('Afficher l\'image'),
//             ),
//           ],
//         ),
//     ],
//   );
// }






// Widget buildDropdownSearchFormField({
//   required String label,
//   required List<String> items,
//   required String? value,
//   required ValueChanged<String?> onChanged,
// }) {
//   return Container(
//     padding: const EdgeInsets.only(right: 22, left: 22, top: 10),
//     child: DropdownSearch<String>(
//       popupProps: const PopupProps.dialog(
//         showSearchBox: true,
//         searchFieldProps: TextFieldProps(
//           decoration: InputDecoration(
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Color(0xFF014a71),
//               ),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFF014a71)),
//             ),
//             labelText: "Recherche",
//             labelStyle: TextStyle(
//               color: Color.fromARGB(255, 69, 67, 67),
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//       items: items,
//       selectedItem: value,
//       onChanged: onChanged,
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           labelText: '$label *',
//           labelStyle: const TextStyle(
//             color: Color.fromARGB(255, 69, 67, 67),
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//           border: const UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xFF014a71),
//             ),
//           ),
//           focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Color(0xFF014a71)),
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Veuillez sélectionner une option';
//         }
//         return null;
//       },
//     ),
//   );
// }

