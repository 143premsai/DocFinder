<?php

require_once 'includes/dboperations.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['latitude']) && isset($_POST['longitude']) && isset($_POST['miles'])) {

        $lat = floatval($_POST['latitude']);
        $long = floatval($_POST['longitude']);
        $mile = intval($_POST['miles']);

        $db = new DbOperation();
        if (is_double($lat) && is_double($long) ) {
            $response['error'] = false;
            $docs = $db->getNearByDoctors($lat, $long, $mile);
            $response['doctors'] = $docs;
            if(count($docs) > 0){
                $response['message'] = "Success Doctor list";
            } else {
                $response['message'] = "No Nearby Doctors available, choose different location";
            }
            
        } else {
            $response['error'] = true;
            $response['message'] = 'Invalid Latitude or longitude';
            $response['doctors'] = array();
        }
    } else {
        $response['error'] = true;
        $response['message'] = 'Parameters are missing';
        $response['doctors'] = array();
    }
} else {
    $response['error'] = true;
    $response['message'] = "Request not allowed";
    $response['doctors'] = array();
}

echo json_encode($response);
