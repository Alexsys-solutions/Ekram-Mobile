import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Accueil.dart';
import 'forgot_password.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'app_colors.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isHovered = false;
  bool isPressed = false;
  bool showUsernameError = false;
  bool showPasswordError = false;
  String usernameErrorMessage = '';
  String passwordErrorMessage = '';
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isArabic = false;
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
//  void initState() {
//     super.initState();
//     _checkLocationPermission();
//   }

//   Future<void> _checkLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//     }
//   }

  // Future<void> _obtainLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Geolocator.openLocationSettings();
  //   } else {
  //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //     print('Position: ${position.latitude}, ${position.longitude}');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("pictures/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: _buildWidgets(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> _buildWidgets(BuildContext context) {
    return [
      Image.asset('pictures/ikram_logo.png', height: 180, width: 290),
      const SizedBox(height: 45),
      TextField(
        controller: usernameController,
        focusNode: usernameFocusNode,
        decoration: InputDecoration(
          hintText: isArabic ? 'اسم المستخدم' : 'Nom d\'utilisateur',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          prefixIcon: const Icon(Icons.person),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: showUsernameError ? usernameErrorMessage : null,
          suffixIcon: showUsernameError
              ? const Icon(Icons.error, color: Color.fromARGB(255, 173, 52, 43))
              : null,
        ),
      ),
      const SizedBox(height: 19),
      TextField(
        controller: passwordController,
        focusNode: passwordFocusNode,
        decoration: InputDecoration(
          hintText: isArabic ? 'كلمة السر' : 'Mot de passe',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: showPasswordError ? passwordErrorMessage : null,
        ),
        obscureText: obscurePassword,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Reset_Password()),
              );
            },
            child: Text(
              isArabic ? 'هل نسيت كلمة السر؟' : 'Mot de passe oublié ?',
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 60, 59, 58),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 25),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isPressed
                  ? AppColors.primaryColor
                  : (isHovered ? const Color.fromARGB(255, 118, 79, 66) : const Color.fromARGB(255, 118, 79, 66)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: Size(MediaQuery.of(context).size.width, 59),
            ),
            onPressed: isLoading ? null : _handleLogin,
            child: isLoading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                       SizedBox(width: 16),
                      Text(
                        'Veuillez patienter',
                        style:  TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                : Text(
                    isArabic ? 'تسجيل الدخول' : 'Se Connecter',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          setState(() {
            isArabic = !isArabic;
          });
        },
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
            'pictures/maroc.png', 
            width: 50, 
            height: 50, 
          ),
           const SizedBox(width: 5), 
          Text(
            isArabic ? 'Français' : 'العربية',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
      ),
    ],
  ),
        
      ),
    ];
  }

  void _handleLogin() async {
    setState(() {
      isPressed = !isPressed;
      isLoading = true;
    });

    if (usernameController.text.isEmpty) {
      setState(() {
        showUsernameError = true;
        usernameErrorMessage = isArabic
            ? '.الرجاء إدخال اسم المستخدم الخاص بك'
            : 'Veuillez saisir votre nom d\'utilisateur.';
        isLoading = false;
      });
    } else {
      setState(() {
        showUsernameError = false;
      });
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        showPasswordError = true;
        passwordErrorMessage = isArabic
            ? '.الرجاء إدخال كلمة المرور الخاصة بك'
            : 'Veuillez saisir votre mot de passe.';
        isLoading = false;
      });
    } else {
      setState(() {
        showPasswordError = false;
      });
    }

    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      await callApi(context);
      
   
    }
    

    setState(() {
      isLoading = false;
    });

    // _showEnableLocationDialog( context);
  }

Future<void> callApi(BuildContext context) async {
  const String apiUrl = 'http://98.71.95.115/authentication-api/users/login';

  try {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (kDebugMode) {
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (kDebugMode) {
        print('Response Body: $responseBody');
      }
      final Map<String, dynamic> userData = responseBody['user'];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accueil(userData: userData)),
      );
      _showEnableLocationDialog( context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.error,
                    size: 50,
                     color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Erreur d\'authentification',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nom d\'utilisateur ou mot de passe incorrect',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor ,
                      iconColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('Erreur lors de l\'appel de l\'API: $e');
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.error,
                  size: 50,
                  color: AppColors.primaryColor ,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Erreur de connexion',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Une erreur s\'est produite lors de l\'appel de l\'API. Veuillez réessayer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    iconColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



void  _showEnableLocationDialog(BuildContext context){
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                 Icons.location_on, 
                  size: 50,
                  color: Color.fromARGB(255, 118, 79, 66),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Activer la localisation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Veuillez activer la localisation pour utiliser cette fonctionnalité. Cliquez sur le lien pour activer la localisation dans les paramètres de votre téléphone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 118, 79, 66),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                  ),
                 onPressed: () {
                Navigator.of(context).pop();
                // _obtainLocation();
              },
                  child: const Text(
                    'Activer ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                    iconColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 30.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Annuler',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
}


  

  void _openLocationSettings(BuildContext context) async {
    const url = 'app-settings:';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Impossible d'ouvrir les paramètres de localisation."),
        ),
      );
    }
  }
}
