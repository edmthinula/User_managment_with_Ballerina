import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/sql;

service / on new http:Listener(9090) {

    final mysql:Client db;

    function init() returns error? {
        self.db = check new("localhost","root","","bal",3306);
        // if self.db is (){
        //     io:Printable(error)
        // }
        
    }
    resource function get users() returns User[]|error {
        stream<User,sql:Error?> Userstream = self.db->query(`SELECT * FROM users`);
        return from User user in Userstream 
        select user;
    }

    resource function get user/[int id]() returns User|http:NotFound|error{
        User|sql:Error result = self.db->queryRow(`SELECT * FROM users WHERE id = ${id}`);
        if result is sql:NoRowsError{
            return http:NOT_FOUND;
        }else {
            return result;
        }
    }

    resource function get user(string name)returns User|http:NotFound|error {
        User|sql:Error result = self.db->queryRow(`SELECT * FROM users WHERE name = ${name}`);
        if result is sql:NoRowsError{
            return http:NOT_FOUND;
        }else {
            return result;
        }
    }

    resource function post user(User user) returns User|error {
        _=check self.db->execute(`INSERT INTO users (id,name,birthDate,mobileNumber) VALUES (${user.id},${user.name},${user.birthDate},${user.mobileNumber});`);
        return user;
    }

    resource function put user(User user) returns User|http:NotFound {
        User|
    }
    // resource function get users(string name) returns User[]|http:NotFound{

    // }
}
