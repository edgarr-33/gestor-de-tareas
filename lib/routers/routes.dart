
import 'package:gestion_tareas/model/TaskModel.dart';
import 'package:gestion_tareas/pages/add.dart';
import 'package:gestion_tareas/pages/edit.dart';
import 'package:gestion_tareas/pages/taskview.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


class RouterGet{
  static List<GetPage> getPages(){
    return [
      GetPage(
        name: '/taskview', 
        page: () =>  TaskView()
      ),
      GetPage(
        name: '/edit', 
        page: () =>  EditPage()
      ),
      GetPage(
        name: '/add', 
        page: () =>  AddPage()
      ),
    
    

      
    ];
  }

}