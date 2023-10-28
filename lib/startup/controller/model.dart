class Signupmodel{

 late String _email;
 late String _username;
 late String _firstname;
 late String _lastname;
 late String _phone;
 late String _password;

 String get email => _email;

  set email(String value) {
    _email = value;
  }

 String get username => _username;

 String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get lastname => _lastname;

  set lastname(String value) {
    _lastname = value;
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  set username(String value) {
    _username = value;
  }

 Signupmodel(this._email, this._username, this._firstname, this._lastname,
      this._phone, this._password);

//Signupmodel(this.email, this.username, this.firstname, this.lastname, this.phone, this.password);


}
