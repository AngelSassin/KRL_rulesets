ruleset trip_store_test {
	meta {
		name "Trip Store Test"
		description <<
			Test for installation
			>>
		author "Nicholas Angell"
	}

	rule testingTrip {
		select when echo hello
		{
			send_directive("say") with
				something = "Hello World";
		}
	}
	
	rule testingTrip2 {
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