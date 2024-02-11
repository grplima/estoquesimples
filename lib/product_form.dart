// product_form.dart
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product_list.dart';
import 'product_model.dart';


class ProductForm extends StatefulWidget {
  final Product? editingProduct;

  ProductForm({this.editingProduct});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController _gtinController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.editingProduct != null) {
      _gtinController.text = widget.editingProduct!.gtin.toString();
      _descricaoController.text = widget.editingProduct!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _gtinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'GTIN'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveProduct();
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProduct() {
    int gtin = int.parse(_gtinController.text);
    String descricao = _descricaoController.text;

    Product product = Product(
      id: widget.editingProduct?.id ?? 0,
      gtin: gtin,
      descricao: descricao,
    );

    if (widget.editingProduct != null) {
      DatabaseHelper.instance.updateProduct(product);
    } else {
      DatabaseHelper.instance.insertProduct(product);
    }
  }
}
