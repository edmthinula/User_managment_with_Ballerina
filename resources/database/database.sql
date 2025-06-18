CREATE TABLE your_table_name (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    birthDate DATE NOT NULL,
    mobileNumber VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    PRIMARY KEY (id)
);


INSERT INTO your_table_name (id, name, birthDate, mobileNumber) VALUES
(1, 'John Doe', '1990-05-15', '+94771234567'),
(2, 'jaya', '1995-05-22', '+94777654331'),
(3, 'Mike Wilson', '1995-12-03', '+94712345678'),
(4, 'Sarah Brown', '1988-03-30', '+94765432198'),
(5, 'Tom Davis', '1992-07-18', '+94723456789'),
(6, 'thinula', '1995-05-22', '+94777654331');
