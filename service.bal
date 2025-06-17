import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

service / on new http:Listener(9090) {

    final mysql:Client db;

    function init() returns error? {
        self.db = check new("localhost","root","","bal",3306);
        // if self.db is (){
        //     io:Printable(error)
        // }
        
    }
    resource function get users() returns User|http:NotFound {
        
    }

    // resource function get user/[int id]() returns User|http:NotFound{

    // }

    // resource function get users(string name) returns User[]|http:NotFound{

    // }
}
