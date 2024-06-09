import 'dart:async';
import  'package:flutter/material.dart';
import 'login.dart';
import 'declarant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart';
import 'profile.dart';
import 'package:intl/intl.dart';

import 'localisation.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'map.dart';



DateTime today = DateTime.now();
DateTime yesterday = today.subtract(const Duration(days: 1));

String formattedToday = DateFormat('yyyy-MM-dd').format(today);
String formattedYesterday = DateFormat('yyyy-MM-dd').format(yesterday);

class Accueil extends StatelessWidget {
  final Map<String, dynamic> userData;
  const Accueil({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Home(userData: userData),
      ),
    );
  }
}

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('fr');

  Locale get locale => _locale;

  set locale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

class Home extends StatelessWidget {
  final Map<String, dynamic> userData;
  Home({required this.userData});

  final TextEditingController _searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'pictures/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: TabBarView(
              children: [
                _tabBarViewItem1(
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      buildDataFetcher(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SearchDeclaration(),
                const MapScreenn(),
                // Container(),
              ],
            ),
          ),
        ],
      ),
      drawer: SizedBox(
        width: 300,
        child: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('pictures/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 118, 79, 66),
                                radius: 25,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 13),
                              Text(
                                '${userData['firstName']} ${userData['lastName']}',
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 118, 79, 66),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              // CircleAvatar(
                              //   backgroundColor: Colors.white,
                              //   radius: 30,
                              //   child: CircleAvatar(
                              //     backgroundColor: const Color.fromARGB(
                              //         255,
                              //         243,
                              //         238,
                              //         236), 
                              //     radius: 150,
                              //     child: 
                              IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_left,
                                        size: 30,
                                        color: Color.fromARGB(255, 118, 79,
                                            66)), 
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildListTile(
                  icon: Icons.person,
                  title: 'Profile',
                  iconColor: const Color.fromARGB(255, 118, 79, 66),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(userData: userData)),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.settings,
                  title: 'Paramètres',
                  iconColor: const Color.fromARGB(255, 118, 79, 66),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SettingsScreen()), // Remplacez SettingsScreen par l'écran de paramètres réel
                    // );
                  },
                ),
                _buildListTile(
                  icon: Icons.language,
                  title: 'Changer Langue',
                  iconColor: const Color.fromARGB(255, 118, 79, 66),
                  onTap: () {
                    Navigator.pop(context);
                    showLanguageChangeDialog(context);
                  },
                ),
                //  _buildListTile(
                //   icon: Icons.laptop,
                //   title: 'AI',
                //   iconColor: const Color.fromARGB(255, 118, 79, 66),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             MyHomePage()),
                  //   );
                  // },
                // ),
                const SizedBox(height: 260),
                const Divider(
                  color:
                      Color.fromARGB(255, 54, 25, 25), 
                  thickness: 1, 
                  height:
                      1, 
                ),
                _buildListTile(
                  icon: Icons.logout,
                  iconColor: const Color.fromARGB(255, 118, 79, 66),
                  title: 'Se déconnecter',
                  onTap: () {
                    _deconnecter(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 6),
          child: ListTile(
            leading: Icon(icon, color: iconColor),
            title: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void showLanguageChangeDialog(BuildContext context) {
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
                  Icons.language,
                  size: 50,
                  color: Color.fromARGB(255, 118, 79, 66),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Changer de Langue',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choisissez votre langue préférée',
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
                  },
                  child: const Text(
                    'Français',
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
                    'العربية',
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

  Widget _tabBarViewItem1({required Widget child}) {
    return Tab(
      child: child,
    );
  }

  PreferredSizeWidget _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(210),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _boxDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              _topBar(),
              _searchBox(),
              _tabBar(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      gradient: LinearGradient(
        colors: [Colors.white, Color.fromARGB(255, 178, 154, 127)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'pictures/ikram_logo.png',
          width: 170,
          height: 100,
        ),
        Builder(
          builder: (BuildContext context) {
            return MenuButton();
          },
        ),
      ],
    );
  }

  Widget _searchBox() {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: _searchText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: InkWell(
            child: const Icon(Icons.close),
            onTap: () {
              _searchText.clear();
            },
          ),
          hintText: 'Search...',
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return const TabBar(
      labelPadding: EdgeInsets.all(0),
      labelColor: Color.fromARGB(255, 56, 44, 26),
      indicatorColor: Color.fromARGB(255, 56, 44, 26),
      unselectedLabelColor: Color.fromARGB(255, 248, 242, 227),
      tabs: [
        Tab(
          iconMargin: EdgeInsets.all(0),
          icon: Icon(Icons.list, size: 28),
          text: 'Liste',
        ),
        Tab(
          iconMargin: EdgeInsets.all(0),
          icon: Icon(Icons.search, size: 28),
          text: 'Chercher',
        ),
        Tab(
          iconMargin: EdgeInsets.all(0),
          icon: Icon(Icons.location_on, size: 28),
          text: 'Map',
        ),
      ],
    );
  }

  void _deconnecter(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}

class MenuButton extends StatefulWidget {
  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  Color _iconColor = const Color.fromARGB(255, 65, 42, 32);
  bool _isColorChanging = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu, color: _iconColor, size: 35),
      onPressed: () {
        if (!_isColorChanging) {
          setState(() {
            _iconColor = const Color.fromARGB(255, 115, 93, 55);
            _isColorChanging = true;
          });

          Timer(const Duration(seconds: 1), () {
            setState(() {
              _iconColor = const Color.fromARGB(255, 56, 44, 26);
              _isColorChanging = false;
            });
          });

          Scaffold.of(context).openDrawer();
        }
      },
    );
  }
}

Future<List<Map<String, dynamic>>> fetchData() async {
  List<Map<String, dynamic>> allData = [];
  int pageNumber = 1;
  const int pageSize = 10;

  while (true) {
    final response = await http.get(
      Uri.parse(
          'http://98.71.95.115/declaration-api/declarations?AssignmentBCH=1&StatusId=1&DateOfDeathStart=$formattedYesterday&DateOfDeathEnd=$formattedToday '),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InJhYmF0X2NvbnN0YXRldXIiLCJmaXJzdE5hbWUiOiJDb25zdGF0ZXVyIiwibGFzdE5hbWUiOiJSYWJhdCIsInVzZXJJZCI6ImQzYjc1MjhjLWQwNjMtNDMyNC04NWI0LTgxMGM5NjcyN2JhZSIsImFzc2lnbm1lbnRCQ0giOiIxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT2JzZXJ2ZXIiLCJleHAiOjE3MTYyODg1ODAsImlzcyI6InlvdXJfaXNzdWVyIiwiYXVkIjoieW91cl9hdWRpZW5jZSJ9.i8Rr5d7sxX3GHRP4Mtg58sya1tJSniyDYEeVCY65Wuk',
        'X-Pagenumber': pageNumber.toString(),
        'X-Pagesize': pageSize.toString(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody.containsKey('data') && responseBody['data'] is List) {
        final List<Map<String, dynamic>> data = (responseBody['data'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
        allData.addAll(data);
        if (data.length < pageSize) {
          break;
        }
        pageNumber++;
      } else {
        throw Exception('Unexpected response format: ${response.body}');
      }
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
  return allData;
}

Widget buildDataFetcher() {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: fetchData(),
    builder: (context, snapshot) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _buildContent(snapshot),
      );
    },
  );
}

Widget _buildContent(AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
  } else if (snapshot.hasData && snapshot.data != null) {
    final data = snapshot.data!;
    if (data.isNotEmpty) {
      return SizedBox(
        height: 900,
        child: AnimationLimiter(
          child: ListView.builder(
            key: const ValueKey<int>(4),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const InformationsDeclarantForm(),
                            ),
                          );
                        },
                        child: Card(
                          color: const Color.fromARGB(255, 248, 242, 227),
                          elevation: 5,
                          child: ListTile(
                            title: Text(
                              '${item['deceased']?['name'] ?? ''} ${item['deceased']?['firstName'] ?? ''}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Color.fromARGB(255, 93, 60, 50),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Text(
                                  'Distance:',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'N°: ${item['declarationNumber'] ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Date de décès: ${item['death']?['dateOfDeath'] ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Age de défunt: ${item['deceased']?['age'] ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.location_on,
                                size: 30,
                                color: Color.fromARGB(255, 118, 79, 66),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MapScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const Padding(
        key: ValueKey<int>(0),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Pas de déclaration trouvée ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 118, 79, 66)),
                ),
                SizedBox(width: 5),
                Icon(
                  size: 30,
                  Icons.help_outline,
                  color: Color.fromARGB(255, 91, 22, 17),
                ),
              ],
            ),
          ],
        ),
      );
    }
  } else {
    return const Center(child: Text('No data available'));
  }
}
