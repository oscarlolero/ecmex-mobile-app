import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
    //para myproductsmodel.products
    return List.from(_products); //regresa un pointer a una nueva lista
    // en memoria, para eso, si editamos esta lista, no editariamos la original, es lo que queremos
  }

  void addProduct(Product product) {
    _products.add(product);
  }

  void updateProduct(int index, Product product) {
    _products[index] = product;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
  }
}
