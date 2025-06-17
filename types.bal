import ballerina/time;

type User record {|
    int id;
    string name;
    time:Date bithDate;
    string mobileNumber;
|};

