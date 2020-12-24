CREATE USER 'viewer'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON geodata.* TO 'viewer'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';
GRANT ALL ON *.* TO 'admin'@'localhost';