### Service Account to run greetings cloud function ###
resource "google_service_account" "greetings-function" {
	account_id		= "greetings-function-dev"
	display_name	= "greetings-function-dev"
	project			= var.project
}

#resource "google_service_account_iam_member" "function-sa-user-binding" {
#	service_account_id	= google_service_account.greetings-function.id
#	role				= "roles/iam.serviceAccountUser"
#	member 				= "serviceAccount:${google_service_account.greetings-function.email}"
#}

#resource "google_cloudfunctions_function_iam_member" "greetings-cloudfunction" {
#	project			= var.project
#	region 			= var.region
#	cloud_function 	= google_cloudfunctions_function.greetings-demo.id
#	role			= "roles/cloudfunctions.invoker"
#	member 			= "serviceAccount:${google_service_account.greetings-function.email}"
#}

### Service Account to run greetings function through the API Gateway ###
resource "google_service_account" "greetings-gateway" {
	account_id 		= "greetings-gw-dev"
	display_name	= "greetings-gw-dev"
	project			= var.project
}

#resource "google_service_account_iam_member" "gateway-sa-user-binding" {
#	service_account_id	= google_service_account.greetings-gateway.id
#	role 				= "roles/iam.serviceAccountUser"
#	member 				= "serviceAccount:${google_service_account.greetings-gateway.email}"
#}

#resource "google_cloudfunctions_function_iam_member" "gateway-greetings-cloudfunction" {
#	project				= var.project
#	region 				= var.region
#	cloud_function 		= google_cloudfunctions_function.greetings-demo.id
#	role 				= "roles/cloudfunctions.invoker"
#	member 				= "serviceAccount:${google_service_account.greetings-gateway.email}"
#}