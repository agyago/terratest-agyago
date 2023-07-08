variable "provider_var" {
    default = "us-east-1"
}

variable "buckety" {
    default = "bucketybuckbuckagyago1234567890"
}

variable "dyna_table" {
    default ="tableybuckbuckagyago1234567890"
}

variable "admin_names" {
    type = list(string)
    default = ["cheezychinito","agyago"]
}

variable "read_names" {
    type = list(string)
    default = ["blusteruth","kabuto"]
}