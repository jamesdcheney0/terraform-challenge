# The challenge
1. 1 VPC – 10.1.0.0/16
1. 4 subnets (spread evenly across two availability zones)
    1. Sub1 – 10.1.0.0/24 (should be accessible from internet)
    1. Sub2 – 10.1.1.0/24 (should be accessible from internet)
    1. Sub3 – 10.1.2.0/24 (should NOT be accessible from internet)
    1. Sub4 – 10.1.3.0/24 (should NOT be accessible from internet)
1. 1 EC2 instance running Red Hat Linux in subnet sub2
    1. 20 GB storage
    1. t2.micro
1. 1 auto scaling group (ASG) that will spread out instances across subnets sub3 and sub4
    1. Use Red Hat Linux
    1. 20 GB storage
    1. Script the installation of Apache web server (httpd) on these instances
    1. 2 minimum, 6 maximum hosts
    1. t2.micro
1. 1 application load balancer (ALB) that listens on TCP port 80 (HTTP) and forwards traffic to the ASG in subnets sub3 and sub4
1. Security groups should be used to allow necessary traffic
1. 1 S3 bucket with two folders and the following lifecycle policies
    1. “Images” folder - move objects older than 90 days to glacier
    1. “Logs” folder - delete objects older than 90 days

## Thought process of designing this
Started with [this](https://spacelift.io/blog/terraform-output) article that linked to [this](https://github.com/spacelift-io-blog-posts/Blog-Technical-Content/tree/master/terraform-output/modules) Github. 
Trying to understand how variables work. Outputs can be read by parent modules. Variables can be read by child modules. It does not seem like outputs can be read by 'sibling' modules 
Module = each of the .tf files 

File Structure
1. Account module that calls the ones below it (include main.tf, vars, outputs, terraform.tfvars)
    1. VPC - for now, write out all 4 subnets. stretch goal is to use the for-each that the bottom of the article mentions 
    1. Security - if splitting this up, like we did at Deloitte, would need to have the SGs outputted, and in the account module have it define those as variables in order for the other resources to use them
    1. single ec2 - aws-web-server-instance module main.tf - search for this name in the article; this will be part of the inspiration for the single instance
    1. ASG - for this, it looks like using userdata or similar in terraform will work. There's an example in the article listed above 
    1. ALB
    1. S3

  git config --global user.email "jamesdcheney0@gmail.com"
  git config --global user.name "James Cheney"