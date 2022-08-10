<?php

require_once 'includes/dboperations.php';

$response = array();

/**
 * @param $result
 * @param array $response
 * @return array
 */
function getArr($result, array $response)
{
    if ($result == USER_CREATED) {
        $response['error'] = false;
        $response['message'] = 'User created successfully';
    } elseif ($result == USER_ALREADY_EXIST) {
        $response['error'] = true;
        $response['message'] = 'User already exist';
    } elseif ($result == USER_NOT_CREATED) {
        $response['error'] = true;
        $response['message'] = 'Some error occurred';
    }
    return $response;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!verifyRequiredParams(array('email', 'password', 'name'))) {

        //getting values
        $password = $_POST['password'];
        $email = $_POST['email'];
        $name = $_POST['name'];

        //creating db operation object
        $db = new DbOperation();

        //adding user to database
        $result = $db->createUser($email, $password, $name);

        //making the response accordingly
        $response = getArr($result, $response);
    } else {
        $response['error'] = true;
        $response['message'] = 'Required parameters are missing';
    }
} else {
    $response['error'] = true;
    $response['message'] = 'Invalid request';
}

//function to validate the required parameter in request
function verifyRequiredParams($required_fields)
{

    //Getting the request parameters
    $request_params = $_REQUEST;

    //Looping through all the parameters
    foreach ($required_fields as $field) {
        //if any requred parameter is missing
        if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
            //returning true;
            return true;
        }
    }
    return false;
}

echo json_encode($response);
