import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class PokemonScreenWidget extends StatefulWidget {
  const PokemonScreenWidget({super.key});

  @override
  State<PokemonScreenWidget> createState() => _PokemonScreenWidgetState();
}

class _PokemonScreenWidgetState extends State<PokemonScreenWidget> {
  bool isSearch = false;

  var textSearchController = TextEditingController();

  @override
  void initState(){
    textSearchController.addListener(_searchPokemons);
    super.initState();
  }

  _clearSearch(){
    Provider.of<PokemonProvider>(context, listen: false)
            .checkPokemons();
  }

  _searchPokemons(){
    if(textSearchController.text.isNotEmpty){
      Provider.of<PokemonProvider>(context, listen: false)
              .searchPokemonByName(textSearchController.text);
    }else{
      _clearSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
                _clearSearch();
              });
            }, 
            icon: const Icon(Icons.search)
          )
        ],
        title:  !isSearch 
          ? const Text('Pokemons') 
          : TextField(
              controller: textSearchController,
              decoration: InputDecoration(
                hintText: 'Buscar',
                icon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    textSearchController.text = '';
                    _clearSearch();
                  }, 
                  icon: const Icon(Icons.cancel)
                ) 
              ),
            ),

      ),
      body: FutureBuilder(
        future: Provider.of<PokemonProvider>(context, listen: false).checkPokemons(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            //Cuando la llmada al metodo async se ejecuta
            return const PokemonList();
          }else{
            //Cuando la llamada al metodo async se inicia (en proceso)
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
    );
  }
}

