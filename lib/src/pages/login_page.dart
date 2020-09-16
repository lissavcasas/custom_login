import 'package:flutter/material.dart';
import 'package:validation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFrondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFrondo(context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(children: <Widget>[
            Icon(
              Icons.person_pin_circle,
              color: Colors.white,
              size: 100.0,
            ),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              'Inicia Sesión',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _loginForm(context) {
    final bloc = LoginBloc();
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(bloc),
                _showErrorEmail(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: containerInnerDecoration(),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 22,
              ),
              hintText: 'ejemplo@correo.com',
              hintStyle: TextStyle(
                fontSize: 12.0,
              ),
              border: InputBorder.none,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: new BorderSide(
                  color: Color(0XFFE81748),
                  width: 1.5,
                ),
              ),
              enabledBorder: snapshot.hasError
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(
                        color: Colors.transparent,
                        width: 1.5,
                      ),
                    ),
              focusedBorder: snapshot.hasError
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(
                        color: Colors.red, //red
                        width: 1.5,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(
                        color: Color(0XFF7774BB),
                        width: 1.5,
                      ),
                    ),
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  BoxDecoration containerInnerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Color(0xffF0F3F7),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          offset: Offset(1, 4),
        ),
        BoxShadow(
          color: Color(0xFFDADFF0),
          offset: Offset(-1, -4),
        )
      ],
    );
  }

  Widget _showErrorEmail(bloc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          StreamBuilder(
            stream: bloc.emailStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text(
                  snapshot.error,
                  style: TextStyle(
                    color: Color(0xffE81748),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.start,
                );
              }
              return Text('');
            },
          ),
        ],
      ),
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.deepPurple,
              ),
              labelText: 'Contrasena',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: () => _login(context),
        );
      },
    );
  }

  _login(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
