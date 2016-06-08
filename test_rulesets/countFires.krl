ruleset countFires {
	meta {
		name "Count Fires"
		description << Count times a rule fires >>
		author "Nicholas Angell"
		sharing on
		provides getCount, cancelSchedule
	}

	global {
		getCount = function() {
			ent:count;
		}
		cancelSchedule = function(id) {
			event:delete(id);
		}
		getScheduled = function() {
			event:get_list();
		}
	}

	rule count {
		select when do_main night_fire
		pre {
			c = ent:count + 1;
		}
		{
			send_directive("night_fire detected")
				with count = c;
		}
		fired {
			set ent:count c;
		}
	}

	rule createSchedule {
		select when begin scheduling
		pre {
			do_main = "do_main";
			c = ent:count;
		}
		{
			send_directive("night_fire scheduled")
				with count = c;
		}
		fired {
			schedule do_main event night_fire repeat "0 * * * *";
		}
	}

	rule cancelSchedule {
		select when cancel scheduling
		pre {
			id = event:attr("id");
		}
		{
			send_directive("canceled Schedule")
				with eventID = id;
			cancelSchedule(id);
		}
		fired {
			log("Cancelled Scheduled Event");
		}
	}
}