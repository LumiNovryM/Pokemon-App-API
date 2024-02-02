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
  late List<dynamic> jsonList;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get('https://pokeapi.co/api/v2/pokemon');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data['results'] as List;
        });
      } else {
        // ignore: avoid_print
        print(response.statusCode);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
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
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(jsonList.length, (int index) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xFF2fcea7),
                    ),
                    child: Text(jsonList[index]['name']),
                  );
                }),
              ))
            ],
          ),
        ));
  }
}
