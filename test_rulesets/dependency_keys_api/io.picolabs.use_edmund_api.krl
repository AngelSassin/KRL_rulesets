ruleset io.picolabs.use_edmund_api {
  meta {
    use module io.picolabs.edmund_keys
    use module io.picolabs.edmund_api alias edmund
        with account_sid = keys:edmund("account_sid")
    shares __testing
  }

  global {
          __testing = { "queries": [],
                  "events": [ { "domain": "test", "type": "new_message",
                                "attrs": [ "vin" ] } ] }
        }

  rule test_decode_vin {
    select when test new_message
    send_directive("car")
      with vehicle = edmund:decode_vin(event:attr("vin"))
  }
}
