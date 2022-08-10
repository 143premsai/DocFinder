## IOS Capstone Doc Finder Application

### Login
- Sample User login
- Email: user@docfinder.com
- Password: User#123

### Project Tools
- XAMPP
- XCode

### Languages
- Swift
- Php

### Database
- MySql

### Project Structure
 - DocFinderIOSApp
 - DocFinderPhp
 - DocFinderSQL
 - readme.md


 ### APIs
 - Host url :  http://iosdocfinder.000webhostapp.com/   
    ### - login.php
        Method Type:
        POST

        Headers:
        Content-Type: Application/json

        Body Parameters: 
        {"email:"", "password":""}

        Datatypes:
        Email, password - String

        Sample Response Success:
        {"error":false,"user":{"id":101,"email":"143premsai@gmail.com","name":"Prem Sai Krishna"}}

        Sample Response Failure
        {"error":true,"message":"Invalid username or password"}

    ### - register.php
        password will be converted to MD5 hash algo while storing in database

        Method Type:
        POST

        Headers:
        Content-Type: Application/json

        Datatypes:
        Email, password, name - String

        Body Parameters:
        {"email:"", "password":"", "name": ""}

        Sample Response Success:
        {"error":false,"message":"User created successfully"}

        Sample Response Failure
        {"error":true,"message":"User already exist"}

    ### - get_near_by_doctors.php
        Method Type:
        POST

        Headers:
        Content-Type: Application/json

        Datatypes:
        latitude, longitude - Double ; miles - int

        Body Parameters:
        {"latitude":43.479692,"longitude":-80.518172,"miles":1}

        Sample Response Success:
        {"error":false,"doctors":[{"id":144,"name":"Duke, Marin Jonina","address":"Suite 12 65 University Ave
            East","city":"Waterloo","state":"ON","pincode":"N2J 2V9","phone":"519-746-2220","speciality":"Family
            Medicine","latitude":43.476917,"longitude":-80.520886,"distance":0.23513954769651133}]}

        Sample Response Success when no data:
        {"error":false, "doctors" : []}
    
    ### - get_doctors_by_speciality.php
        Method Type:
        POST

        Headers:
        Content-Type: Application/json

        Datatypes:
        search_term - String ;

        Body Parameters:
        {"search_term":"family"}

        Sample Response Success:
        {"error":false,"doctors":[{"id":144,"name":"Duke, Marin Jonina","address":"Suite 12 65 University Ave
            East","city":"Waterloo","state":"ON","pincode":"N2J 2V9","phone":"519-746-2220","speciality":"Family
            Medicine","latitude":43.476917,"longitude":-80.520886,"distance":0.23513954769651133}]}

        Sample Response Success when no data:
        {"error":false, "doctors" : []}

    ### - change_password.php
        Method Type:
        POST

        Headers:
        Content-Type: Application/json

        Datatypes:
        email, password - String ;

        Body Parameters:
        {"email":"", "password": ""}

        Sample Response Success:
        {"error":false,"message":"Successfully updated password"}

        Sample Response failure:
        {"error":true, "message" : "Invalid user email"}
