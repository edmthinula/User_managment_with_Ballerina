import ballerina/sql;

public isolated function fetchUserCollections() returns User[]|error {
    stream<User, sql:Error?> Userstream = self.db->query(fetchUsersCollectionsQuery());
    return from User user in Userstream
        select user;
}

public isolated function serachUserCollection(string name) returns User[]|sql:Error|UserNotFound {
    stream<User, sql:Error?> result = self.db->query(searchUserCollectionQuery(name));
    User[]|sql:Error usersReturn = check from User user in result
        select user;
    if usersReturn is sql:Error || usersReturn.length() == 0 {
        return {body: {message: string `User with ${name} not found`}};
    } else {
        return usersReturn;
    }
}

public isolated function fetchUserCollection(int id) returns User|sql:Error {
    User|sql:Error result = self.db->queryRow(getUserCollectionQuery(int id));
    if result is sql:NoRowsError {
        return result;
    } else {
        return result;
    }
}

public isolated function createUser(User user) returns http:Created|error {
    sql:ExecutionResult userCreate = check self.db->execute(addUserCollectionQuery(User user));
    if userCreate.affectedRowCount == 0 {
        return error(string `user not created`);
    } else {
        return http:CREATED;
    }
}

public isolated function updateUser(User user, int id) returns http:NotFound|error|http:Ok {
    fetchUserCollection(int id);
    sql:ExecutionResult userupdate = check self.db->execute(updateUserCollectionQuery(user, id));
    if userupdate.affectedRowCount == 0 {
        return error(string `User ${id} not created`);
    } else {
        return http:OK;
    }
}

public isolated function deleteUser(int id) returns http:NotFound|error|http:Ok {
    etchUserCollection(int id);
    if result is sql:NoRowsError {
        return http:NOT_FOUND;
    }
    sql:ExecutionResult resultDelete = check self.db->execute(
        deleteUserCollectionQuery(id)
        );
    if resultDelete.affectedRowCount == 0 {
        return error(string `User ${id} not deleted`);
    } else {
        return http:OK;
    }
}
