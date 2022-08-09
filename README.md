# The challenge
1. 1 VPC – 10.1.0.0/16
1. 4 subnets (spread evenly across two availability zones)
    1. Sub1 – 10.1.0.0/24 (should be accessible from internet)
    1. Sub2 – 10.1.1.0/24 (should be accessible from internet)
    1. Sub3 – 10.1.2.0/24 (should NOT be accessible from internet)
    1. Sub4 – 10.1.3.0/24 (should NOT be accessible from internet)
1. 1 EC2 instance running Red Hat Linux in subnet 2
    1. 20 GB storage
    1. t2.micro
1. 1 auto scaling group (ASG) that will spread out instances across subnets sub3 and sub4
    1. Use Red Hat Linux
    1. 20 GB storage
    1. Script the installation of Apache web server (httpd) on these instances
    1. 2 minimum, 6 maximum hosts
    1. t2.micro
1. 1 application load balancer (ALB) that listens on TCP port 80 (HTTP) and forwards traffic to the ASG in subnets sub3 and sub4
1. Security groups should be used to allow necessary traffic - these are going to be interesting. They will need to have outputs, that root main.tf will have to import with the module. thing and be passed into the different modules that they'll see as variables. Maybe save this to last
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
        1. IGW that 0.0.0.0/0 in the public subnets point to
        1. NAT Gateway that 0.0.0.0/0 in the private subnets point to
        1. 2 private subnets, 2 public subnets 
    1. Security - if splitting this up, like we did at Deloitte, would need to have the SGs outputted, and in the account module have it define those as variables in order for the other resources to use them
    1. single ec2 - aws-web-server-instance module main.tf - search for this name in the article; this will be part of the inspiration for the single instance. Just going to attach root block device directly. In thecodinginterface link below, there's also examples of creating bespoke ebs volumes and attaching them
    1. ASG - for this, it looks like using userdata or similar in terraform will work. There's an example in the article listed above 
    1. ALB
    1. S3

Since there's some pasting, need to make sure all the tabs are uniform with linting(?) i think?

# Resources used
- Installed: zsh, oh my zsh, visual studio code, brew, terraform, github
- [this](https://spacelift.io/blog/terraform-output) article for heavy inspiration of designing the bones, then building out from there 
- [This](https://www.google.com/search?q=error%3A+src+refspec+main+does+not+match+any+error%3A+failed+to+push+some+refs+to+when+pushing+main+to+new+repo&oq=error%3A+src+refspec+main+does+not+match+any+error%3A+failed+to+push+some+refs+to+when+pushing+main+to+new+repo&aqs=chrome..69i57j69i58.4557j0j1&sourceid=chrome&ie=UTF-8) google search to troubleshoot how to push to github. Turns out I had to commit files first, then I could push. Also had to set git config username and name to be able to push after committing
- Looked up how to make NAT gateway https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
- verified AZ names https://www.google.com/search?q=availability+zones+in+aws+us-east-1&oq=availability+zones+in+aws+us-east-1&aqs=chrome..69i57.7210j0j1&sourceid=chrome&ie=UTF-8 
- found out how to pull RHEL AMIs from [this](https://gmusumeci.medium.com/how-to-deploy-a-red-hat-enterprise-linux-rhel-ec2-instance-in-aws-using-terraform-6570ad6ee19f) article 
- Started at https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs-ephemeral-and-root-block-devices to figure out custom ebs sizing
- https://thecodinginterface.com/blog/terraform-linux-ec2-ebs/ to get practical examples of increasing block storage on instance
- used this article for in-depth understanding of building the ASG https://adamtheautomator.com/terraform-autoscaling-group/ 
- how to create a key pair for access instances https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair 
- specific steps on creating rsa key https://docs.tritondatacenter.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x 