import 'package:flutter/material.dart';
import 'utilspassword.dart';

class Change_passwd extends StatefulWidget {
  const Change_passwd({super.key});

  @override
  State<Change_passwd> createState() => _Change_passwdState();
}

class _Change_passwdState extends State<Change_passwd> {
  final TextEditingController change_password= TextEditingController();
  final TextEditingController confirm_password= TextEditingController();

  bool isHovered = false;
  bool isPressed = false;
  bool isLoading = false;

  void _navigateToNextPage(BuildContext context) {
   
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Change_passwd()));
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
                      '1', const Color.fromARGB(255, 171, 167, 165)),
                  buildContainer(),
                  buildCircleButton(
                      '2', const Color.fromARGB(255, 171, 167, 165)),
                  buildContainer(),
                  buildCircleButton(
                      '3', const Color.fromARGB(255, 118, 79, 66)),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Récupération de mot de passe',
                style: TextStyle(
                  fontSize: 20,
                    color: const Color.fromARGB(255, 118, 79, 66),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Center(
                  child: Text(
                    'Veuillez saisir le code :',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height:10),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  children: [
                  TextFormField(
                  controller: change_password,
                
                  decoration: const InputDecoration(
                    labelText: 'Nouveau mot de passe*',
                    prefixIcon: Icon(Icons.lock),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 69, 67, 67),
                      fontSize: 16,
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
                    const SizedBox(height: 10),
                    TextFormField(
                  controller: change_password,
                
                  decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe *',
                    prefixIcon: Icon(Icons.lock),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 69, 67, 67),
                      fontSize: 17,
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
                  ],
                ),
              ),
              const SizedBox(height: 45),
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
