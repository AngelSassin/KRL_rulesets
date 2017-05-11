ruleset randomTests {
  meta {
    shares __testing
  }

  global {
    
  }

  rule hello_monkey {
    select when echo monkey
    pre {
      name = event:attr("name").defaultsTo("Monkey", "no name given");
    }
    send_directive("say") with
      something = "Hello " + name
  }
}
