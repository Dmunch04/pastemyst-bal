import ballerina/http;

enum RequestMethod {
    GET = "GET",
    POST = "POST",
    PUT = "PUT",
    PATCH = "PATCH",
    DELETE = "DELETE"
}

string HTTP_ENDPOINT = "https://paste.myst.rs/api/v2";

public class HttpClient {

    private http:Client api;

    private string key;

    public function init(string key) {
        self.api = checkpanic new(HTTP_ENDPOINT);
        self.key = key;
    }

    private function get(string endpoint, json payload = null, boolean returnCode = false) returns @tainted json|error {
        return self.request(GET, endpoint, payload);
    }

    private function post(string endpoint, json payload = null, boolean returnCode = false) returns @tainted json|error {
        return self.request(POST, endpoint, payload);
    }

    private function put(string endpoint, json payload = null, boolean returnCode = false) returns @tainted json|error {
        return self.request(PUT, endpoint, payload);
    }

    private function patch(string endpoint, json payload = null, boolean returnCode = false) returns @tainted json|error {
        return self.request(PATCH, endpoint, payload);
    }

    private function delete(string endpoint, json payload = null, boolean returnCode = false) returns @tainted json|error {
        return self.request(DELETE, endpoint, payload);
    }

    private function request(RequestMethod method, string endpoint, json payload = null, boolean returnCode = false) returns @tainted json|error {
        http:Request req = new;

        req.addHeader("Content-Type", "application/json");
        if (self.key != "") {
            req.addHeader("Authorization", self.key);
        }

        if (payload != null) {
            req.setPayload(payload);
        }

        match method {
            GET => {
                var res = self.api->get(endpoint, req);
                return self.handleResponse(res, returnCode);
            }

            POST => {
                var res = self.api->post(endpoint, req);
                return self.handleResponse(res, returnCode);
            }

            PUT => {
                var res = self.api->put(endpoint, req);
                return self.handleResponse(res, returnCode);
            }

            PATCH => {
                var res = self.api->patch(endpoint, req);
                return self.handleResponse(res, returnCode);
            }

            DELETE => {
                var res = self.api->delete(endpoint, req);
                return self.handleResponse(res, returnCode);
            }

            _ => {
                return error("invalid request method: " + <string>method);
            }
        }
    }

    private function handleResponse(http:Response|http:PayloadType|error res, boolean returnCode = false) returns @untainted json|error {
        if (res is http:Response) {
            var msg = res.getJsonPayload();

            if (msg is json) {
                if (res.statusCode != 200) {
                    panic error("ERROR! " + msg.toJsonString());
                }
                
                if (returnCode) {
                    return [res.statusCode, msg];
                } else {
                    return msg;
                }
            } else {
                return error("invalid payload recieved: " + msg.message());
            }
        } else {
            return error("error when calling the backend: " + (<error>res).message());
        }
    }

    public function getLanguage(string name = "", string ext = "") returns @untainted json|error {
        string route;
        
        if (name != "") {
            route = string `/data/language?name=${name}`;
        } else if (name == "" && ext != "") {
            route = string `/data/languageExt?extension=${ext}`;
        } else {
            return error("no name or extension given");
        }

        return self.get(route);
    }

    public function getPaste(string pasteId) returns @untainted json|error {
        string route = string `/paste/${pasteId}`;
        return self.get(route);
    }

    public function createPaste(Paste paste) returns @untainted json|error {
        string route = string `/paste`;

        // TODO: delete `isPrivate`, `isPublic` and `tags` if not key is set
        // TODO: actually maybe make a util function to convert `Paste` into json data so we get the right fields only
        json|error pasteJson = paste.cloneWithType(json);
        if (pasteJson is json) {
            return self.post(route, pasteJson);
        } else {
            return error("could not convert given paste to json");
        }
    }

    public function editPaste(Paste paste) returns @untainted json|error {
        // TODO: i cant use the paste's `_id` field because its optional
        //string route = string `/paste/${paste._id}`;
        string route = string `/paste/id`;

        json|error pasteJson = paste.cloneWithType(json);
        if (pasteJson is json) {
            // TODO: make sure `pasteJson` has the `_id` field set and so does all the pasties
            return self.patch(route, pasteJson);
        } else {
            return error("could not convert given paste to json");
        }
    }

    public function deletePaste(string pasteId) returns @untainted json|error {
        string route = string `/paste/${pasteId}`;
        // TODO: find out a way to return the response status code instead
        return self.delete(route);
    }

    // TODO: why cant i take in `ExpiresIn` as the param type? maybe thats just how it is
    public function getExpireUnix(int createdAt, string expiresIn) returns @untainted json|error {
        string route = string `/time/expiresInToUnixTime?createdAt=${createdAt}&expiresIn=${expiresIn}`;
        return self.get(route);
    }

    public function getUserExists(string username) returns @untainted json|error {
        string route = string `/user/${username}/exists`;
        // TODO: find out a way to return the response status code instead
        return self.get(route);
    }

    public function getUser(string username) returns @untainted json|error {
        string route = string `/user/${username}`;
        return self.get(route);
    }
}