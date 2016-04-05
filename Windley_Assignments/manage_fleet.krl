ruleset manage_fleet {

	meta {
    	name "manage_fleet"
    	description <<
      		Fleet Management Assignment
      		>>
    	author "Nicholas Angell"
    	use module b507199x5 alias wranglerOS
    	sharing on
    	provides vehicles
  	}

	global {
		vehicles = function() {
			results = wranglerOS:subscriptions();
			subscriptions = results{"subscriptions"};
			subscriptions;
		}
	}
	
	rule create_vehicle {
		select when car new_vehicle
		pre {
			child_name = event:attr("name");
     		attributeList = {}
          		.put(["Prototype_rids"],"b507707x4.prod;b507707x3.prod;b507707x8.prod")
          			// RIDs in order: trip_store, track_trips, and request_subscription
          		.put(["name"],child_name)
          		;
    	}
    	{	
      		event:send({"cid":meta:eci()}, "wrangler", "child_creation")  // wrangler os event.
      		with attrs = attributeList.klog("attributes: "); // needs a name attribute for child
    	}
    	always {
      		log("create child for " + child_name);
    	}
	}

	rule delete_vehicle {
		select when car unneeded_vehicle
		pre {
			name = event:attr("name");
		}
		{
			noop();
		}
	}

	rule autoAccept {
    	select when wrangler inbound_pending_subscription_added 
    	pre{
      		attributes = event:attrs().klog("subcription :");
      	}
      	{
      		noop();
      	}
    	always {
      		raise wrangler event 'pending_subscription_approval'
          	attributes attributes;        
          	log("auto accepted subcription.");
    	}
  	}
}