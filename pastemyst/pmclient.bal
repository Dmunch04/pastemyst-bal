public class Client {
    
    private HttpClient api;

    public function init(string key = "") {
        self.api = new(key);
    }
}