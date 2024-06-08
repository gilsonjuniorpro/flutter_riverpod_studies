import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder:(context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.05),
              child: Column(
                children: [
                  Image.asset(allProducts[index].image, width: 60, height: 60),
                  Text(allProducts[index].title),
                  Text('£${allProducts[index].price}'),
                  const Spacer(),
                  if (cartProducts.contains(allProducts[index]))
                    FilledButton(
                      onPressed: () {
                        ref.read(cartNotifierProvider.notifier)
                          .removeProduct(allProducts[index]);
                      },
                      child: const Text('Remove'),
                    ),

                  if (!cartProducts.contains(allProducts[index]))
                    FilledButton(
                      onPressed: () {
                        ref.read(cartNotifierProvider.notifier)
                          .addProduct(allProducts[index]);
                      },
                      child: const Text('Add to Cart'),
                    ),
                ]
              )
            );
          },
        ),
      ),
    );
  }
}
