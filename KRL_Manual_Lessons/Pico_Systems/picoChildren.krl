ruleset picoChildren {

  meta {
    name "picoChildren"
    description <<
      Pico-Based Systems Lesson
      >>
    author "Nicholas Angell"
  }
  
  rule createChildren {
    select when parent create_child
    pre{
      attributes = {}
          .put(["Prototype_rids"],"") // rulesets needed at install, semicolon separated
          .put(["name"],"Pico_System_Child") // name for child
          ;
    }
    {
      event:send({"cid":meta:eci()}, "wrangler", "child_creation")  // wrangler os event.
      with attrs = attributes.klog("attributes: "); // needs a name attribute for child
    }
    always {
      log("create child for " + child);
    }
  }

  rule deletePico {
    select when parent delete_pico
    pre{
    }
    {
      noop();
    }
    always {
   
    }
  }



}