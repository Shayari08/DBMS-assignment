CREATE DATABASE artify;

USE artify;

CREATE TABLE artists (
    artistID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dateOfBirth DATE NOT NULL,
    biography TEXT
);
-- Insert 10 values into Artists Table with explicit IDs
INSERT INTO Artists (artistID, name, dateOfBirth, biography) VALUES
(1, 'John Doe', '1980-05-15', 'John Doe is a contemporary artist known for his abstract paintings.'),
(2, 'Jane Smith', '1975-10-20', 'Jane Smith is a renowned sculptor specializing in metal sculptures.'),
(3, 'Michael Johnson', '1982-03-08', 'Michael Johnson is a landscape painter inspired by nature.'),
(4, 'Emily Brown', '1990-12-03', 'Emily Brown is a digital artist exploring the intersection of technology and art.'),
(5, 'David Lee', '1978-07-25', 'David Lee is a ceramic artist known for his intricate pottery designs.'),
(6, 'Sarah Adams', '1985-09-18', 'Sarah Adams is a mixed-media artist experimenting with various materials.'),
(7, 'Robert Wilson', '1973-06-30', 'Robert Wilson is a portrait artist capturing the essence of his subjects.'),
(8, 'Karen Taylor', '1988-04-12', 'Karen Taylor is a street artist known for her colorful murals in urban settings.'),
(9, 'Chris Evans', '1987-11-28', 'Chris Evans is a conceptual artist exploring themes of identity and culture.'),
(10, 'Amanda Roberts', '1984-08-22', 'Amanda Roberts is a printmaker known for her linocut prints depicting wildlife.');

CREATE TABLE artworks (
    artworkID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    creationDate DATE,
    description TEXT,
    price DECIMAL(10, 2),
    category VARCHAR(255)
);

-- Insert 10 values into Artworks Table with explicit IDs
INSERT INTO Artworks (artworkID, title, creationDate, description, price, category) VALUES
(1, 'Artwork 1', '2020-01-01', 'Description of Artwork 1', 100.00, 'Category 1'),
(2, 'Artwork 2', '2020-02-02', 'Description of Artwork 2', 200.00, 'Category 2'),
(3, 'Artwork 3', '2020-03-03', 'Description of Artwork 3', 300.00, 'Category 3'),
(4, 'Artwork 4', '2020-04-04', 'Description of Artwork 4', 400.00, 'Category 1'),
(5, 'Artwork 5', '2020-05-05', 'Description of Artwork 5', 500.00, 'Category 2'),
(6, 'Artwork 6', '2020-06-06', 'Description of Artwork 6', 600.00, 'Category 3'),
(7, 'Artwork 7', '2020-07-07', 'Description of Artwork 7', 700.00, 'Category 1'),
(8, 'Artwork 8', '2020-08-08', 'Description of Artwork 8', 800.00, 'Category 2'),
(9, 'Artwork 9', '2020-09-09', 'Description of Artwork 9', 900.00, 'Category 3'),
(10, 'Artwork 10', '2020-10-10', 'Description of Artwork 10', 1000.00, 'Category 1');


CREATE TABLE customers (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(15),
    email VARCHAR(255),
    address TEXT
);

-- Insert 10 values into Customers Table with explicit IDs
INSERT INTO Customers (customerID, name, phoneNumber, email, address) VALUES
(1, 'John Smith', '123-456-7890', 'john@example.com', '123 Main Street, City, Country'),
(2, 'Alice Johnson', '987-654-3210', 'alice@example.com', '456 Elm Street, City, Country'),
(3, 'Michael Davis', '555-123-4567', 'michael@example.com', '789 Oak Street, City, Country'),
(4, 'Emily Wilson', '111-222-3333', 'emily@example.com', '321 Pine Street, City, Country'),
(5, 'Daniel Miller', '444-555-6666', 'daniel@example.com', '654 Cedar Street, City, Country'),
(6, 'Sarah Brown', '777-888-9999', 'sarah@example.com', '987 Maple Street, City, Country'),
(7, 'James Lee', '999-000-1111', 'james@example.com', '741 Birch Street, City, Country'),
(8, 'Emma Taylor', '222-333-4444', 'emma@example.com', '852 Walnut Street, City, Country'),
(9, 'William Moore', '333-444-5555', 'william@example.com', '963 Spruce Street, City, Country'),
(10, 'Olivia Anderson', '666-777-8888', 'olivia@example.com', '159 Cherry Street, City, Country');

CREATE TABLE sales (
    saleID INT AUTO_INCREMENT PRIMARY KEY,
    saleDate DATE,
    totalAmount DECIMAL(10, 2)
);

-- Insert 10 values into Sales Table with explicit IDs
INSERT INTO Sales (saleID, saleDate, totalAmount) VALUES
(1, '2022-01-01', 1000.00),
(2, '2022-01-02', 1500.00),
(3, '2022-01-03', 2000.00),
(4, '2022-01-04', 2500.00),
(5, '2022-01-05', 3000.00),
(6, '2022-01-06', 3500.00),
(7, '2022-01-07', 4000.00),
(8, '2022-01-08', 4500.00),
(9, '2022-01-09', 5000.00),
(10, '2022-01-10', 5500.00);

CREATE TABLE exhibitions (
    exhibitionID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    startDate DATE,
    endDate DATE,
    location VARCHAR(255)
);

-- Insert 10 values into Exhibitions Table with explicit IDs
INSERT INTO Exhibitions (exhibitionID, title, startDate, endDate, location) VALUES
(1, 'Spring Art Expo', '2022-04-01', '2022-04-15', 'City Convention Center'),
(2, 'Summer Gallery Showcase', '2022-07-01', '2022-07-31', 'Downtown Gallery District'),
(3, 'Autumn Art Fair', '2022-10-01', '2022-10-15', 'County Fairgrounds'),
(4, 'Winter Wonderland Exhibit', '2022-12-01', '2022-12-31', 'Museum of Modern Art'),
(5, 'Contemporary Art Festival', '2023-03-01', '2023-03-15', 'City Park Pavilion'),
(6, 'Abstract Art Symposium', '2023-06-01', '2023-06-30', 'University Art Gallery'),
(7, 'Sculpture Garden Showcase', '2023-09-01', '2023-09-30', 'Botanical Gardens'),
(8, 'Photography Expo', '2023-12-01', '2023-12-31', 'Downtown Event Center'),
(9, 'Mixed Media Exhibition', '2024-03-01', '2024-03-15', 'Cultural Arts Center'),
(10, 'Local Artist Spotlight', '2024-06-01', '2024-06-30', 'Community Center');


CREATE TABLE bookings (
    bookingID INT AUTO_INCREMENT PRIMARY KEY,
    artworkID INT,
    exhibitionID INT,
    FOREIGN KEY (artworkID) REFERENCES artworks(artworkID),
    FOREIGN KEY (exhibitionID) REFERENCES exhibitions(exhibitionID)
);
 
-- Insert 10 values into Bookings Table with explicit IDs
INSERT INTO Bookings (bookingID, artworkID, exhibitionID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);
