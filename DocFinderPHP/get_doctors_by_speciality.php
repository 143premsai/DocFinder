<?php

require_once 'includes/dboperations.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['search_term'])) {

        $db = new DbOperation();
        if ($_POST['search_term'] != "" ) {
            $response['error'] = false;
            $docs = $db->getDoctorBySearchSpeciality($_POST['search_term']);
            $response['doctors'] = $docs;
            if(count($docs) > 0){
                $response['message'] = "Success Doctor list";
            } else {
                $response['message'] = "No Doctors found for this speciality";
            }
            
            
        } else {
            $response['error'] = true;
            $response['message'] = 'Invalid Speciality';
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
