import User_managment_with_Ballerina.database as db_module;

import ballerina/http;
import ballerina/sql;

service / on new http:Listener(9095) {

    # Fetch all User from the database.
    #
    # + return - All user|Error
    resource isolated function get userall() returns db_module:User[]|error {
        db_module:User[]|error Users = db_module:fetchUserCollections();
        return Users;
    }

    # Fetch specific User from the database.
    #
    # + name - Name to filter
    # + return - Users|Error|UserNotfound|InternalError|
    resource isolated function get users(string name) returns http:InternalServerError|http:NotFound|db_module:User[]|sql:Error {
        db_module:User[]|sql:Error usersReturn = db_module:serachUserCollection(name);
        if usersReturn is sql:Error {
            return http:INTERNAL_SERVER_ERROR;
        } else if usersReturn.length() == 0 {
           return <http:NotFound>{body: string `User with ${name} not found`};
        }
        return usersReturn;
    }
    # Fetch specific User from the database.
    #
    # + id - Id to filter
    # + return - All User|Error|UserNotfound|InternalError|
    resource isolated function get user/[int id]() returns db_module:User|http:NotFound|error?|http:InternalServerError {
        db_module:User|error? result = db_module:fetchUserCollection(id);
        if result is error {
            return http:INTERNAL_SERVER_ERROR;
        } else if result is () {
            return <http:NotFound>{body: string `User ${id} not found`};
        }
        return result;

    }
    # Insert User collection.
    #
    # + user - new User
    # + return - Error|Created|InternalError
    resource function post user(db_module:UserCreate user) returns http:InternalServerError|http:Created {

        error? userCreate = db_module:createUser(user);
        if userCreate is error {
            return http:INTERNAL_SERVER_ERROR;
        } else {
            return http:CREATED;
        }
    }

    # Update User collection.
    #
    # + id - Id to filter
    # + user - new User
    # + return - |ErrorUserNotfound|InternalError|Ok
    resource function put user/[int id](db_module:User user) returns http:NotFound|error?|http:Ok|http:InternalServerError {
        db_module:User|error? result = db_module:fetchUserCollection(id);
        if result is error {
            return http:INTERNAL_SERVER_ERROR;
        } else if result is () {
            return <http:NotFound>{body: string `User ${id} not found`};
        }

        error? userupdate = db_module:updateUser(user, id);
        if userupdate is () {
            return error(string `User ${id} not created`);
        }
        return http:OK;
    }

    # Delete User collection from database.
    #
    # + id - Id to filter
    # + return - |ErrorUserNotfound|InternalError|NoContent
    resource function delete user/[int id]() returns http:InternalServerError|http:NotFound|http:NoContent {
        db_module:User|error? result = db_module:fetchUserCollection(id);
        if result is error {
            return http:INTERNAL_SERVER_ERROR;
        } else if result is () {
            return <http:NotFound>{body: string `User ${id} not found`};
        }

        error? deleteResult = db_module:deleteUser(id);
        if deleteResult is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:NO_CONTENT;
    }
}
