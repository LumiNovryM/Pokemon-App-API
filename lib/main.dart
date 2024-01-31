import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFececec),
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
                children: List.generate(10, (index) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xFF2fcea7),
                    ),
                    child: Text(
                      'Item ${index + 1}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }),
              ))
            ],
          ),
        ));
  }
}
