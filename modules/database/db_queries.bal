import ballerina/sql;

isolated function fetchUsersCollectionsQuery() returns sql:ParameterizedQuery => 
    `SELECT * FROM users`;

isolated function searchUserCollectionQuery(string name) returns sql:ParameterizedQuery =>
    `SELECT * FROM users WHERE name = ${name}`;

isolated function getUserCollectionQuery(int id) returns sql:ParameterizedQuery =>
    `SELECT * FROM users WHERE id = ${id}`;
isolated function addUserCollectionQuery (User user) returns sql:ParameterizedQuery =>
    `INSERT INTO users (id,name,birthDate,mobileNumber) VALUES (${user.id},${user.name},${user.birthDate},${user.mobileNumber})`;

isolated function updateUserCollectionQuery (User user,int id) returns sql:ParameterizedQuery =>
    `UPDATE users SET name = ${user.name}, birthDate = ${user.birthDate}, mobileNumber = ${user.mobileNumber} WHERE id = ${id}`;

isolated  function deleteUserCollectionQuery (int id) returns sql:ParameterizedQuery => 
    `DELETE FROM users WHERE id = ${id}`;