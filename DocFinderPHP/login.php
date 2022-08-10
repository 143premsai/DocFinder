<?php

require_once 'includes/dboperations.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['email']) && isset($_POST['password'])) {

        $db = new DbOperation();

        if ($db->validateLogin($_POST['email'], $_POST['password'])) {
            $response['error'] = false;
            $response['message'] = 'successful login';
            $response['user'] = $db->getUserDetailsByEmail($_POST['email']);
        } else {
            $response['error'] = true;
            $response['message'] = 'Invalid username or password';
            
            $user = array();
            $user['id'] = 0;
            $user['email'] = "";
            $user['name'] = "";
            $response['user'] = $user;
        }
    } else {
        $response['error'] = true;
        $response['message'] = 'Parameters are missing';
    }
} else {
    $response['error'] = true;
    $response['message'] = "Request not allowed";
}

echo json_encode($response);
