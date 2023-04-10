CREATE TABLE parkingLot (
lot_id int NOT NULL,
location varchar(50) NOT NULL,
total_slots int NOT NULL,
available_slots int NOT NULL,
latitude decimal(10, 6) NOT NULL,
longitude decimal(10, 6) NOT NULL,
PRIMARY KEY (lot_id)
);

INSERT INTO parkingLot (lot_id, location, total_slots, available_slots, latitude, longitude) VALUES
(1, 'Town', 10, 10, -1.285182, 36.825378),
(2, 'Ndagani', 3, 3, -1.282342, 36.810263),
(3, 'Mitheru', 5, 5, -1.277735, 36.813734),
(4, 'Chogoria', 7, 7, -1.275347, 36.816984);

CREATE TABLE parkingSlot (
slot_id int NOT NULL,
lot_id int NOT NULL,
status varchar(50) NOT NULL,
occupied_by int DEFAULT NULL,
last_updated datetime NOT NULL,
PRIMARY KEY (slot_id),
FOREIGN KEY (lot_id) REFERENCES parkingLot (lot_id)
);

INSERT INTO parkingSlot (slot_id, lot_id, status, occupied_by, last_updated) VALUES
(1, 1, 'Available', NULL, '2023-03-12 10:30:00'),
(2, 3, 'Available', NULL, '2023-03-12 11:30:00'),
(3, 2, 'Available', NULL, '2023-03-12 12:00:00'),
(4, 1, 'Available', NULL, '2023-03-12 10:30:00'),
(5, 4, 'Available', NULL, '2023-03-12 10:00:00'),
(6, 3, 'Available', NULL, '2023-03-12 11:00:00'),
(7, 3, 'Available', NULL, '2023-03-12 12:30:00'),
(8, 2, 'Available', NULL, '2023-03-12 12:30:00'),
(9, 4, 'Available', NULL, '2023-03-12 13:30:00'),
(10, 3, 'Unavailable', 1, '2023-03-12 10:00:00'),
(11, 1, 'Unavailable', 3, '2023-03-12 11:30:00');

CREATE TABLE Reservation (
reservation_id int NOT NULL,
driver_id int NOT NULL,
slot_id int NOT NULL,
reservation_time datetime NOT NULL,
PRIMARY KEY (reservation_id),
FOREIGN KEY (driver_id) REFERENCES driver (driver_id),
FOREIGN KEY (slot_id) REFERENCES parkingSlot (slot_id)
);

INSERT INTO Reservation (reservation_id, driver_id, slot_id, reservation_time) VALUES
(1, 1, 10, '2023-03-12 10:30:00'),
(2, 2, 2, '2023-03-12 11:30:00'),
(3, 3, 7, '2023-03-12 12:30:00'),
(4, 4, 9, '2023-03-12 13:30:00');

CREATE TABLE Driver (
driver_id int NOT NULL,
driver_name varchar(50) NOT NULL,
phone_number varchar(50) NOT NULL,
current_location int NOT NULL,
last_location_update datetime NOT NULL,
PRIMARY KEY (driver_id),
FOREIGN KEY (current_location) REFERENCES parkingLot (lot_id)
);

INSERT INTO Driver (driver_id, driver_name, phone_number, current_location, last_location_update) VALUES
(1, 'Cynthia', '0710366814', 1, '2023-03-12 10:30:00'),
(2, 'Evans', '0710312345', 1, '2023-03-12 11:45:00'),
(3, 'Junior', '0713456789', 3, '2023-03-12 12:15:00'),
(4, 'Kelvin', '0745671123', 2, '2023-03-12 13:00:00');

CREATE TABLE Payment (
payment_id int NOT NULL,
reservation_id int NOT NULL,
amount decimal(10, 2) NOT NULL,
payment_date datetime NOT NULL,
paid_by int NOT NULL,
PRIMARY KEY (payment_id),
FOREIGN KEY (reservation_id) REFERENCES reservation (reservation_id),
FOREIGN KEY (paid_by) REFERENCES Driver (driver_id)
);

INSERT INTO Payment (payment_id, reservation_id, amount, payment_date, paid_by) VALUES
(1, 1, 20.00, '2023-03-12 10:30:00', 1);

CREATE TABLE Location (
location_id int NOT NULL,
location_name varchar(50) NOT NULL,
address varchar(100) NOT NULL,
latitude decimal(10, 6) NOT NULL,
longitude decimal(10, 6) NOT NULL,
PRIMARY KEY(location_id)
);

INSERT INTO Location (location_id, location_name, address, latitude, longitude) VALUES
(1, 'Town Parking Lot', '123 Main St, Town', -1.2833, 36.8167),
(2, 'Ndagani Parking Lot', '456 Elm St, Ndagani', -0.1833, 37.5833),
(3, 'Mitheru Parking Lot', '789 Oak St, Mitheru', -1.0500, 37.1500),
(4, 'Chogoria Parking Lot', '987 Pine St, Chogoria', 0.5167, 37.9833);