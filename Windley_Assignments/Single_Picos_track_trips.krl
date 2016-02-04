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
			mileage = event:attr("mileage");
			
		}
		{
			send_directive("trip") with
				length = mileage
		}
		fired {
			raise explicit event "trip_processed"
				attributes event:attrs()
		}
	}
	
	rule find_long_trips {
		select when explicit trip_processed
		pre {
			length = event:attr("mileage")
		}
		fired {
			raise explicit event "found_long_trip"
				with mileage = length
				and timestamp = event:attr("timestamp")
				if (length > long_trip);
		}
	}
}