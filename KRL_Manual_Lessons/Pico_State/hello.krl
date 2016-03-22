ruleset hello_world {
  meta {
    name "Hello World"
    description << A first ruleset for the Quickstart >>
    author "Nick Angell"
    logging on
    sharing on
    provides hello, greet
  }


  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
    greet = function() {
      msg = "Hello " + ent:name
      msg
    }
  }

  
  rule hello_world {
    select when echo hello
    pre {
      id = event:attr("id").defaultsTo("_0","no id passed.");
      first = ent:name{[id,"name","first"]};
      last = ent:name{[id,"name","last"]};
    } 
    {
      send_directive("say") with
        greeting = "Hello #{first} #{last}";
    }
    always {
      log("LOG says Hello " + first + " " + last);
    }
  }


  rule store_name {
    pre {
      id = event:attr("id").klog("id passed in: ");
      first = event:attr("first").klog("first passed in: ");
      last = event:attr("last").klog("last passed in: ");
      init = {"_0":{ "name":{
                        "first":"Null",
                        "last":"Name"} } }
    }
    {
      send_directive("store_name") with
      passed_id = id and
      passed_first = first and
      passed_last = last;
    }
    always {
      set ent:name init if not ent:name{["_0"]}; // initialize if not created. 
        // Table in data base must exist for sets of hash path to work.
      set ent:name{[id,"name","first"]}  first;
      set ent:name{[id, "name", "last"]}  last; 
    }
  }


}