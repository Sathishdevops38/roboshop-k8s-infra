variable "project_name"{
    default = "roboshop"
}
variable "environment"{
    default = "dev"
}

variable "k8s_tags"{
    default ={
        createdby = "terraform"
        usage =  "k8s"
    }
}

variable "instance_type"{
    default = "t3.micro"
}

