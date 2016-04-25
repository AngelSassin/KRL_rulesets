ruleset sample {
	meta {
		name "Sample Ruleset"
		author "Nicholas Angell"
		description <<Not much to see here>>
		sharing on
		provides do_thing, do_other_thing
	}

	global {
		do_thing = function() {
			6;
		}
		do_other_thing = function(x) {
			x + 5;
		}
	}

	rule sample_rule {
		select when sample test
		pre {

		}
		{
			noop();
		}
		always {

		}
	}
}