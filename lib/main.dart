import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget Root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFececec)),
      home: const MyHomePage(title: 'Pokemon App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Pokemon Data
  late List<dynamic> pokeList;
  late List<dynamic> typeList;

  // Execute API Req
  @override
  void initState() {
    super.initState();
    getData();
  }

  getType(String name) async {
    try {
      var responseType =
          await Dio().get('https://pokeapi.co/api/v2/type/$name/');
      if (responseType.statusCode == 200) {
        setState(() {
          pokeList = responseType.data['results'] as List;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // API Handler
  void getData() async {
    try {
      var responsePoke = await Dio().get('https://pokeapi.co/api/v2/pokemon');
      if (responsePoke.statusCode == 200) {
        setState(() {
          pokeList = responsePoke.data['results'] as List;
        });
      } else {
        // ignore: avoid_print
        print(responsePoke.statusCode);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // Make First Letter Of Text Capitalize
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFececec),
          foregroundColor: const Color(0xFFececec),
          title: Row(
            children: [
              Image.asset(
                'images/pokemon.png',
                width: 80,
              ),
              const Spacer(),
              const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30.0,
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(25.0),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pokemon Library",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(pokeList.length, (int index) {
                  return Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xFF2fcea7),
                      ),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Column(
                          children: [
                            Text(
                              capitalizeFirstLetter(pokeList[index]['name']),
                              style: GoogleFonts.inter(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Image.network(
                              'https://img.pokemondb.net/sprites/sword-shield/icon/${pokeList[index]['name']}.png',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.18,
                              filterQuality: FilterQuality.none,
                            )
                          ],
                        ),
                      ));
                }),
              ))
            ],
          ),
        ));
  }
}
