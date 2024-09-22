### Providers definition ###
terraform {
	required_providers {
		google = {
			source		= "hashicorp/google"
			version		= "5.20.0"
		}
		google-beta = {
			source 		= "hashicorp/google-beta"
			version 	= "5.20.0"
		}
	}
}

provider "google" {
	project		= var.project
	region		= var.region
	credentials	= "keys.json"
}

provider "google-beta" {
	project 	= var.project
	region		= var.region
	credentials	= "keys.json"
}

# Enables Firebase services
resource "google_firebase_project" "default" {
	provider = google-beta
	project  = var.project
}