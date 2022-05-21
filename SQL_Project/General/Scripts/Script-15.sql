CREATE TABLE address (
	id serial,
	street varchar(255),
	street_number int,
	city varchar(255),
	zip_code varchar(6)
);

INSERT INTO address(street,street_number,city,zip_code) VALUES ('Doktorská', 1, 'Engetov', '123 00');

INSERT INTO address(street,street_number,city,zip_code) VALUES ('Pacientská', 1, 'Engetov', '111 11');

INSERT INTO address(street,street_number,city,zip_code) VALUES ('Pacientská', 2, 'Engetov', '567 89');