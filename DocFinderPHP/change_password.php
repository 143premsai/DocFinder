<?php

require_once 'includes/dboperations.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['email']) && isset($_POST['password'])) {

        $db = new DbOperation();

        if ($db ->isUserExist($_POST['email'])) {
            $result = $db->updateUserPassword($_POST['email'], $_POST['password']);
            $response['error'] = false;
            $response['message'] = $result;
        } else {
            $response['error'] = true;
            $response['message'] = 'Invalid user email';
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
