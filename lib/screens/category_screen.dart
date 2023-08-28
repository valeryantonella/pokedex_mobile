import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:pokedex_mobile/screens/login.dart';
import 'package:pokedex_mobile/widgets/category_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String lastUpdate = 'N/A';

  Future<void> updateLastSyncDate(String lastSync) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString("last_sync", lastSync);
  }

  Future<String?> getLastSyncDate() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString("last_sync");
  }

  @override
  void initState() {
    getLastSyncDate().then((value) => {
          setState(() {
            print("LastSync: $lastUpdate");
            lastUpdate = value ?? 'N/A';
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CategoryProvider>(context, listen: false)
                    .initializeCategories();
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false).clearList();
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<LoginProvider>(context, listen: false).logout();
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          )
        ],
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("TIPOS DE POKEMON"),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
          child: Center(
            child: Text(
              '¡Bienvenido a Pokedex, ${Provider.of<LoginProvider>(context, listen: false).user?.email}!',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Card(
                elevation: 10,
                child:
                    Center(child: Text("Ultima sincronizacion: $lastUpdate"))),
          ),
        ),
        const Expanded(child: CategoryListWidget())
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CategoryProvider>(context, listen: false)
              .addCategory("Fire");

          setState(() {
            lastUpdate = DateTime.now().toIso8601String();
            updateLastSyncDate(lastUpdate);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
