Step 3. Setup Qubell Account
============================

Introduction to Qubell Platform Concepts
----------------------------------------
Before we go any further, let’s understand how application deployment happens in Qubell. Qubell is designed to make it easy for developers to deploy complex distributed applications, for different purposes, such as development, testing and production. 
  Application is always deployed into some environment, such as dev, qa or production. Different environments may operate on different clouds, reside in different datacenters and use different services. Once the environment has been set-up, Qubell will take care that applications can be launched into any compatible environment. Compatibility between an application and an environment means that if that application requires a certain service, the environment must have a service available for the application. Qubell validates the compatibility of application and environment at launch. Services come in three types:
  
- **Cloud accounts** - These are a special type of service reserved for public cloud accounts, such as Amazon EC2 or Rackspace. If your application expects a cloud, it will not be deployed into an environment that doesn’t have one.
- **Markers** - These are a another special type of service that simply indicates whether some service is present in the environment. For example, “Mainframe connection” might be a marker that signals the availability of the mainframe end-point in a particular environment. 
- **Services** - These can be anything, from a pool of VMs to a database with customer records. We are going to use one service called Secure Vault. Secure Vault is an encrypted store that holds your private information such as Amazon credentials and SSH keys. This way applications can safely store, retrieve and use secret data. 

A platform is a central repository of definitions of services available across all environments. The lifecycle of a service starts by being added to the platform, then enabled in some environments as appropriate. 
  Besides different services, environments may have properties and policies. Both properties and policies look like key-value pairs defined for each environment, but they are used for different purposes:
  
- **Properties** - These are used by Qubell to store parameters necessary to complete application deployment, configuration and management. For example, “db_connection_string = jdbc://somewhere” is a parameter needed by the application to resolve the location of the database driver in this particular environment. We will use properties to pass the location of files stored on S3 between the web store and the analytic engine.
- **Policies** - These overwrite the values of parameters defined by the application. Different environments may impose different rules on the application. For example, while “test” environment may be configured to offer a choice of Ubuntu or CentOS for an operating system, the “production” environment may allow only RHEL. We are going to define a few policies related to the cloud account. 

It must be clear now that before any application can be launched, there has to be at least one environment set-up, and that environment ought to have all services required by the application.
Armed with theory, we are ready to configure our application deployment environment.  

Add Your Amazon Account to the Platform
---------------------------------------
After you have obtained your Amazon account along with its Amazon secret and access keys, you need to add your account to the platform. To do so, go to the subsection named "Cloud Accounts" under the tab "Platform." Press "Add a cloud account" button. 

![Add cloud](images/qubell-add-cloud-account.png)

Specify your account name, provider="Amazon EC2", AWS credentials and security group and press "Save."

![Cloud info](images/qubell-cloud-info.png)

Add Secure Vault Service to the Platform
----------------------------------------
To create a service vault, go to the the subsection named "Services" under the tab "Platform". "Press the "Add a service" button. 

![Add secure vault service](images/qubell-services.png)
Specify service name as "Service vault" (or a name of your own preference), choose "Secure Vault 2.0" for Type, and press "Add."
![Secure vault service info](images/qubell-services-2.png)


Create environment
-------------------------
Now you are ready to add your testing environment. To do so, go to the "Environments" tab and click on the "Add an environment" button. 

![Add environment](images/qubell-environment.png)

Specify environment name as "default" (or a name of your own preference), select "Qubell/us-east" and press "Add." A new environment will be open. 

Add Amazon cloud to environment
--------------------------------------
To set connect your Amazon cloud account to your own environment, press "Set a cloud account" from the "Environments" tab. Choose previously created cloud account name. 

![Set cloud](images/qubell-add-cloud-account.png)

Add Secure Vault Service to Environment
----------------------------------------------
From the same "Environments" tab, press "Add a Service" to add your secure vault service to your own environment. Press the "Add a service" button. Select "Secure vault" and press "Add."

![Add service](images/qubell-secure-vault.png)

If an error like the picture below comes up, delete the default Service that is listed and add your own.
![error](images/qubell-environment-error.png)

Generate and Store SSH Keys
---------------------------
SSH (Secure Shell) is a pair of private and public key cryptography that allows secure authentication of users to allow login and manipulating of remote operating systems. One benefit of having a SSH key is that users can be authenticated without the need of sending a password to the network. SSH keys always come in pairs, private and public- the public key can be distributed with any SSH server, while the private key is to be safely guarded by the owner. The key pair authenticates the user by verifying that the public and private keys match with each other. Because one cannot access your account without both key pairs, SSH is a much more safe and secure form of storing your information. 

To upload or regenerate keys, go to the subsection "Services" under the tab "Platform." If you already have an existing SSH key, you can upload keys. To do so, press "Edit," specify service name and press "Upload" button. If you do not have an existing SSH key, or wish to create a new one (for example, if you think the other keys are unsafe), you can regenerate keys. To do so, press "Edit," and then "Regenerate" button. SSH Keys should appear.

![SSH keys](images/qubell-ssh-keys.png)

Add Environment Properties
--------------------------

To add environment properties press "Add a property..." button

![Add property](images/qubell-add-property.png)

Fill (1) by property name, (2) by property type, for all properties in ATG Starter Kit it's "string". 
Fill (3) by property value. Click "Add" button to finish.

You have to add properties:

- Passwords:
**Should be 8 symbols long and contain at least 1 digit and 1 capital letter**
  + atg_admin - Password for ATG BCC admin
  + atg_db_production - Password for production db user
  + atg_db_publishing - Password for publishing db user
  + weblogic - Password for Weblogic domain
  + oracle_db - Password for Oracle DB 'system' user
- URLs to binaries:
  + atg_binary_url - ATG Platform (.bin)
  + atg_store_url - ATG Commerce Reference Store (.bin)
  + cas_url - Endeca Content Acquisition System Documentation (.sh)
  + jrockit_binary_url - JRockit (.bin)
  + mdex_url - Endeca MDEX (.sh)
  + oracle_db_xe_zip - Oracle Database XE 11g (.zip)
  + platform_services_binary_url - Endeca Platform Services (.sh)
  + presentation_api_url - Endeca Presentation API (.tgz)
  + taf_url - Endeca Tools and Frameworks (.sh)
  + weblogic_binary_url - Weblogic 10.3.6 (.jar)
- Git repository URL (optional)
  + git_repo

If repository isn't public you have specify auth username and password directly in url, for example:
https://username:password@path/to/git/repo.git

To get binaries read [getting artefacts guide](get-artefacts.md).

All properties can be edited in future by pressing "Edit button"

#### Next step: [Application launch](step-4-launch-guide.md)
