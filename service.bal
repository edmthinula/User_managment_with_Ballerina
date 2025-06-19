import ballerina/http;
import ballerina/sql;

import User_managment_with_Ballerina.database as db_module;

service / on new http:Listener(9090) {

    resource isolated function get userall() returns db_module:User[]|error {
        db_module:User[]|error Users = db_module:fetchUserCollections();
        return Users;
    }

    
    resource isolated function get users(string name) returns http:InternalServerError|UserNotFound|db_module:User[]|sql:Error{
        db_module:User[]|sql:Error usersReturn = db_module:serachUserCollection(name);
        if usersReturn is sql:Error {
            return http:INTERNAL_SERVER_ERROR;
        } else if usersReturn.length() == 0 {
            UserNotFound userNotFound = {body: {message: string `User with ${name} not found`}};
             return userNotFound;
        }
        return usersReturn;
    }

    resource isolated function get user/[int id]() returns db_module:User|UserNotFound|error?|http:InternalServerError{
        db_module:User|error? result = db_module:fetchUserCollection(id);
        if result is error {
        return http:INTERNAL_SERVER_ERROR;
        } else if result is () {   
            UserNotFound userNotFound = {body: {message: string `User ${id} not found`}};
            return userNotFound;
        }
        return result;

    }

    resource function post user(db_module:UserCreate user) returns http:InternalServerError|http:Created{

        error? userCreate = db_module:createUser(user);
        if userCreate is error {
            return http:INTERNAL_SERVER_ERROR;
        } else {
            return http:CREATED;
        }
    }

    resource function put user/[int id](db_module:User user) returns UserNotFound|error?|http:Ok |http:InternalServerError{
        db_module:User|error? result = db_module:fetchUserCollection(id);
        if result is error {
        return http:INTERNAL_SERVER_ERROR;
        } else if result is () {   
             UserNotFound userNotFound = {body: {message: string `User ${id} not found`}};
            return userNotFound;
        }


        error? userupdate = db_module:updateUser(user , id);
        if userupdate is () {
            return error(string `User ${id} not created`);
        } 
        return http:OK;
    }

    resource function delete user/[int id]() returns http:InternalServerError|UserNotFound |http:NoContent{
        db_module:User|error? result = db_module:fetchUserCollection(id);
        if result is error {
        return http:INTERNAL_SERVER_ERROR;
        } else if result is () {   
            UserNotFound userNotFound = {body: {message: string `User ${id} not found`}};
            return userNotFound;
        }

        error? deleteResult = db_module:deleteUser(id);
        if deleteResult is error {
           return http:INTERNAL_SERVER_ERROR; 
        }   
        return http:NO_CONTENT;
    }
}
