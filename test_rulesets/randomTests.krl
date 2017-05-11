ruleset randomTests {
  rule hello_monkey {
    select when echo monkey
    pre {
      name = event:attr("name").defaultsTo("Monkey", "no name given");
    }
    send_directive("say") with
      something = "Hello " + name
  }
}
