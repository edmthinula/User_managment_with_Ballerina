import ballerina/time;

type User record {|
    readonly int id;
    string name;
    time:Date birthDate;
    string mobileNumber;
|};
