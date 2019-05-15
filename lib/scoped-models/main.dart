import 'package:scoped_model/scoped_model.dart';

import './products.dart';
import './connected_products.dart';
import './users.dart';
//combina propiedades y metodos de las clases
class MainModel extends Model with ConnectedProducts, UserModel, ProductsModel{}
