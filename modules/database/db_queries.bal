import ballerina/sql;

# Build query to add a User collection.
#
# + return - sql:ParameterizedQuery - select query for the user collection table
isolated function fetchUsersCollectionsQuery() returns sql:ParameterizedQuery => 
    `SELECT * FROM users`;

# Build query to add a User collection.
#
# + name - name to filter
# + return - sql:ParameterizedQuery - select query for the user collection table

isolated function searchUserCollectionQuery(string name) returns sql:ParameterizedQuery =>
    `SELECT * FROM users WHERE name = ${name}`;

# Build query to add a User collection.
#
# + id - id to filter
# + return - sql:ParameterizedQuery - select query for the user collection table
isolated function getUserCollectionQuery(int id) returns sql:ParameterizedQuery =>
    `SELECT * FROM users WHERE id = ${id}`;

# Build query to add a User collection.
#
# + user - User collection to be added
# + return - sql:ParameterizedQuery - Insert query for the user collection table

isolated function addUserCollectionQuery (UserCreate user) returns sql:ParameterizedQuery =>
    `INSERT INTO users (name,birthDate,mobileNumber) VALUES (${user.name},${user.birthDate},${user.mobileNumber})`;

# Build query to add a User collection.
#
# + user - User collection to be added
# + id - id to filter
# + return - sql:ParameterizedQuery - Update query for the user collection table

isolated function updateUserCollectionQuery (User user,int id) returns sql:ParameterizedQuery =>
    `UPDATE users SET name = ${user.name}, birthDate = ${user.birthDate}, mobileNumber = ${user.mobileNumber} WHERE id = ${id}`;

# Build query to add a User collection.
#
# + id - id to filter
# + return - sql:ParameterizedQuery - delete query for the user collection table

isolated  function deleteUserCollectionQuery (int id) returns sql:ParameterizedQuery => 
    `DELETE FROM users WHERE id = ${id}`;