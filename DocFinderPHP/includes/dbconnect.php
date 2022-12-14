<?php
class DbConnect
{
    /**
     * Establishing database connection
     * @return database connection handler
     */
    function connect()
    {
        require_once 'constants.php';

        // Connecting to mysql database
        $conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

        // Check for database connection error
        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }

        // returning connection resource
        return $conn;
    }
}
