import ballerina/io;
import ballerina/test;

@test:Config {
    groups: ["sample"]
}
function sampleTest() {
    io:println("Hello from test!");
}