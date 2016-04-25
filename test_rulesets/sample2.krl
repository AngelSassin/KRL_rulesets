ruleset sample2 {
	meta {
		name "Sample Ruleset 2"
		author "Nicholas Angell"
		description <<Not much to see here 2>>
		sharing on
		provides do_thing, do_other_thing
	}

	global {
		do_thing = function() {
			6;
		}
		do_other_thing = function() {
			5;
		}
	}

	rule sample_rule {
		select when sample test
		pre {

		}
		{
			noop();
		}
	}
}
