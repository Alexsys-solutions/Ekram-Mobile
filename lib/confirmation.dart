// ignore_for_file: unused_local_variable, duplicate_ignore

import 'package:flutter/material.dart';
import 'declarant.dart';
import 'decede.dart';
import 'deces.dart';
import 'accueil.dart';
import 'utilsdeclaration.dart';
import 'app_colors.dart';
import 'constatation.dart';
class ConfirmDeclaration extends StatelessWidget {
  const ConfirmDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    bool isPressed = false;
    bool isLoading = false;

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
                  builder: (context) => const RapportDeDeces(),
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
                   buildTabsConfirmation(),
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
              child: Column(
                children: [
               
                  Center(
                    child: Container(
                      height: 1600,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Récapulatif et confirmation",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Wrap(
                             
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "+Informations sur le déclarant",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                         color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      buildDeclarantInfo(),
                                      const SizedBox(height: 16),
                                        Container(
                                        height: 1,
                                        width: 250,
                                        color: Colors.black12,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "+Informations sur le décédé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                         color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      buildDeclarantInfoDecede(),
                                      const SizedBox(height: 16),
                                      Container(
                                        height: 1,
                                        width: 250,
                                        color: Colors.black12,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "+Informations sur le décès",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                         color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      buildDeclarantInfoDeces(),
                                      const SizedBox(height: 16),
                                      Container(
                                        height: 1,
                                        width: 250,
                                        color: Colors.black12,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "+Les informations de constatation",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                         color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      buildDeclarantInfoConstatation(),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 1,
                                        width: 250,
                                        color: Colors.black12,
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        margin: const EdgeInsets.only(left: 40,right: 40),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.8,
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.help_outline,
                                                          size: 50,
                                                          color: Color.fromARGB(255, 118, 79, 66),
                                                        ),
                                                        const SizedBox(height: 20),
                                                        const Text(
                                                          'Voulez-vous vraiment soumettre cette demande ?',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 20),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Flexible(
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                                                                ),
                                                                child: const Text(
                                                                  'Annuler',
                                                                  style: TextStyle(color: Colors.black, fontSize: 17),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(width: 10),
                                                            Flexible(
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: const Color.fromARGB(255, 118, 79, 66),
                                                                ),
                                                                child: const Text(
                                                                  'Soumettre',
                                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return Dialog(
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                        ),
                                                                        child: Container(
                                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            borderRadius: BorderRadius.circular(7),
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.check_circle_outline,
                                                                                size: 50,
                                                                                color: Colors.green,
                                                                              ),
                                                                              const SizedBox(height: 20),
                                                                              const Text(
                                                                                'Réussi',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 10),
                                                                              const Text(
                                                                                'La constatation a été ajoutée avec succès',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: 18,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 20),
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: const Color.fromARGB(255, 82, 53, 43),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (context) => const Accueil(userData: {})),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  'Confirmer',
                                                                                  style: TextStyle(color: Colors.white, fontSize: 17),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Center(
                                            child: Text(
                                              'Confirmer',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(child: Container()),
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
      ),
    );
  }
}



Widget buildDeclarantInfo() {
  const commonStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  const variableStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
     color: AppColors.primaryColor,
    
  );

  Widget buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label ', style: commonStyle),
          TextSpan(text: value, style: variableStyle),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRichText('Nom : ', DataHolder.nomDeclarant),
      SizeBoxHeight(),
      buildRichText('Nom en Arabe : ', DataHolder.nomArabeDeclarant),
      SizeBoxHeight(),
      buildRichText('Prénom : ', DataHolder.prenomDeclarant),
      SizeBoxHeight(),
      buildRichText('Prénom en Arabe : ', DataHolder.prenomArabeDeclarant),
      SizeBoxHeight(),
      buildRichText('Type de pièce d\'identité : ', DataHolder.type_piece),
      SizeBoxHeight(),
      buildRichText('Numéro de pièce d\'identité : ', DataHolder.numPieceIdentiteDeclarant),
      SizeBoxHeight(),
      buildRichText('Téléphone : ', DataHolder.telephoneDeclarant),
      SizeBoxHeight(),
      buildRichText('Lien d\'affiliation : ', DataHolder.lien_affiliation),
      SizeBoxHeight(),
    ],
  );
}

Widget SizeBoxHeight() {
  return const SizedBox(
    height: 8,
  );
}

Widget buildDeclarantInfoDecede() {

  const variableStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    
  );
    const commonStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: Colors.black,
     // color: Color.fromARGB(255, 69, 67, 67),
  );



  Widget buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label ', style: commonStyle),
          TextSpan(text: value, style: variableStyle),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRichText('Nom : ', InfoDecede.nomDecede),
      SizeBoxHeight(),
      buildRichText('Nom en Arabe : ', InfoDecede.nomArabeDecede),
      SizeBoxHeight(),
      buildRichText('Prénom : ', InfoDecede.prenomDecede),
      SizeBoxHeight(),
      buildRichText('Prénom en Arabe : ', InfoDecede.prenomArabeDecede),
      SizeBoxHeight(),
      buildRichText('Date de naissance : ', InfoDecede.DateNaiss),
      SizeBoxHeight(),
      buildRichText('Type de pièce d\'identité : ', InfoDecede.typePiece),
      SizeBoxHeight(),
      buildRichText('Numéro de pièce d\'identité : ', InfoDecede.numPieceIdentiteDecede),
      SizeBoxHeight(),
      buildRichText('Nationalité :', InfoDecede.Nationa),
      SizeBoxHeight(),
      buildRichText('Pays de résidence : ', InfoDecede.pays),
      SizeBoxHeight(),
      buildRichText('Préfecture/Province : ', InfoDecede.Province),
      SizeBoxHeight(),
      buildRichText('Commune/Arrondissement :' , InfoDecede.pays),
      SizeBoxHeight(),
      buildRichText('Adresse Habituelle  :', InfoDecede.adresse),
      SizeBoxHeight(),
    ],
  );
}

Widget buildDeclarantInfoDeces() {
  const variableStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    
  );
    const commonStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: Colors.black,
     // color: Color.fromARGB(255, 69, 67, 67),
  );

  Widget buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label ', style: commonStyle),
          TextSpan(text: value, style: variableStyle),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRichText('Date du décès :', InfoDeces.Datedeces),
      SizeBoxHeight(),
      buildRichText('Heure du décès :', InfoDeces.HeurDeces),
      SizeBoxHeight(),
      // buildRichText('Lieu du décès :', InfoDeces.LieuDeces),
      // SizeBoxHeight(),
      buildRichText('Adresse du décès :', InfoDeces.AdresseDeces),
      SizeBoxHeight(),
      // buildRichText('Province :', InfoDeces.ProvinceDeces),
      // SizeBoxHeight(),
      // buildRichText('Commune :', InfoDeces.ArrondissementDeces),
      // SizeBoxHeight(),
      buildRichText('Cimetière d\'enterrement :', InfoDeces.CimetiereDeces),
    ],
  );
}

Widget buildDeclarantInfoConstatation() {
  const variableStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    
  );
    const commonStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: Colors.black,
     // color: Color.fromARGB(255, 69, 67, 67),
  );

  Widget buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label ', style: commonStyle),
          TextSpan(text: value, style: variableStyle),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRichText('Y a-t-il un obstacle médico-légal (OML) dans cette situation? :', ''),
      SizeBoxHeight(),
      buildRichText('Causes de décès :', InfoConstatation.Cause_du_deces),
      SizeBoxHeight(),
      buildRichText('L\'intervalle :', InfoConstatation.intervalle),
      SizeBoxHeight(),
      buildRichText('Circonstance du décès :', ''),
      SizeBoxHeight(),
      buildRichText('Date de survenue :', InfoConstatation.Date_de_survenue),
      SizeBoxHeight(),
      buildRichText('Lieu de survenue :', InfoConstatation.Lieu_de_survenue),
      SizeBoxHeight(),
      buildRichText('Circonstances de survenue :', ''),
      SizeBoxHeight(),
      buildRichText('Une opération a-t-elle été effectuée au cours des 4 dernières semaines? :', ''),
      SizeBoxHeight(),
      buildRichText('Date de l\'opération :', InfoConstatation.Date_operation),
      SizeBoxHeight(),
      buildRichText('Motif de l\'opération :', InfoConstatation.Motif_operation),
    ],
  );
}

