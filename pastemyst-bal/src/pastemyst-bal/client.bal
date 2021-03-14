public class Client {
    string key;

    HttpClient http;

    function init(string key = "") {
        self.key = key;
        self.http = new(self);
    }
}