import ballerina/time;
import ballerina/http;

type User record {|
    readonly int id;
    string name;
    time:Date birthDate;
    string mobileNumber;
|};

type UserNotFound record {|
    *http:NotFound;
    record {
        string message;
    }body;
|};
