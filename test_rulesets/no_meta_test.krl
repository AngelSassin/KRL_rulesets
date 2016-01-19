ruleset no_meta_test {
	rule test_test{
		select when echo message
		{
			send_directive("test") with
				no_meta = "There's no name, description, or author!"
		}
	}
}