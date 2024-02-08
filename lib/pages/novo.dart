import 'package:estoquesimples/model/produto.dart';
import 'package:estoquesimples/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Novo extends StatefulWidget {
  Novo({super.key, this.produto});

  Produto? produto;

  @override
  State<Novo> createState() => _NovoState();
}

class _NovoState extends State<Novo> {
  final _gtinController = TextEditingController();
  final _descricaoController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _esdatoCivilController = CustomSwitchController();
  final _formKey = GlobalKey<FormState>();

  @override
  initState(){
    if(widget.produto != null){
      Produto produto = widget.produto!;
      _gtinController.text = produto.gtin ?? '';
      _descricaoController.text = produto.descricao ?? '';
    }
  }

  _getTextField(
      {required String label,
        required String hint,
        required final controller,
        List<TextInputFormatter>? textInputFormatterList,
        String? Function(String? value)? validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: textInputFormatterList,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        validator: validator,
      ),
    );
  }

  String? _validaGtin(String? value) {
    if (value != null && value.isEmpty) {
      return 'Campo inválido';
    }
  }

  _esconderTeclado() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _clickSalvar() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Salvar?'),
          content: Text('Tem certeza que deseja salvar?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _salvar();
                },
                child: Text('Salvar')),
          ],
        ),
      );
    }
  }

  _salvar() {
    String campoGtin = _gtinController.text;
    String campoDescricao = _descricaoController.text;
    // String campoEmail = _emailController.text;
    // bool chaveEstadoCivil = _esdatoCivilController.selected;

    Produto produto = Produto(
      gtin: campoGtin,
      descricao: campoDescricao,
      // email: campoEmail,
      // estadoCivil: chaveEstadoCivil,
    );
    if(widget.produto != null) {
      produto.produto_id = widget.produto!.produto_id;
    }

    Navigator.pop(context, produto);
  }

  // var maskFormatter = MaskTextInputFormatter(
  //     mask: '(##) #####-####',
  //     filter: {"#": RegExp(r'[0-9]')},
  //     type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    String title = widget.produto == null ? 'Novo' : 'Editar';
    return Scaffold(
      appBar: AppBar(
        title: Text( title ),
      ),
      backgroundColor: Colors.grey[200],
      body: GestureDetector(
        onTap: () {
          _esconderTeclado();
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0), //<-- SEE HERE
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _getTextField(
                                    label: 'Gtin',
                                    hint: 'Informe seu GTIN',
                                    controller: _gtinController,
                                    validator: _validaGtin),
                                _getTextField(
                                    label: 'Descricao',
                                    hint: 'Informe a descricao',
                                    controller: _descricaoController),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: _clickSalvar,
                                          child: Text('Salvar'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
