### Create Api Gateway to protect function ###
resource "google_api_gateway_api" "greetings-api" {
	provider	= google-beta
	api_id 		= "greetings-api-dev"
	project		= var.project
}

resource "google_api_gateway_api_config" "greetings-gw-config" {
	provider		= google-beta
	project			= var.project
	api 			= google_api_gateway_api.greetings-api.api_id
	api_config_id	= "greetings-gw-config-dev"

	openapi_documents {
		document {
			path		= "api/greetings-spec.yaml"
			contents	= filebase64("api/greetings-api-spec.yaml")
		}
	}

	lifecycle {
		create_before_destroy	= true
	}
}

resource "google_api_gateway_gateway" "greetings-gateway" {
	provider	= google-beta
	project		= var.project
	gateway_id	= "greetings-gateway-dev"
	api_config	= google_api_gateway_api_config.greetings-gw-config.id
}