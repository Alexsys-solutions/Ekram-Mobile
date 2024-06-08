import 'package:flutter/material.dart';
// ignore: unused_import
import 'change_password.dart';
import 'utilspassword.dart';

// ignore: camel_case_types
class Recupere_pass extends StatefulWidget {
  const Recupere_pass({super.key});

  @override
  State<Recupere_pass> createState() => _Recupere_passState();
}

// ignore: camel_case_types
class _Recupere_passState extends State<Recupere_pass> {
  final TextEditingController resetcode = TextEditingController();

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
                      '2', const Color.fromARGB(255, 118, 79, 66)),
                  buildContainer(),
                  buildCircleButton(
                      '3', const Color.fromARGB(255, 171, 167, 165)),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Récupération de mot de passe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 118, 79, 66),
                ),
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Row(
                  children: List.generate(6, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey), 
                          borderRadius:
                              BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          controller:
                              resetcode, 
                          maxLength:
                              1, 
                          textAlign: TextAlign.center, 
                          keyboardType:
                              TextInputType.number, 
                          decoration: const InputDecoration(
                            counterText: "", 
                            border: InputBorder.none, 
                            hintText: "*", 
                            hintStyle: TextStyle(
                                color: Colors
                                    .grey),
                            contentPadding:
                                EdgeInsets.zero, 
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                             
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    );
                  }),
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

  Widget _buildCircleButton(String text, Color color) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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
}
