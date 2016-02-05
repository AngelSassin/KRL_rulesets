ruleset track_trips {
	meta {
		name "track_trips"
		description <<
			Single Picos assignment: track_trips
			>>
		author "Nicholas Angell"
	}
	
	global {
		long_trip = 50
	}

	rule process_trip {
		select when car new_trip
		pre {
			m = event:attr("mileage");
			t = time:now();
		}
		{
			send_directive("trip") with
				length = m and
				timestamp = t;
		}
		fired {
			raise explicit event "trip_processed"
				with mileage = m
				and timestamp = t;
		}
	}
	
	rule find_long_trips {
		select when explicit trip_processed
		pre {
			length = event:attr("mileage")
		}
		fired {
			raise explicit event "found_long_trip"
				attributes event:attrs()
				if (length > long_trip);
		}
	}
}