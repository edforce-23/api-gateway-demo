### Service Account to run greetings cloud function ###
resource "google_service_account" "greetings-function" {
	account_id		= "greetings-function-dev"
	display_name	= "greetings-function-dev"
	project			= var.project
}

### Service Account to run greetings function through the API Gateway ###
resource "google_service_account" "greetings-gateway" {
	account_id 		= "greetings-gw-dev"
	display_name	= "greetings-gw-dev"
	project			= var.project
}