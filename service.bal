import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

import User_managment_with_Ballerina.database as db_fun ;

service / on new http:Listener(9090) {
    final mysql:Client db;

    function init() returns error? {
        self.db = check new ("localhost", "root", "", "bal", 3306);
    }

    resource isolated function get userall() returns User[]|error {
        User[]|error Users = db_fun:fetchUserCollections();
        return Users;
    }

    
    resource isolated function get users(string name) returns User[]|sql:Error|UserNotFound {
        stream<User, sql:Error?> result = self.db->query(`SELECT * FROM users WHERE name = ${name}`);
        User[]|sql:Error usersReturn = check from User user in result
            select user;
        if usersReturn is sql:Error || usersReturn.length() == 0 {
            return {body: {message: string `User with ${name} not found`}};
        } else {
            return usersReturn;
        }
    }

    resource isolated function get user/[int id]() returns User|UserNotFound|error {
        User|sql:Error result = self.db->queryRow(`SELECT * FROM users WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return {body: {message: string `User ${id} not found`}};
        } else {
            return result;
        }
    }

    resource function post user(User user) returns http:Created|error {
        sql:ExecutionResult userCreate = check self.db->execute(`INSERT INTO users (id,name,birthDate,mobileNumber) VALUES (${user.id},${user.name},${user.birthDate},${user.mobileNumber});`);
        if userCreate.affectedRowCount == 0 {
            return error(string `user not created`);
        } else {
            return http:CREATED;
        }
    }

    resource function put user/[int id](User user) returns http:NotFound|error|http:Ok {
        User|sql:Error result = self.db->queryRow(`SELECT * FROM users WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        }
        sql:ExecutionResult userupdate = check self.db->execute(
            `UPDATE users SET name = ${user.name}, birthDate = ${user.birthDate}, mobileNumber = ${user.mobileNumber} WHERE id = ${id}`);
        if userupdate.affectedRowCount == 0  {
            return error(string `User ${id} not created`);
        } else {
            return http:OK;
        }
    }

    resource function delete user/[int id]() returns http:NotFound|error|http:Ok {
        User|sql:Error result = self.db->queryRow(`SELECT * FROM users WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        }
        sql:ExecutionResult resultDelete = check self.db->execute(
        `DELETE FROM users WHERE id = ${id}`
        );
        if resultDelete.affectedRowCount == 0 {
            return error(string `User ${id} not deleted`);
        } else {
            return http:OK;
        }
    }
}
