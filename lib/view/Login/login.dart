
import 'package:componets/view/views.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}
// var
bool isDarkTheme = false;

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {

    // var
    isDarkTheme=Theme.of(context).brightness==Brightness.dark?true:false;

    return Scaffold( 
      body: body(context),
    );
  }
  
  /// WIDGETS VIEWS
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        // padding: EdgeInsets.all(),
        // width: MediaQuery.of(context).size.width,
        //  height: MediaQuery.of(context).size.height ,
        //  decoration : proporciona una variedad de formas de dibujar un cuadro
        decoration: isDarkTheme==true? null:BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [ Color.fromRGBO(10, 10, 10, 1),Color.fromRGBO(89, 112, 96, 1) ],)),
        child: Container(
          // width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height ,
          child: Expanded(
            child: Stack( // Stack : Esta clase es útil si desea superponer a varios niños de una manera simple
              textDirection: TextDirection.rtl,
              children: <Widget>[
                // Agregamos los Widgets de la vista
                Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        const Text ("Escopeta en Línea", style: TextStyle(
                        color: Colors.white, fontSize: 70,
                        fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                        ),
                      SizedBox(height: 30.0),
                      TextField(
                        decoration: InputDecoration(disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Correo electrónico',labelStyle: TextStyle(color:Colors.white),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white70))),),
                      SizedBox(height: 20.0),
                      TextField( obscureText: true, decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white70)), labelText: 'Contraseña',labelStyle: TextStyle(color:Colors.white))),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Ejemplo(),
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login, // Add the icon you want
                                color: Colors.white, // Icon color
                              ),
                              SizedBox(width: 8.0), // Spacing between icon and text
                              Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.blue : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            backgroundColor: MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:5),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => Ejemplo(),
                            // ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people, // Add the icon you want
                                color: Colors.white, // Icon color
                              ),
                              SizedBox(width: 10.0), // Spacing between icon and text
                              Text(
                                'Registro',
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.blue : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      const Text("Olvide mi contraseña? obtenga ayuda para iniciar sesión.",textAlign: TextAlign.center,style: TextStyle(color:Colors.white)),
                      SizedBox(height: 20.0),
                      Row(
                        children: const <Widget>[
                          Expanded(child: Divider()),
                          SizedBox(width: 12.0),
                          Text("Tutorial registro tirador",style: TextStyle(color:Colors.white)),
                          SizedBox(width: 12.0),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // FaIcon(FontAwesomeIcons.facebook,size: 24.0,color:Colors.white),
                          SizedBox(width: 12.0),
                          Text("Reglamento FEMETI",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}
}


//!  
//!  Advertencia : Tenga en cuenta que al rotar la pantalla horizontal se va aproducir un Desbordamiento de pixeles
//!