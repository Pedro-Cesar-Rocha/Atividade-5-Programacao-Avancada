import 'package:flutter/material.dart';

import '../models/categorias.dart';
import '../models/produto.dart';
import 'cadastro_produto_screen.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Produto> _produtos = [
    const Produto(nome: 'Smartphone', preco: 1999.90, categoria: 'Eletrônicos'),
    const Produto(nome: 'Camiseta', preco: 59.90, categoria: 'Roupas'),
    const Produto(nome: 'Café 500g', preco: 24.50, categoria: 'Alimentos'),
    const Produto(nome: 'Dom Casmurro', preco: 34.90, categoria: 'Livros'),
  ];

  String _formatarPreco(double preco) =>
      'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';

  void _comprar(Produto produto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${produto.nome} foi adicionado ao carrinho'),
        ),
      );
  }

  Future<void> _abrirCadastro() async {
    final novo = await Navigator.push<Produto>(
      context,
      MaterialPageRoute(builder: (_) => const CadastroProdutoScreen()),
    );
    if (novo != null) {
      setState(() => _produtos.add(novo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Produtos')),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final produto = _produtos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(iconeDaCategoria(produto.categoria)),
              ),
              title: Text(produto.nome),
              subtitle: Text(_formatarPreco(produto.preco)),
              trailing: ElevatedButton(
                onPressed: () => _comprar(produto),
                child: const Text('Comprar'),
              ),
              onTap: () => _comprar(produto),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        tooltip: 'Cadastrar produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
