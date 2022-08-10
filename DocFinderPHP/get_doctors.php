<?php

require_once 'includes/dboperations.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        $db = new DbOperation();
        $response['error'] = false;
        $response['doctors'] = $db->getDoctors();
        $response['message'] = "Successful";
   
} else {
    $response['error'] = true;
    $response['message'] = "Request not allowed";
}

echo json_encode($response);
