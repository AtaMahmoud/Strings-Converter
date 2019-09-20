String converter 

command line app that converts android XML Strings file to Dart Syntax 

from this syntax 
```
<string name="both_pswd_not_match">Password and confirmation do not match.</string>
```

to this dart syntax
```
String get bothPswdNotMatch {
    return Intl.message("Password and confirmation do not match.", name: 'bothPswdNotMatch');
  }
  
```
