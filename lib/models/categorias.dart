import 'package:flutter/material.dart';

const Map<String, IconData> iconesPorCategoria = {
  'Eletrônicos': Icons.devices,
  'Roupas': Icons.checkroom,
  'Alimentos': Icons.restaurant,
  'Livros': Icons.menu_book,
  'Esportes': Icons.sports_soccer,
  'Casa': Icons.chair,
};

List<String> get categorias => iconesPorCategoria.keys.toList();

IconData iconeDaCategoria(String categoria) =>
    iconesPorCategoria[categoria] ?? Icons.category;
