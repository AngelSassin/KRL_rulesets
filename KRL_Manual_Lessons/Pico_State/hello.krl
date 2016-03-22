ruleset hello_world {
  meta {
    name "Hello World"
    description << A first ruleset for the Quickstart >>
    author "Nick Angell"
    logging on
    sharing on
    provides hello
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
      name = event:attr("name").defaultsTo(ent:name, "no name passed in");
    } 
    {
      send_directive("say") with
        greeting = "Hello #{name}";
    }
    always {
      log("LOG says Hello " + name);
    }
  }


  rule store_name {
    select when hello name
    pre {
      passed_name = event:attr("name").klog("Name passed in: ");
    }
    {
      send_directive("store_name") with
        name = passed_name;
    }
    always {
      set ent:name passed_name;
    }
  }


}