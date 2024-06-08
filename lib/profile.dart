// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  ProfileScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2C3E50),
                Color.fromARGB(255, 219, 198, 173),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(top: 0,bottom: 0),child: 
                      IconButton(
                        icon: const Icon(AntDesign.arrowleft, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),),
                      const Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        child: ImageIcon(
                          AssetImage('pictures/ikram_logo.png'),
                          size: 170,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 0,top: 0), 
                    height: height * 0.3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 120),
                                    Text(
                                      '${userData['firstName']} ${userData['lastName']}',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 49, 32, 26),
                                        fontFamily: 'Nunito',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              right: 20,
                              child: Icon(
                                AntDesign.setting,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: CircleAvatar(
                                  radius: innerWidth * 0.225,
                                  backgroundImage: const AssetImage('pictures/pict_profil.png'),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                  Container(
                    height: height * 0.4,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Profil',
                            style: TextStyle(
                              color: Color.fromARGB(255, 178, 154, 127),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(thickness: 2.5),
                          const SizedBox(height: 25),
                          const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Icon(
                                  AntDesign.user,
                                  color: Color.fromARGB(255, 93, 60, 50),
                                  size: 25,
                                ),
                                 SizedBox(width: 10),
                                Text(
                                  'Constateur de décès',
                                  style:  TextStyle(
                                    color: Color.fromARGB(255, 38, 39, 39),
                                    fontFamily: 'Nunito',
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                           Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    AntDesign.phone,
                                    color: Color.fromARGB(255, 93, 60, 50),
                                    size: 25,
                                    
                                  ),
                                  const SizedBox(width: 10), 
                                  Text(
                                    '${userData['phoneNumber']}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 38, 39, 39),
                                      fontFamily: 'Nunito',
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                                child: const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        AntDesign.mail,
                                        color: Color.fromARGB(255, 93, 60, 50),
                                        size: 25,
                                      ),
                                      SizedBox(width: 10), 
                                      Text(
                                        'constateur.rabat@gmail.com',
                                        style:TextStyle(
                                          color: Color.fromARGB(255, 38, 39, 39),
                                          fontFamily: 'Nunito',
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 13),
                              const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      AntDesign.enviromento,
                                      color: Color.fromARGB(255, 93, 60, 50),
                                      size: 21,
                                      
                                    ),
                                    SizedBox(width: 10), 
                                    Text(
                                      'BCH: Rabat',
                                      style:TextStyle(
                                        color: Color.fromARGB(255, 38, 39, 39),
                                        fontFamily: 'Nunito',
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
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
      ],
    );
  }
}