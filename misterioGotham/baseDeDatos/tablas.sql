
CREATE TABLE informe_escena_crimen(
	date_crime Number(10,0),
	type VARCHAR2(100),
	description2 VARCHAR(1000),
	city VARCHAR2(100)
);

CREATE TABLE permiso_circulacion (
	id Number(10,0),
	age Number(3,0),
	height Number(3,0),
	eye_color VARCHAR2(100),
	hair_color VARCHAR2(100),
	gender VARCHAR2(100),
	plate_number VARCHAR2(100),
	car_make VARCHAR2(100),
	car_model VARCHAR2(100),
	PRIMARY KEY(id)
);


/*CREATE TABLE salario (
	id_persona Number(10,0),
	annual_income Number(12,0),
	PRIMARY KEY(id_persona),
	foreign key(id_persona) references persona(id) 
);*/


CREATE TABLE persona (
	id Number(10,0),
	name VARCHAR2(100),
	license_id Number(10,0),
	address_number Number(10,0),
	address_street_name VARCHAR2(100),
	ssn Number(10,0),
	FOREIGN KEY(license_id) REFERENCES permiso_circulacion (id),	
	PRIMARY KEY(id)
);

CREATE TABLE redes_sociales_eventos (
	person_id Number(10,0),
	event_id Number(10,0),
	event_name VARCHAR2(1000),
	fecha Number(8,0),
	PRIMARY KEY(person_id,event_id, fecha ),
	FOREIGN KEY(person_id) REFERENCES persona(id)
);
CREATE TABLE declaraciones (
	person_id Number(10,0) PRIMARY KEY,
	transcript VARCHAR2(1000),
	FOREIGN KEY(person_id) REFERENCES persona(id)
);
CREATE TABLE socios_gimnasio (
	id VARCHAR2(100),
	person_id number(10,0),
	name VARCHAR2(100),
	membership_start_date Number(8,0),
	membership_status VARCHAR2(100),
	FOREIGN KEY(person_id) REFERENCES persona(id),
	PRIMARY KEY(id)
);
CREATE TABLE gimnasio_entradas_salidas (
	membership_id VARCHAR2(100),
	check_in_date number(8,0),
	check_in_time number(4,0),
	check_out_time number(4,0),
	FOREIGN KEY(membership_id) REFERENCES socios_gimnasio(id),
primary key(membership_id , check_in_date,check_in_time )
);

