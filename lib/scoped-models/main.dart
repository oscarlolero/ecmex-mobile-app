import 'package:scoped_model/scoped_model.dart';

import './products.dart';
import './users.dart';
//combina propiedades y metodos de las clases
class MainModel extends Model with UserModel, ProductsModel{}
