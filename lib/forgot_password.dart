import 'package:flutter/material.dart';
import 'recupere_password.dart';
import 'utilspassword.dart';

// ignore: camel_case_types
class Reset_Password extends StatefulWidget {
  const Reset_Password({super.key});

  @override
  State<Reset_Password> createState() => _Reset_PasswordState();
}

// ignore: camel_case_types
class _Reset_PasswordState extends State<Reset_Password> {
  final TextEditingController resetemail = TextEditingController();

  bool isHovered = false;
  bool isPressed = false;
  bool isLoading = false;

  void _navigateToNextPage(BuildContext context) {
   
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Recupere_pass()));
    });
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCircleButton(
                      '1', const Color.fromARGB(255, 118, 79, 66)),
                  buildContainer(),
                  buildCircleButton(
                      '2', const Color.fromARGB(255, 171, 167, 165)),
                  buildContainer(),
                  buildCircleButton(
                      '3', const Color.fromARGB(255, 171, 167, 165)),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Récupération de mot de passe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 118, 79, 66),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Pour réinitialiser votre mot de passe, veuillez fournir les informations suivantes :',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller: resetemail,
                  decoration: const InputDecoration(
                    labelText: 'Adresse e-mail *',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 69, 67, 67),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF014a71)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF014a71)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      backgroundColor: isPressed
                          ? const Color.fromARGB(255, 118, 79, 66)
                          : (isHovered
                              ? const Color.fromARGB(255, 118, 79, 66)
                              : const Color.fromARGB(255, 118, 79, 66)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                        isLoading = true;
                      });
                      _navigateToNextPage(context);
                    },
                    onHover: (hovered) {
                      setState(() {
                        isHovered = hovered;
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: !isLoading,
                          child: const Text(
                            'Suivant',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isLoading,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
