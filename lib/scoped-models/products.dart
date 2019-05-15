import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

import './connected_products.dart';

mixin ProductsModel on ConnectedProducts {


  bool _showFavorites = false;

  List<Product> get allProducts {
    //para myproductsmodel.products
    return List.from(products); //regresa un pointer a una nueva lista
    // en memoria, para eso, si editamos esta lista, no editariamos la original, es lo que queremos
    //si hacemos return _products; se regresa la direccion de la lista de productos original D:
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return products[selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }



  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        username: selectedProduct.username,
        userid: selectedProduct.userid
    );
    products[selectedProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
    notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
  }

  void selectProduct(int index) {
    selProductIndex = index;
    notifyListeners();
  }

  void toggleFavoriteProduct() {
    final bool isCurrentlyFavorite =
        products[selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        //unnmutable way, best way
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        username: selectedProduct.username,
        userid: selectedProduct.userid,
        isFavorite: newFavoriteStatus,);
    products[selectedProductIndex] = updateProduct;
    notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
    selProductIndex = null;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
