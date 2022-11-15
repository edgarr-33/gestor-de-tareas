
import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../service/service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';
class EditPage extends StatefulWidget {
  EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var maskFormater = MaskTextInputFormatter(
      mask: '####-##-##', filter: {'#': RegExp('[0-9]')});
  bool? bar = false;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int datos = arguments['id'];
    print('dtos: $datos');
    Service servicio = Service();
    return FutureBuilder(
        future: servicio.getDataById(datos),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final titleController =
                TextEditingController(text: snapshot.data[0]['title']);
            final dateController =
                TextEditingController(text: snapshot.data[0]['due_date']);
            final commmentsController =
                TextEditingController(text: snapshot.data[0]['comments']);
            final descriptionController =
                TextEditingController(text: snapshot.data[0]['description']);
            final int taskComplete = snapshot.data[0]['is_completed'];
            return Scaffold(
              appBar: AppBar(
                title: const Text('Sistema de gestión de tareas'),
                backgroundColor: appbar,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    inputTitle(snapshot.data[0]['title'], titleController),
                    divisor(),
                    inputDescription(snapshot.data[0]['description'],
                        descriptionController),
                    divisor(),
                    inputComments(
                        snapshot.data[0]['comments'], commmentsController),
                    divisor(),
                    inputDate(snapshot.data[0]['due_date'], dateController),
                    divisor(),
                    checkCompleted(taskComplete),
                    divisor(),
                    botonGuardar(titleController, descriptionController,
                        commmentsController, dateController, datos, bar),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget checkCompleted(int taskComplete) {
    return CheckboxListTile(
        activeColor: appbar,
        value: bar,
        title: const Text('Tarea completa'),
        onChanged: (value) {
          setState(() {
            bar = value;
          });
        });
  }

  Container botonGuardar(
      TextEditingController title,
      TextEditingController description,
      TextEditingController commments,
      TextEditingController date,
      int id,
      bool? isCompleted) {
    int complete;

    if (isCompleted == true) {
      complete = 1;
    } else {
      complete = 0;
    }
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: 300,
      height: 48,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: appbar,
              side: const BorderSide(color: Colors.black38),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                'Guardar',
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
          onPressed: () {
            Service servicio = Service();

            servicio.editDataById(id, title.text, complete, date.text,
                description.text, commments.text);

            // Get.offNamed('/taskview');
            Get.offNamedUntil('/taskview', (route) => false);
          }),
    );
  }

  SizedBox divisor() {
    return const SizedBox(
      height: 15,
    );
  }

  Container inputTitle(String titulo, TextEditingController tituloController) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        cursorColor: appbar,

        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
            labelText: 'Titulo',
            labelStyle: TextStyle(color: appbar),
            // hoverColor: appbar,
            // fillColor: appbar,
            // focusColor: appbar,
            border: InputBorder.none),
        // initialValue: titulo,
        controller: tituloController,
      ),
    );
  }

  Container inputDate(String date, TextEditingController dateController) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
          cursorColor: appbar,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              labelText: 'Fecha en formato YYYY/MM/DD',
              labelStyle: TextStyle(color: appbar),
              border: InputBorder.none),
          keyboardType: TextInputType.datetime,
          inputFormatters: [maskFormater],
          // initialValue: date,
          controller: dateController),
    );
  }

  Container inputComments(
      String comentarios, TextEditingController commmentsController) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
          cursorColor: appbar,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            border: InputBorder.none,
            labelText: 'Comentario',
            labelStyle: TextStyle(color: appbar),
          ),
          // initialValue: comentarios,
          controller: commmentsController),
    );
  }

  Container inputDescription(
      String description, TextEditingController descripctionController) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
          cursorColor: appbar,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              border: InputBorder.none,
              labelStyle: TextStyle(color: appbar),
              labelText: 'Descripcion'),
          // initialValue: description,
          controller: descripctionController),
    );
  }
}
