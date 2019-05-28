import 'dart:convert';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../models/cart_item.dart';

import '../config/server.dart' as server;

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  List<CartItem> _cartItems = [];
  String _selProductId;
  User _authenticatedUser;
  bool _isLoading = false;
}

mixin CartItemModel on ConnectedProductsModel {
  List<CartItem> get allCartItems {
    return List.from(_cartItems);
  }

  List<CartItem> get allCartItemsUnprotected {
    return _cartItems;
  }

  int get getTotalPrice {
    int total = 0;
    if(_cartItems.length == 0) return 0;
    _cartItems.forEach((cartItem) {
      total += cartItem.product.price * cartItem.amount;
    });
    return total;
  }

  int getItemAmount(int index) {
    return _cartItems[index].amount;
  }

  void addCartItem(Product product) {
    //Verificar si ya esta añadido al carrito

    int existingProductId, index = 0;
    for(final cartItem in _cartItems) {
      if (cartItem.product == product) {
        existingProductId = index;
        break;
      }
      index++;
    }

    if(existingProductId == null) {
      final CartItem newCartItem = CartItem(
        product: product,
        amount: 1,
      );
      _cartItems.add(newCartItem);
    } else {
      _cartItems[existingProductId].amount += 1;
    }

  }

  void deleteCartProduct(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    //para myproductsmodel.products
    return List.from(_products); //regresa un pointer a una nueva lista
    // en memoria, para eso, si editamos esta lista, no editariamos la original, es lo que queremos
    //si hacemos return _products; se regresa la direccion de la lista de productos original D:
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    //regresa -1 si no encuentra nada
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  Product get selectedProduct {
    if (_selProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Future<String> _uploadImage(File image, String productId) async {
    final fileTypeData = mime(image.path).split('/');
    StorageReference ref = FirebaseStorage.instance.ref().child('products/${productId}.${fileTypeData[1]}');
    StorageUploadTask uploadTask = ref.putFile(image);

    final String downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    final url = downUrl.toString();

    return url;
  }

  Future<bool> addProduct(
      String title, String description, File image, int price, String provider, int stock) async {
    _isLoading = true;
    notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://flutter.dev/assets/homepage/carousel/phone_bezel-467ab8d838e5e2d2d3f347f766173ccc365220223692215416e4ce7342f2212f.png',
      'price': price,
      'provider': provider,
      'stock': stock
    };

    try {
//    http://192.168.0.10:3000/test
      http.Response response = await http.post(
        '${server.serverURL}/product',
        body: json.encode(productData),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String uploadedImageUrl = await _uploadImage(image, responseData['productId']);
      response = await http.patch(
        'https://flutter-products-3e91e.firebaseio.com/products/${responseData['productId']}.json',
        body: json.encode({
          "image": uploadedImageUrl
        }),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
//
//      final Product newProduct = Product(
//          id: responseData['name'],
//          title: title,
//          description: description,
//          price: price,
//          image: image,
//          username: _authenticatedUser.username,
//          userid: _authenticatedUser.id);
//      _products.add(newProduct);
      _isLoading = false;
      notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(
      String title, String description, int price, String provider, int stock) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'price': price,
      'provider': provider,
      'stock': stock
    };
    return http
        .patch(
            'https://flutter-products-3e91e.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-products-3e91e.firebaseio.com/products/${deletedProductId}.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners(); //hace un rebuild a lo que esta dentro del wrap de ScopedModelDescendant
    return http
        .get('https://flutter-products-3e91e.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
      final List<Product> fetchedproductList = [];
//      print(response.body);
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        if (_products.length > 0) {
          _products.clear();
        }
        _isLoading = false;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: int.parse(productData['price'].toString()),
            image: productData['image'],
            provider: productData['provider'],
            stock: int.parse(productData['stock'].toString()),
        );
        fetchedproductList.add(product);
      });
      _products = fetchedproductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    });
//        .catchError((error) {
//    print(error);
//    _isLoading = false;
//    notifyListeners();
//    });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    if (productId != null) {
      //https://www.udemy.com/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/10840630#questions/6825196
      notifyListeners(); //This ensures, that existing pages are only immediately updated (=> re-rendered) when a product is selected, not when it's unselected.
    }
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  bool get isAdmin {
    //TODO REMOVER ESTO ANTES DE RELEASE
    if(_authenticatedUser.isAdmin == null) return true;
    return _authenticatedUser.isAdmin;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    Map<String, String> userCredentials = {
      'username': username,
      'password': password
    };

    try {
      Map<dynamic, dynamic> responseData = {};
      String message = 'Algo salió mal.';
      bool success = false;

      final http.Response response = await http.post(
        '${server.serverURL}/user/login',
        body: json.encode(userCredentials),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      ).timeout(const Duration(seconds: 3));
      responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        success = true;
        _authenticatedUser = User(
          username: username,
          isAdmin: responseData['isAdmin'],
        );
      } else if (response.statusCode == 502) {
        message = 'Error al conectar con la base de datos.';
      } else if (response.statusCode == 401) {
        responseData['message'] == 'USER_NOT_FOUND'
            ? message = 'El usuario no existe.'
            : message = 'Contraseña incorrecta.';
      }

      return {'success': success, 'message': message};
    } catch (error) {
      print(error.toString());
      return {'success': false, 'message': 'Error al acceder al servidor.'};
    }
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
