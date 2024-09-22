### Bucket containing the source code ###
resource "google_storage_bucket" "functions-demo-src" {
	name 						= "functions-demo-src-dev"
	location					= "US"
	uniform_bucket_level_access	= true
}

### Greetings objetct to store the source code ###
resource "google_storage_bucket_object" "greetings" {
	name 	= "greetings-src/"
	bucket 	= google_storage_bucket.functions-demo-src.id
	source 	= "${path.module}/functions/greetings-function.zip"
}