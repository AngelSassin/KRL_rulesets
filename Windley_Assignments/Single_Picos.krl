ruleset echo {
	rule hello {
		select when echo hello
		{
			send_directive("say") with
				something = "Hello World";
		}
	}
	
	rule message {
		select when echo message 
		pre {
			msg = event:attr("input")
		}
		{
			send_directive("say") with
				something = msg;
		}
	}
}