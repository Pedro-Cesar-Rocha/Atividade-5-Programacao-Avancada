import 'package:flutter/material.dart';

import '../models/categorias.dart';
import '../models/produto.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  String? _categoria;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _confirmar() {
    if (!_formKey.currentState!.validate()) return;

    final preco =
        double.parse(_precoController.text.trim().replaceAll(',', '.'));
    final produto = Produto(
      nome: _nomeController.text.trim(),
      preco: preco,
      categoria: _categoria!,
    );
    Navigator.pop(context, produto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) => (valor == null || valor.trim().isEmpty)
                    ? 'Informe o nome do produto'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  final preco =
                      double.tryParse((valor ?? '').trim().replaceAll(',', '.'));
                  if (preco == null || preco < 0) {
                    return 'Informe um preço válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _categoria,
                    isExpanded: true,
                    hint: const Text('Selecione a categoria'),
                    items: categorias
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Row(
                              children: [
                                Icon(iconeDaCategoria(c)),
                                const SizedBox(width: 12),
                                Text(c),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (valor) => setState(() => _categoria = valor),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_categoria == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Selecione uma categoria'),
                        ),
                      );
                      return;
                    }
                    _confirmar();
                  },
                  child: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
