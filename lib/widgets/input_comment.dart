import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class InputComment extends StatefulWidget {
  final int id;
  const InputComment({super.key, required this.id});

  @override
  State<InputComment> createState() => _InputCommentState();
}

class _InputCommentState extends State<InputComment> {
  final _formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();
  late FocusNode _textFocus;

  _printText() {
    print('El texto del input es: ${_myController.text}');
  }

  @override
  void initState() {
    _myController.addListener(_printText);
    _textFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //autofocus: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.comment),
                //prefixIcon: Icon(Icons.comment),
                //suffixIcon: Icon(Icons.close),
                hintText: 'Ingresar comentario',
                labelText: 'Comentario',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El comentario es requerido';
                }
                return null;
              },
              controller: _myController,
              focusNode: _textFocus,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  //Funcion o elemento para cambiar de NULLABLE a NO-NULLABLE
                  if(_formKey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        /*action: SnackBarAction(
                          label: 'Undo', 
                          onPressed: (){},
                        ),*/
                        content: Text('Agregando comentario')
                      )
                    );
                    print(
                      'El valor del comentario del pokemon id: ${widget.id} es: ${_myController.text}'
                    );
                    Provider.of<PokemonProvider>(context, listen: false).
                      addCommentToPokemon(widget.id, _myController.text);
                    _myController.text='';
                  }
                }, 
                child: const Text('Submit')
              ),
              OutlinedButton(
                onPressed: () {
                  _textFocus.requestFocus();
                },
                child: const Text('Set Focus')
              )
            ]
          ),
        ]
      ),
    );
  }
}
