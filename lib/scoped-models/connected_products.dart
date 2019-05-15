import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProducts on Model {
  List<Product> products = [];
  int selProductIndex;
  User authenticatedUser;

  void addProduct(String title, String description, String image, double price) {
    final Product newProduct = Product(
      title: title,
      description: description,
      price: price,
      image: image,
      username: authenticatedUser.username,
      userid: authenticatedUser.id
    );

    products.add(newProduct);
    selProductIndex = null;
    notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
  }
}