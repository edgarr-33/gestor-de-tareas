import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../colors/colors.dart';
import '../service/service.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});


  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var maskFormater = MaskTextInputFormatter(
      mask: '####-##-##', filter: {'#': RegExp('[0-9]')});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _comentsController = TextEditingController();
  final TextEditingController _descripctionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de gestión de tareas'),
        backgroundColor: appbar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            inputTitle(_titleController),
            divisor(),
            inputDescription(_descripctionController),
            divisor(),
            inputComments(_comentsController),
            divisor(),
            inputDate(_dateController),
            divisor(),
            botonGuardar(_titleController, _dateController, _comentsController,
                _descripctionController),
          ],
        ),
      ),
    );
  }

  Container botonGuardar(
      TextEditingController title,
      TextEditingController date,
      TextEditingController commets,
      TextEditingController description) {
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

            servicio.addData(
                title.text, date.text, commets.text, description.text);

            Get.offNamedUntil('/taskview', (route) => false);
          }),
    );
  }

  SizedBox divisor() {
    return const SizedBox(
      height: 15,
    );
  }

  Container inputTitle(TextEditingController tituloController) {
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

  Container inputDate(TextEditingController dateController) {
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

  Container inputComments(TextEditingController commmentsController) {
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

  Container inputDescription(TextEditingController descripctionController) {
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
          controller: descripctionController),
    );
  }
}
