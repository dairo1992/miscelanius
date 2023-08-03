import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}

final menuitems = <MenuItem>[
  MenuItem("Giroscopio", Icons.downloading_outlined, "/gyroscope"),
  MenuItem("Acelerometro", Icons.speed, "/acelerometer"),
  MenuItem("Magnetometro", Icons.explore_outlined, "/magnetometer"),
  MenuItem("Giroscopio Ball", Icons.sports_baseball_outlined, "/gyroscope-Ball"),
  MenuItem("Brujula", Icons.location_on_outlined, "/compass"),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: menuitems
            .map((item) => HomeMenuItem(
                title: item.title, icon: item.icon, route: item.route))
            .toList());
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColor;

  const HomeMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.route,
      this.bgColor = const [Colors.lightBlue, Colors.blue]});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: bgColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: 300,
                height: 27,
                // color: Colors.black,
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 11)))
          ],
        ),
      ),
    );
  }
}
