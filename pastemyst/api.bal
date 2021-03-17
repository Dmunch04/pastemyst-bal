import ballerina/io;
import ballerina/http;

private enum RequestMethod {
    GET,
    POST,
    PUT,
    PATCH,
    DELETE
}

private const string BASE_URL = "https://paste.myst.rs";

public class HttpClient {

    private http:Client api;

    private string key;

    public function init(string key) {
        self.key = key;
    }

    private function get(string endpoint, json payload = null) {
        return self.request(GET, endpoint, payload);
    }

    private function post(string endpoint, json payload = null) {
        return self.request(POST, endpoint, payload);
    }

    private function put(string endpoint, json payload = null) {
        return self.request(PUT, endpoint, payload);
    }

    private function patch(string endpoint, json payload = null) {
        return self.request(PATCH, endpoint, payload);
    }

    private function delete(string endpoint, json payload = null) {
        return self.request(DELETE, endpoint, payload);
    }

    private function request(RequestMethod method, string endpoint, json payload = null) returns @tainted json? {
        http:Request req = new;

        req.addHeader("Content-Type", "application/json")
        if (self.key != "") {
            req.addHeader("Authorization", self.key);
        }

        if (payload != null) {
            req.setPayload(payload);
        }

        endpoint = BASE_URL + endpoint;

        var res = null;
        match method {
            GET => {
                response = self.api->get(endpoint, request);
            }

            POST => {
                response = self.api->post(endpoint, request);
            }

            PUT => {
                response = self.api->put(endpoint, request);
            }

            PATCH => {
                response = self.api->patch(endpoint, request);
            }

            DELETE => {
                response = self.api->delete(endpoint, request);
            }

            _ => {
                io:println("invalid request method: ", method);
            }
        }

        return self.handleResponse(response);
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
                io:println("invalid payload recieved");
                return;
            }
        } else {
            io:println("error when calling the backend: ", response.reason());
            return;
        }
    }

    public function getLanguage(string? name = null, string? ext = null) returns @tainted json? {
        string route;
        
        if (name != null) {
            route = string `/data/language?name=${name}`;
        } else if (name is null && ext != null) {
            route = string `/data/languageExt?extension=${ext}`;
        } else {
            panic error("no name or extension given");
        }

        return self.get(route);
    }

    public function getPaste(string pasteId) returns @tainted json? {
        string route = string `/paste/{pasteId}`;
        return self.get(route);
    }

    public function createPaste() returns @tained json? {
        string route = string `/paste`;
    }
}