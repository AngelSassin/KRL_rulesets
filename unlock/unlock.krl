ruleset unlock {
  meta {
    name "Unlock Door"
    description <<
A test ruleset for Nick_Angell
>>
    author "Nick Angell"
    logging on
    sharing on
    provides get_code
 
  }
  
  global {
    get_code = function(name) {
      (name == "Nick_Angell") => "code: " + obj | "INVALID NAME"
    };
	unlock = function(code) {
	  (code == 1234) => "UNLOCKED" | "LOCKED"
	}
  }
  
  rule unlock_door {
    select when echo hello
    pre{
      code = event:attr("code").klog("our passed in code: ");
    }{
      send_directive("say") with
        door_condition = unlock(code);
    }
    always {
      log "LOG: Door is " + door_condition ;
    }
  }
 
}