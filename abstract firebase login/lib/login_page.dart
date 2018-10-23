import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';


class LoginPage extends StatefulWidget{
  LoginPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget>createState()=> new _LoginPageState();
}


enum FormType
{
  login,
  register
}



class _LoginPageState extends State<LoginPage>{
  
  //user entry email
  String _email;
  //user entry password
  String _password;
  //login or register form 
  FormType _formType=FormType.login;


  //FormState --> talks about the form in the current state
  final formKey = new GlobalKey<FormState>();

  bool validateAndSave(){
    final form =formKey.currentState;
    
    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }
  }


void validateAndSubmit() async {
  if(validateAndSave())
  {
    try{
      if(_formType==FormType.login)
      {
          String userId = await widget.auth.signInWithEmailAndPassword(_email,_password);
          //FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password);
          print('Fireabse uuid: $userId');
      }
      else
      {   String userId= await widget.auth.createUserWithEmailAndPassword(_email, _password);
          //FirebaseUser user = await FirebaseAuth.instance.linkWithEmailAndPassword(email: _email,password:_password);
          print("Thank you $userId ");
      }

  }
  catch(e){
    print('$e');
    }
  }
}

void moveToRegister()
{
  formKey.currentState.reset();

  setState(() {
      _formType=FormType.register;
      
    });
}

void moveToLogin()
{
  formKey.currentState.reset();
  setState(() {
      _formType=FormType.login;
    });
}


  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login')),
        body: new Container(
          child: new Form(
            child: new Column( 
              crossAxisAlignment: CrossAxisAlignment.stretch,              
              children: buildInputs()+buildSubmitButtons(),
            ),
          ),
        )
    );
  }



List<Widget> buildInputs()
{
  return [
    new TextFormField(
    decoration: new InputDecoration(labelText: 'Email'),
    validator: (value)=>value.isEmpty?'Email can not be empty':null,
    onSaved: (value)=>_email = value,
  ),

  new TextFormField(
    decoration: new InputDecoration(labelText: 'Password'),
    obscureText: true,
    validator: (value)=>value.isEmpty?'Password can not be empty':null,
    onSaved: (value) => _password=value,
  ),

  ];
}





List<Widget> buildSubmitButtons(){

  //on the login page by default

  if(_formType==FormType.login){

  return[
 new RaisedButton(
    child: new Text('Login',style: new TextStyle(fontSize: 20.0),),
    onPressed: validateAndSubmit,
  ),
  new FlatButton(
    child: new Text('Register yourself',style: new TextStyle(fontSize: 20.0)),
    onPressed: moveToRegister,
  )
  ];


  }
  
  //if on the register page
  
  else{
     return[
 new RaisedButton(
    child: new Text('Create an Account',style: new TextStyle(fontSize: 20.0),),
    onPressed: validateAndSubmit,
  ),
  new FlatButton(
    child: new Text('Have an Account? Login',style: new TextStyle(fontSize: 20.0)),
    onPressed: moveToLogin,
  )
  ];

  }

}

}