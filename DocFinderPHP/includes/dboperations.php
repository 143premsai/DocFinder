<?php
class DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/constants.php';
        require_once dirname(__FILE__) . '/dbconnect.php';
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    //Function to create a new user
    public function createUser($email, $pass,  $name)
    {
        if (!$this->isUserExist($email)) {
            $password = md5($pass);
            $stmt = $this->conn->prepare("INSERT INTO users (email, password,  name) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $email, $password,  $name);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }

    // Validate user already exists in platform
    public function isUserExist($email)
    {
        $stmt = $this->conn->prepare("SELECT id FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }

    // validate user credentials
    public function validateLogin($email, $pass)
    {
        $password = md5($pass);
        $stmt = $this->conn->prepare("SELECT * FROM users WHERE email = ? AND password = ?");
        $stmt->bind_param("ss", $email, $password);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }

    // get user details by email
    public function getUserDetailsByEmail($email)
    {
        $stmt = $this->conn->prepare("SELECT id, email, name FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->bind_result($id, $email, $name);
        $stmt->fetch();
        $user = array();
        $user['id'] = $id;
        $user['email'] = $email;
        $user['name'] = $name;
        return $user;
    }

    public function getNearByDoctors($lat, $long, $miles){
        $stmt = $this->conn->prepare("Select id,name,address,phone,city,state,speciality,latitude,longitude from (SELECT *, SQRT(POW(69.1 * (latitude - ?), 2) + POW(69.1 * (? - longitude) * COS(latitude / 57.3), 2)) AS distance FROM doctors HAVING distance < ? ORDER BY distance)T;");
        
        $stmt->bind_param("ddi",$lat, $long, $miles);
        $stmt->execute();
        $result_set = $stmt->get_result();
        $result = $result_set->fetch_all(MYSQLI_ASSOC);
        return $result;
    }
    
    public function getDoctors(){
        $stmt = $this->conn->prepare("Select id,name,address,phone,city,state,speciality,latitude,longitude from doctors;");
        $stmt->execute();
        $result_set = $stmt->get_result();
        $result = $result_set->fetch_all(MYSQLI_ASSOC);
        return $result;
    }

    public function getDoctorBySearchSpeciality($search_term){
        $search = '%'.$search_term.'%';
        $stmt = $this->conn->prepare("SELECT id,name,address,phone,city,state,speciality,latitude,longitude FROM `doctors` WHERE  speciality like ?");
        $stmt->bind_param("s", $search);
        $stmt->execute();
        $result_set = $stmt->get_result();
        $result = $result_set->fetch_all(MYSQLI_ASSOC);
        return $result;
    }

    public function updateUserPassword($email, $pass) {
        $password = md5($pass);
        $stmt = $this->conn->prepare("UPDATE `users` set password = ? WHERE email = ? ");
        $stmt->bind_param("ss", $password, $email);
        if ($stmt->execute()) {
            return "Successfully updated password";
        } else {
            return "Fail to update password";
        }
    }
}
