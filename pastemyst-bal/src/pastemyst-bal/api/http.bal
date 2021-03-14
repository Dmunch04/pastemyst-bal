import ballerina/io;
import ballerina/http;

enum RequestMethod {
    GET,
    POST,
    PATCH,
    DELETE
}

public class HttpClient {
    private http:Client http;

    private Client c;
    private string key;

    function init(Client c) {
        self.http = new(API_ENDPOINT);
        self.c = c;
    }

    private function get(string endpoint, json data = null) returns @tainted json? {
        return self.request(GET, endpoint, data);
    }

    private function post(string endpoint, json data = null) returns @tainted json? {
        return self.request(POST, endpoint, data);
    }

    private function patch(string endpoint, json data = null) returns @tainted json? {
        return self.request(PATCH, endpoint, data);
    }

    private function delete(string endpoint, json data = null) returns @tainted json? {
        return self.request(DELETE, endpoint, data);
    }

    private function request(RequestMethod method, string endpoint, json data = null) returns @tained json? {
        http:Request request = new;

        if (self.key != "") {
            request.addHeader("Authorization", self.key);
        }

        request.addHeader("User-Agent", "PasteMystBot (v1.0)");
        request.addHeader("content-type", "application/json");

        if (data != null) {
            request.setPayload(data);
        }

        match method {
            GET => {
                var response = self.http->get(endpoint, request);
                return self.handleResponse(response);
            }

            POST => {
                var response = self.http->put(endpoint, request);
                return self.handleResponse(response);
            }

            PATCH => {
                var response = self.http->patch(endpoint, request);
                return self.handleResponse(response);
            }

            DELETE => {
                var response = self.http->delete(endpoint, request);
                return self.handleResponse(response);
            }

            _ => {
                io:println("invalid request method type: ", method);
            }
        }
    }

    private function handleResponse(http:Response|error res) returns @tainted json? {
        if (response is http:Response) {
            var msg = response.getJsonPayload();

            if (msg is json) {
                if (response.statusCode != 200) {
                    io:println("ERROR! " + msg.toJsonString());
                    return;
                }
                return msg;
            } else {
                io:println("Invalid payload recieved");
                return;
            }
        } else {
            io:println("Error when calling the backend: ", response.reason());
            return;
        }
    }
};