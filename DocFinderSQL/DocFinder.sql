-- tables
-- Table: users
CREATE TABLE users (
   id int  NOT NULL PRIMARY KEY AUTO_INCREMENT,
   name varchar(100)  NOT NULL,
   email varchar(100)  NOT NULL,
   password text  NOT NULL
);

INSERT INTO users (id, name, email, password) VALUES (101, "prem sai", "143premsai@gmail.com", "premsai#123");

-- End of file.

-- Queries
-- less than 1 mile
SELECT latitude, longitude, SQRT(
    POW(69.1 * (latitude - 43.479692), 2) +
    POW(69.1 * (-80.518172 - longitude) * COS(latitude / 57.3), 2)) AS distance
FROM doctors HAVING distance < 1 ORDER BY distance;