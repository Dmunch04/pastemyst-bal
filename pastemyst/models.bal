public enum ExpiresIn {
    ONE_HOUR = "1h",
    TWO_HOURS = "2h",
    TEN_HOURS = "10h",
    ONE_DAY = "1d",
    TWO_DAYS = "2d",
    ONE_WEEK = "1w",
    ONE_MONTH = "1m",
    ONE_YEAR = "1y",
    NEVER = "never"
}

// TODO: this might not work (having the numbers in string literals)
public enum EditType {
    TITLE = "0",
    PASTY_TITLE = "1",
    PASTY_LANGUAGE = "2",
    PASTY_CONTENT = "3",
    PASTY_ADDED = "4",
    PASTY_REMOVED = "5"
}

public type Paste record {|
    string _id?;
    string ownerId?;
    string title;
    int createdAt?;
    ExpiresIn expiresIn;
    int deletesAt?;
    int stars?;
    boolean isPrivate?;
    boolean isPublic?;
    string[] tags?;
    Pasty[] pasties;
    PasteEdit[] edits?;
|};

public type Pasty record {|
    string _id?;

    Language language;
    string title;
    string code;
|};

public type PasteEdit record {|
    string _id;
    string editId;
    EditType editType;
    string[] metadata;
    string edit;
    int editedAt;
|};

public enum Language {
    AUTODETECT = "Autodetect",
    PLAIN = "Plain Text",
    APL = "APL",
    PGP = "PGP",
    ASN1 = "ASN.1",
    ASTERISK = "Asterisk",
    BRAINFUCK = "Brainfuck",
    CLANG = "C",
    C = "C",
    CPP = "C++",
    COBOL = "Cobol",
    CSHARP = "C#",
    CLOJURE = "Clojure",
    CLOJURE_SCRIPT = "ClojureScript",
    GSS = "Closure Stylesheets (GSS)",
    CMAKE = "CMake",
    COFFEE_SCRIPT = "CoffeeScript",
    LISP = "Common Lisp",
    CYPHER = "Cypher",
    CYTHON = "Cython",
    CRYSTAL = "Crystal",
    CSS = "CSS",
    CQL = "CQL",
    DLANG = "D",
    D = "D",
    DART = "Dart",
    DIFF = "diff",
    DJANGO = "Django",
    DOCKER = "Dockerfile",
    DTD = "DTD",
    DYLAN = "Dylan",
    EBNF = "EBNF",
    ECL = "ECL",
    EDN = "edn",
    EIFFEL = "Eiffel",
    ELM = "Elm",
    EJS = "Embedded Javascript",
    ERB = "Embedded Ruby",
    ERLANG = "Erlang",
    ESPER = "Esper",
    FACTOR = "Factor",
    FCL = "FCL",
    FORTH = "Forth",
    FORTRAN = "Fortran",
    FSHARP = "F#",
    GAS = "Gas",
    GHERKIN = "Gherkin",
    GFM = "GitHub Flavored Markdown",
    GITHUB_MARKDOWN = "GitHub Flavored Markdown",
    GO = "Go",
    GROOVY = "Groovy",
    HAML = "HAML",
    HASKELL = "Haskell",
    HASKELL_LITERATE = "Haskell (Literate)",
    HAXE = "Haxe",
    HXML = "HXML",
    ASP_NET = "ASP.NET",
    HTML = "HTML",
    HTTP = "HTTP",
    IDL = "IDL",
    PUG = "Pug",
    JAVA = "Java",
    JSP = "Java Server Pages",
    JAVASCRIPT = "JavaScript",
    JSON = "JSON",
    JSON_LD = "JSON-LD",
    JSX = "JSX",
    JINJA2 = "Jinja2",
    JULIA = "Julia",
    KOTLIN = "Kotlin",
    LESS = "LESS",
    LIVESCRIPT = "LiveScript",
    LUA = "Lua",
    MARKDOWN = "Markdown",
    MIRC = "mIRC",
    MARIA_DB = "MariaDB SQL",
    MATHEMATICA = "Mathematica",
    MODELICA = "Modelica",
    MUMPS = "MUMPS",
    MS_SQL = "MS SQL",
    MBOX = "mbox",
    MYSQL = "MySQL",
    NGINX = "Nginx",
    NSIS = "NSIS",
    NTRIPLES = "NTriples",
    OBJ_C = "Objective-C",
    OCAML = "OCaml",
    OCTAVE = "Octave",
    OZ = "Oz",
    PASCAL = "Pascal",
    PEG_JS = "PEG.js",
    PERL = "Perl",
    PHP = "PHP",
    PIG = "Pig",
    PLSQL = "PLSQL",
    POWERSHELL = "PowerShell",
    INI = "Properties files",
    PROTOBUF = "ProtoBuf",
    PYTHON = "Python",
    PUPPET = "Puppet",
    QLANG = "Q",
    RSCRIPT = "R",
    RST = "reStructuredText",
    RPM_CHANGES = "RPM Changes",
    RPM_SPEC = "RPM Spec",
    RUBY = "Ruby",
    RUST = "Rust",
    SAS = "SAS",
    SASS = "Sass",
    SCALA = "Scala",
    SCHEME = "Scheme",
    SCSS = "SCSS",
    SHELL = "Shell",
    SIEVE = "Sieve",
    SLIM = "Slim",
    SMALLTALK = "Smalltalk",
    SMARTY = "Smarty",
    SOLR = "Solr",
    SML = "SML",
    SOY = "Soy",
    SPARQL = "SPARQL",
    SPREADSHEET = "Spreadsheet",
    SQL = "SQL",
    SQLITE = "SQLite",
    SQUIRREL = "Squirrel",
    STYLUS = "Stylus",
    SWIFT = "SWIFT",
    STEX = "sTeX",
    LATEX = "LaTeX",
    SYSTEM_VERILOG = "SystemVerilog",
    TCL = "Tcl",
    TEXTILE = "Textile",
    TIDDLYWIKI = "TiddlyWiki",
    TIKI_WIKI = "Tiki Wiki",
    TOML = "TOML",
    TORNADO = "Tornado",
    TROFF = "troff",
    TTCN = "TTCN",
    TTCN_CFG = "TTCN_CFG",
    TURTLE = "Turtle",
    TYPESCRIPT = "TypeScript",
    TYPESCRIPT_JSX = "TypeScript-JSX",
    TWIG = "Twig",
    WEB_IDL = "Web IDL",
    VB_NET = "VB.NET",
    VBSCRIPT = "VBScript",
    VELOCITY = "Velocity",
    VERILOG = "Verilog",
    VHDL = "VHDL",
    VUE = "Vue.js Component",
    XML = "XML",
    XQUERY = "XQuery",
    YACAS = "Yacas",
    YAML = "YAML",
    Z80 = "Z80",
    MSCGEN = "mscgen",
    XU = "xu",
    MSGENNY = "msgenny"
}