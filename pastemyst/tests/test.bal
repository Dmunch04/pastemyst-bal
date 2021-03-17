import ballerina/test;

isolated function assert(anydata val0, anydata val1, string msg) {
    if (val0 != val1) {
        panic error(msg);
    }
}

@test:Config {
    groups: ["http-client"]
}
function getLanguageRaw() {
    HttpClient api = new("");
    string language = "d";

    var result = checkpanic api.getLanguage(language);
    assert(checkpanic result.mode, language, "extensions does not match");
    assert(checkpanic result.color, "#ba595e", "colors does not match");
}

@test:Config {
    groups: ["http-client"]
}
function getPasteRaw() {
    HttpClient api = new("");
    string pasteId = "21y82rbw";

    var result = checkpanic api.getPaste(pasteId);
    assert(checkpanic result._id, pasteId, "ids does not match");
    assert(checkpanic result.title, "ada shellsort", "titles does not match");
    // TODO: How do we get the pasties in a "safe" way? (meaning its `json` not `json|error`)
    //assert(checkpanic result.pasties[0].language, "javascript", "languages does not match");
}

@test:Config {
    groups: ["http-client"]
}
function createPasteRaw() {
    // TODO: make this
}

@test:Config {
    groups: ["http-client"]
}
function editPasteRaw() {
    // TODO: make this
}

@test:Config {
    groups: ["http-client"]
}
function deletePasteRaw() {
    // TODO: make this
}

@test:Config {
    groups: ["http-client"]
}
function getExpireStampRaw() {
    // TODO: make this
}

@test:Config {
    groups: ["http-client"]
}
function userExistsRaw() {
    // TODO: make this
}

@test:Config {
    groups: ["http-client"]
}
function getUserRaw() {
    HttpClient api = new("");
    string username = "munchii";

    var result = checkpanic api.getUser(username);
    assert(checkpanic result.username, username, "usernames does not match");
    assert(checkpanic result.defaultLang, AUTODETECT, "default langs does not match");
    assert(checkpanic result.contributor, true, "contributor states does not match");
}