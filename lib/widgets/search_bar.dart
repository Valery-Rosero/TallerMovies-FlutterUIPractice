import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  const AppSearchBar({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.black26, fontWeight: FontWeight.w500),
          // Icono a la derecha como en la maqueta
          suffixIcon: Icon(Icons.search, color: theme.colorScheme.secondary),
          filled: true,
          // Gris muy sutil para que se perciba apenas
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
      ),
    );
  }
}