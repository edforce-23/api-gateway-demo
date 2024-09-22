### VPC containing the cloud function ###
module "vpc" {
	source 			= "terraform-google-modules/network/google"
	version			= "9.2.0"

	#shared_vpc_host	= "true"
	project_id		= var.project

	network_name	= "vpc-dev"
	routing_mode	= "GLOBAL"

	subnets = [
		// private subnets
		{
			subnet_name				= "subnet-01"
			subnet_ip				= "10.5.0.0/28"
			subnet_region			= var.region
			subnet_private_access	= "true"
			subnet_flow_logs		= "true"
		}
	]
	routes = [
		{
			name 				= "egress-internet-dev"
			description			= "Route through IGW to access internet"
			destination_range	= "0.0.0.0/0"
			tags 				= "egress-inet"
			next_hop_internet	= "true"
		}
	]
}

resource "google_compute_router" "router" {
	name 	= "${var.region}-dev"
	project = var.project
	region 	= var.region
	network = module.vpc.network_id
}

module "network-ip" {
	source 			= "terraform-google-modules/address/google"
	version			= "4.0.0"

	project_id		= var.project
	region 			= var.region
	address_type	= "EXTERNAL"
	names			= ["${var.region}-dev"]
}

module "nat" {
	source 								= "terraform-google-modules/cloud-nat/google"
	version								= "5.3.0"

	project_id							= var.project
	region 								= var.region
	router 								= google_compute_router.router.name
	log_config_enable					= true
	log_config_filter					= "ALL"
	min_ports_per_vm					= 4096
	name 								= var.region
	nat_ips								= [module.network-ip.self_links[0]]
	source_subnetwork_ip_ranges_to_nat	= "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"
}

module "serverless-connector" {
	source  	= "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
	project_id	= var.project

	vpc_connectors = [{
		name 			= "central-serverless"
		region 			= var.region
		subnet_name		= module.vpc.subnets_names[0]
		host_project_id	= var.project
		machine_type	= "e2-standard-4"
		min_instances 	= 2
		max_instances	= 3
		max_throughput	= 300
	}]
}