import ballerina/io;

public function main() {
    io:println("Hello, World!");
    Client c = new;
    io:println(c.http.get("/paste/21y82rbw"));
}