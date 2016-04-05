ruleset manage_fleet {

	meta {
    	name "manage_fleet"
    	description <<
      		Fleet Management Assignment
      		>>
    	author "Nicholas Angell"
    	use module b507199x5 alias wrangler_api
  	}

	global {
		vehicles = function() {
			results = wranglerOS:children();
      		vehicles = results{"children"};
      		vehicles;
		}
	}
	
	rule create_vehicle {
		select when car new_vehicle
		pre {
			child_name = event:attr("name");
     		attributeList = {}
          		.put(["Prototype_rids"],"b507707x4.prod;b507707x3.prod") // rulesets needed at install, semicolon separated
          		.put(["name"],child_name) // name for child
          		;
    	}
    	{	
      		event:send({"cid":meta:eci()}, "wrangler", "child_creation")  // wrangler os event.
      		with attrs = attributes.klog("attributes: "); // needs a name attribute for child
    	}
    	always {
    		raise explicit event 'subscribeToParent'
    			attributes attributeList;
      		log("create child for " + child);
    	}
	}

	rule childToParent {
    	select when explicit subscribeToParent
    	pre {
       		parent_results = wrangler_api:parent();
       		parent = parent_results{'parent'};
       		parent_eci = parent[0]; // eci is the first element in tuple 
       		attrs = {}.put(["name"],event:attr("name"))
                      .put(["name_space"],"Fleet_Management")
                      .put(["my_role"],"vehicle")
                      .put(["your_role"],"fleet")
                      .put(["target_eci"],parent_eci.klog("Target Eci: "))
                      .put(["channel_type"],"Lab2_Pico_Systems")
                      .put(["attrs"],"success")
                      ;
    	}
    	{
     		noop();
    	}
    	always {
      		raise wrangler event "subscription"
      			attributes attrs;
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


}