import 'package:flutter/cupertino.dart';
import 'package:flutter_application/services/api_services.dart';

import '../models/models_model.dart';

class ModelsProvider with ChangeNotifier{
  String currentModel = "gpt-3.5-turbo-0613";

  String get getCurrentModel{
    return currentModel;
  }
  void setCurrentModel (String newModel){
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList{
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async{
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}