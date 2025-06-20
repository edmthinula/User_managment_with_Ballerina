import ballerina/sql;

# Fetch User Collections
# + return - List of User collections|Error
public isolated function fetchUserCollections() returns User[]|error {
    stream<User, sql:Error?> Userstream = UserPortalDb->query(fetchUsersCollectionsQuery());
    return from User user in Userstream
        select user;
}

# Fetch specific user collection.
#
# + name - Identification of the user collection
# + return - List of User collections|Error
public isolated function serachUserCollection(string name) returns User[]|sql:Error {
    stream<User, sql:Error?> result = UserPortalDb->query(searchUserCollectionQuery(name));
    return from User user in result
        select user;
}

# Fetch specific user collection.
#
# + id - Identification of the user collection
# + return - List of User collections|Error
public isolated function fetchUserCollection(int id) returns error?|User {
    User|sql:Error result = UserPortalDb->queryRow(getUserCollectionQuery(id));
    if result is sql:NoRowsError {
        return;
    }
    return result;

}

# Insert user collection.
#
# + user - User collection payload
# + return - List of User collections|Error
public isolated function createUser(UserCreate user) returns error? {
    _ = check UserPortalDb->execute(addUserCollectionQuery(user));
}

# update user collection.
#
# + user - User collection payload 
# + id - Identification of the user collection
# + return - Error
public isolated function updateUser(User user, int id) returns error? {
    sql:ExecutionResult userupdate = check UserPortalDb->execute(updateUserCollectionQuery(user, id));
    if userupdate.affectedRowCount == 0 {
        return;
    }
}

# Delete user collection.
#
# + id - Identification of the user collection
# + return - Error
public isolated function deleteUser(int id) returns error? {
    _ = check UserPortalDb->execute(
        deleteUserCollectionQuery(id)
        );
}
