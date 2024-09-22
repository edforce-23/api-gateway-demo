### Creates greetings function ###
resource "google_cloudfunctions_function" "greetings-demo" {
	name							= "greetings-dev"
	description						= "Greetings function."
	region							= var.region
	runtime							= "python312"

	available_memory_mb				= 128
	source_archive_bucket			= google_storage_bucket.functions-demo-src.name
	source_archive_object			= google_storage_bucket_object.greetings.name
	trigger_http					= true
	entry_point						= "helloWorld"
	service_account_email			= google_service_account.greetings-function.email
	vpc_connector					= "projects/${var.project}/locations/${var.region}/connectors/central-serverless"
	vpc_connector_egress_settings	= "ALL_TRAFFIC"
}