Step 2. Setup Amazon Account
============================
Since you’ll be deploying the analytics and sample web store on Amazon cloud, you need to have an Amazon account, configure its security group to allow traffic to your applications, and add that Amazon account to your Qubell portal. 

- **Obtain Amazon EC2 account capable of creating EC2 nodes and using S3 service.** If you don’t yet have an account on Amazon, it can be done [here](http://aws.amazon.com/account/). 
- **Set-up security group.** The EC2 security group “default” has to allow the following connections to the application you’ll be deploying using your account. 

To configure your security group:

1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
2. In the navigation pane, click Security Groups.
3. Select the security group named "default." 
4. Click on the tab "Inbound" to add the following rules. There should already be three default rules set up. 
    
![default rules](images/amazon-default-aws-rules.png)

To add new rule choose "Custom TCP Rule" from "Create a new rule", set "Port range" as port, that your want to opem, leave "Source" as default (0.0.0.0/0), and click "Add Rule." You should see a new rule added under your TCP Port.

Ports you have to open:

- For Qubell
    + 22
- For Weblogic
    + 7001
- For Oracle Database XE
    + 8080
    + 1521
- For ATG Platform and CRS
    + 7003
    + 7103
- For Endeca
    + 8006
    + 15000
    + 8888
    + 8500

To finish adding rule press "Apply Rule Changes".

This is how the finished security group should look like.
![atg starter kit rules](images/amazon-atg-sk-aws-rules.png)
============

5.Press "Apply Rule Change" to save changes. 

For more information, you can visit [Amazon portal](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html#adding-security-group-rule). 


#### Next step: [Setup Qubell Account](step-3-qubell-setup-guide.md)
