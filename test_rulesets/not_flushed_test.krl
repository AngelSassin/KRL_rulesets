ruleset not_flushed_test {
	meta {
		name "Not Flushed Test"
		description <<
			Testing how devtools reacts to a ruleset that is not flushed
			>>
		author "Nicholas Angell"
	}
	
	rule test_for_no_flush{
		select when echo message
		{
			send_directive("test") with
				not_flushed = "This ruleset should not be flushed for a proper test. If this shows, this ruleset IS FLUSHED."
		}
	}
}