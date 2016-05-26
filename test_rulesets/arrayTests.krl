ruleset arrayTests {
	meta {
		name "arrayTests"
		description <<
		Testing arrays
		>>
		author "Nicholas Angell"
		provides testIndex
		sharing on
	}

	global {
		testIndex = function(i) {
			c = [1, 2, 3, 4, 5];
			x = c.index(i);
			x;
		}
		removePCIbootstraps = defaction(appECI){//,bootstrapRids){
			boot = list_bootstrap().map(function(rid) { 
				pci:remove_bootstrap(appECI, rid); 
				}).klog(">>>>>> bootstrap removed result >>>>>>>");
			send_directive("pci bootstraps removed.")
			with rulesets = list_bootstrap(appECI); 
		}
		removePCIcallback = defaction(appECI){//,PCIcallbacks){
			//PCIcallbacks =( PCIcallbacks || []).append(PCIcallbacks);
			boot = list_callback().map(function(url) { 
				pci:remove_callback(appECI, url); 
				}).klog(">>>>>> callback remove result >>>>>>>");
			send_directive("pci callback removed.")
			with rulesets = list_callback(appECI);
		}
		update_app = defaction(app_eci,app_data,bootstrap_rids){
			//remove all 
			remove_cb = removePCIcallback(app_eci);
			remove_appinfo = pci:remove_appinfo(app_eci);
			remove_bs = removePCIbootstraps(app_eci);
			// add new 
			add_callback = pci:add_callback(app_eci, app_data{"app_callback_url"}); 
			add_info = pci:add_appinfo(app_eci,{
				"icon": app_data{"app_image_url"},
				"name": app_data{"app_name"},
				"description": app_data{"app_description"},
				"info_url": app_data{"info_page"},
				"declined_url": app_data{"app_declined_url"},
				"developer_secret": app_data{"appSecret"}
				});
			addPCIbootstraps(app_eci,bootstrap_rids);
		};
	}

	rule splitTest {
		select when test splitTest
		pre {
			testString = "a,b,c;d,e;f;g,h;i,j";
			testSplit = testString.split(re/[,;]+/).klog("Split String");
			testSplit7 = testSplit[7];
		}
		{
			send_directive("Split")
			with text = "#{testSplit7}";
		}
	}

	rule updateClient {
		select when test updateClient
		pre {
			app_data_attrs={
				"info_page": "q",
				"bootstrap_rids": "w",
				"app_name": "e",
				"app_description": "r",
				"app_image_url": "t",
				"app_callback_url": "y".split(re/;/),
				"app_declined_url": "u"
			};
			identifier = "24A64F0A-1ED5-11E6-9716-94D6E71C24E1"
			old_apps = pci:list_apps(meta:eci());
			old_app = old_apps{identifier}.defaultsTo("error", standardOut("oldApp not found")).klog(">>>>>> old_app >>>>>>>");
			app_data = (app_data_attrs)// keep app secrets for update// need to see what the real varibles are named........
			.put(["appSecret"], old_app{["app_info", "developer_secret"]}.defaultsTo("error", standardOut("no secret found")))
			.put(["appECI"], old_app{"appECI"}) // appECI does not exist in old_app
			;
			bootstrap_rids = app_data{"bootstrap_rids"}.split(re/;/).klog(">>>>>> bootstrap in >>>>>>>");
		}
		{
			update_app(identifier,app_data,bootstrap_rids);
		}
	}

}