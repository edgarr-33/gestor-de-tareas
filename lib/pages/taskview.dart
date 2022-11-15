import 'package:flutter/material.dart';
import 'package:gestion_tareas/colors/colors.dart';
import 'package:gestion_tareas/service/service.dart';
import 'package:get/get.dart';

class TaskView extends StatefulWidget {
  TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    Service servicio = Service();
    final size = MediaQuery.of(context).size;

    return RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(5),
            child: FutureBuilder(
                future: servicio.getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  void edit(int index) {
                    setState(() {});
                  }

                  void delete(int index) {
                    setState(() {
                      items.removeAt(index);
                    });
                  }

                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Scaffold(
                        appBar: AppBar(
                          title: const Text('Sistema de gestión de tareas'),
                          backgroundColor: appbar,
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            Get.toNamed('/add');
                          },
                          backgroundColor: appbar,
                          child: const Icon(Icons.add),
                        ),
                        body: ListView.separated(
                          itemCount: snapshot.data.length,
                          separatorBuilder: (_, index) => const Divider(
                            color: Colors.black,
                          ),
                          itemBuilder: ((_, index) => ListTask(
                                items: items,
                                index: index,
                                delete: delete,
                                edit: edit,
                                datos: snapshot,
                                size: size,
                              )),
                        ));
                  }
                })));
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
    
  }
}

class ListTask extends StatelessWidget {
  const ListTask({
    Key? key,
    required this.items,
    required this.index,
    required this.edit,
    required this.delete,
    required this.datos,
    required this.size
    
  }) : super(key: key);

  final List<String> items;
  final int index;
  final Function edit;
  final Function delete;
  final AsyncSnapshot datos;
  final Size size;

  @override
  Widget build(BuildContext context) {
    
    Service servicio = Service();
    return Dismissible(
      
      key: UniqueKey(),
      background: Container(
        color: Colors.red[400],
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15),
        child: const Icon(Icons.delete_outline_rounded),
      ),
      secondaryBackground: Container(
        color: Colors.red[400],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
        child: const Icon(Icons.delete_outline_rounded),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          servicio.deleteData(datos.data[index]['id']);
          delete(index);
          return false;
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          servicio.deleteData(datos.data[index]['id']);
          delete(index);
        }
      },
      child: Row(
        
        children: [
          InkWell(
            onTap: () => Get.toNamed('/edit',
                arguments: {'id': datos.data[index]['id']}),
            child: Container(
              // datos.data[index]['is_completed'] == 1
              color: datos.data[index]['is_completed'] == 0
                  ? const Color.fromARGB(255, 199, 90, 83)
                  : const Color.fromARGB(255, 0, 255, 0),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('${datos.data[index]['id']}'),
                  const SizedBox(
                    width: 100,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width:size.width*0.3 ,
                        child: Text(' ${datos.data[index]['title']}')),
                      Text(' ${datos.data[index]['due_date']}'),
                    ],
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Completed(datos: datos, index: index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Completed extends StatelessWidget {
  const Completed({
    Key? key,
    required this.datos,
    required this.index,
  }) : super(key: key);

  final AsyncSnapshot datos;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (datos.data[index]['is_completed'] == 1) {
      return const Icon(Icons.check_box_outlined);
    } else {
      return const Icon(Icons.check_box_outline_blank_sharp);
    }
  }
}
