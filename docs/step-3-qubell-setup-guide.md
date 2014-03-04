#### Previous Step: [Set up and Configure an Amazon Web Services (AWS) Account](step-2-amazon-setup-guide.md)

#Step 3. Obtain a Qubell Account

## Introduction to Qubell Platform Concepts

Before proceeding, let's review application deployment in Qubell. Qubell is designed to simplify the deployment of complex distributed applications for development, testing and production. 

Applications are deployed into an environment (e.g. dev, QA or production), where various environments may operate on different clouds, reside in different datacenters, and use different services. Once the environment has been set up, Qubell ensures that applications can be launched into any compatible environment. Compatibility between an application and an environment means that if the application requires a certain service, the environment must have a service available for the application. Qubell validates the compatibility of the application and environment at launch. Services come in three types:
  
- **Cloud Accounts** - Special service types reserved for public cloud accounts (e.g. Amazon EC2 or Rackspace). If your application expects a cloud, it will not be deployed into an environment that doesn't have one.
- **Markers** - Another special service type that indicates whether a service is present in the environment. For example, "Mainframe connection" might be a marker that signals the availability of the mainframe end-point in a particular environment. 
- **Services** - Anything from a pool of VMs to a database with customer records. We will be using a service called "**Secure Vault**". **Secure Vault** is an encrypted store that holds your private information, including Amazon credentials and SSH keys. Applications can safely store, retrieve and use secret data. 

A platform is a central repository of definitions of services available across all environments. The lifecycle of a service starts by being added to the platform, then enabled in environments as needed. Besides different services, environments may have properties and policies. Both properties and policies look like key-value pairs defined for each environment, but they are used for the following different purposes:
  
- **Properties** - Used by Qubell to store the parameters necessary to complete application deployment, configuration and management. For example, "db_connection_string = jdbc://somewhere" is a parameter needed by the application to resolve the location of the database driver in this particular environment. We will use properties to pass the location of files stored on S3 between the web store and the analytic engine.
- **Policies** - These overwrite the values of parameters defined by the application. Different environments may impose different rules on the application. For example, while "test" environment may be configured to offer a choice of Ubuntu or CentOS for an operating system, the "production" environment may allow only RHEL. We are going to define a few policies related to the cloud account. 

Before an application can be launched, there must be at least one environment set up, and that environment must have all services required by the application. Now, let's continue with configuring our application deployment environment.  

## 1. Sign up for Qubell
To sign up for Qubell, go to [qubell.com](http://qubell.com/), select the "**Sign Up**" link and create an account.

## 2. Add Your AWS Account Information to the Qubell Platform
Once you create your Qubell account, you will need to add your AWS account information to the platform. You can obtain your Amazon secret and access keys by following Amazon's [Getting Your Access Key ID and Secret Access Key](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html) instructions. Then, go to Qubell and navigate to **Platform > Cloud Accounts.** Select the "**Add a cloud account**" button. 

![Add cloud](images/qubell-add-cloud-account.png)

Specify your account name, provider="Amazon EC2," AWS credentials, and security group, and select the "**Save**" button.

![Cloud info](images/qubell-cloud-info.png)

## 3. Add Secure Vault Service to the Platform
To create a service vault within the Qubell platform, navigate to **Platform > Services > Add a Service.** 

![Add secure vault service](images/qubell-services.png)

Name the service (e.g. "Service vault"), select "Secure Vault 2.0" for "**Type,**" and select "**Add**."

![Secure vault service info](images/qubell-services-2.png)

## 4. Create your Qubell Testing Environment
To add your Qubell testing environment, navigate to **Environments > Add an environment**. 

![Add environment](images/qubell-environment.png)

Name the environment (e.g. "Default environment"), indicate a value for "**Execute On**" from the drop-down list, and select "**Add**." 

## 5. Generate and Store SSH Keys
SSH uses public-key cryptography to authenticate the remote computer and allow it to authenticate the user (without the need for a password). SSH keys always come in pairs (private and public). The public key can be distributed with any SSH server, while the private key is to be safely guarded by the owner. The key pair authenticates the user by verifying that the public and private keys match. 

To upload an existing SSH key pair or to regenerate a new key pair, navigate to **Platform > Services**. If you have an existing pair, you can upload it by locating the service in the list and clicking **Edit > Upload.** If you do not have an existing SSH key pair or wish to create a new one, you can regenerate it. To do so, locate the service in the list and click **Edit > Regenerate.**. Your new SSH keys should appear.

![SSH keys](images/qubell-ssh-keys.png)

##6. Add Environment Properties

To add environment properties, navigate to **Environments** and select the **edit** button that corresponds to the environment you just added. Then, click the "**Add a property**" button.

![Add property](images/qubell-add-property.png)

In the pop-up window, you will need to add the *property name*, *property type* (for all properties in ATG Starter Kit, the type is "string") and the *property value.* Add all properties shown below (be sure to click the **Add** button for each).

- Password properties:
**Values should be 8 symbols long and contain at least 1 digit and 1 capital letter**
  + atg_admin - Password for ATG BCC admin
  + atg_db_production - Password for production db user
  + atg_db_publishing - Password for publishing db user
  + weblogic - Password for Weblogic domain
  + oracle_db - Password for Oracle DB 'system' user
- URLs to binaries properties:
**To obtain binaries, please refer to the [Getting Artifacts Guide](docs/get-artefacts.md)**
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
- Git repository URL property (optional)
  + git_repo (note that if your repository isn't public, you must the auth username and password directly in your URL, e.g. https://username:password@path/to/git/repo.git)

#### Next step: [Application launch](step-4-launch-guide.md)
