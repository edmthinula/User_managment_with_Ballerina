// import ballerina/http;
import ballerina/time;

public type User record {|
    readonly int id;
    string name;
    time:Date birthDate;
    string mobileNumber;
|};

public type UserCreate record {|
    string name;
    time:Date birthDate;
    string mobileNumber;
|};

// type DatabaseConfig record {|
//     string user;
//     string passsword;
//     string database;
//     string host;
//     int post;
// |};
