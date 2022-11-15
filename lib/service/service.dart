import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Service {
  Future getData() async {

    var headersList = {
 'Accept': '*/*',
 'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
 'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
 'Content-Type': 'application/json' 
};
    var url = Uri.parse('https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks');

    var body = {"token":"edgar"};

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);


    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    final respuesta = jsonDecode(resBody);


    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
    return respuesta;



    // final respuesta = jsonDecode(resBody);
   
  }

  Future getDataById(int id) async {

    var headersList = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
    'Content-Type': 'application/json' 
    };
      var url = Uri.parse(
        'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id');

    var body = {"token":"edgar"};

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);


    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    
    final respuesta = jsonDecode(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
    return respuesta;
  }

  Future editDataById(int id,String titulo,int is_completed,String date, String descripcion,String commments) async {
  

    
    

    // if (res.statusCode >= 200 && res.statusCode < 300) {
    //   print(resBody);
    // } else {
    //   print(res.reasonPhrase);
    // }

    var headersList = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
    'Content-Type': 'application/json' 
    };
    var url = Uri.parse('https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id');

    var parsedDate = DateTime.parse(date);
    print('date $parsedDate');


    var body = {   
      
      "token":"edgar",
        "title": titulo,
        "is_completed": is_completed,
        "due_date": date,
        "description": descripcion,
        "comments": commments
        
      };

    var req = http.Request('PUT', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);


    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
  }

  Future addData(String title, String date, String comments,String description)async{
var headersList = {
 'Accept': '*/*',
 'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
 'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
 'Content-Type': 'application/json' 
};
var url = Uri.parse('https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks');

var body = 
  {
    "token":"edgar",
    "title": title,
    "is_completed": 0,
    "due_date": date,
    "comments":comments,
    "description": description,
    "tags" : "nueva tarea"
    
  }
;

var req = http.Request('POST', url);
req.headers.addAll(headersList);
req.body = json.encode(body);


var res = await req.send();
final resBody = await res.stream.bytesToString();

if (res.statusCode >= 200 && res.statusCode < 300) {
  print(resBody);
}
else {
  print(res.reasonPhrase);
}

  }

  Future deleteData(int id)async{
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
      'Content-Type': 'application/json' 
      };
      var url = Uri.parse('https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id');

      var body = {"token":"edgar"};

      var req = http.Request('DELETE', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);


      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(resBody);
      }
      else {
        print(res.reasonPhrase);
      }
        }
}
