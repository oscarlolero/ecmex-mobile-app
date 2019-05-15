import 'package:scoped_model/scoped_model.dart';

import './connected_products.dart';

//combina propiedades y metodos de las clases
class MainModel extends Model with ConnectedProductsModel, UserModel, ProductsModel{}
