#### Previous Step: [Set up and Configure an Amazon Web Services (AWS) Account](step-1-amazon-setup-guide.md)

#Step 2. Set up a Qubell Account

## Introduction to Qubell Platform Concepts

Before proceeding, let's review application deployment in Qubell. **_Qubell is designed to simplify the deployment of complex distributed applications for development, testing and production._** Applications are deployed into an environment (e.g. dev, QA or production), where various environments may operate on different clouds, reside in different datacenters, and use different services. Once the environment has been set up, Qubell ensures that applications can be launched into any compatible environment. Compatibility between an application and an environment means that if the application requires a certain service, the environment must have a service available for the application. Qubell validates the compatibility of the application and environment at launch. Services come in three types:
  
- **Cloud Accounts** - Special service types reserved for public cloud accounts (e.g. Amazon EC2 or Rackspace). If your application expects a cloud, it will not be deployed into an environment that doesn't have one.
- **Markers** - Another special service type that indicates whether a service is present in the environment. For example, "Mainframe connection" might be a marker that signals the availability of the mainframe end-point in a particular environment. 
- **Services** - Anything from a pool of VMs to a database with customer records. We will be using a service called "**Secure Vault**". **Secure Vault** is an encrypted store that holds your private information, including Amazon credentials and SSH keys. Applications can safely store, retrieve and use secret data. 

A platform is a central repository of definitions of services available across all environments. The lifecycle of a service starts by being added to the platform, then enabled in environments as needed. Besides different services, environments may have properties and policies. Both properties and policies look like key-value pairs defined for each environment, but they are used for the following different purposes:
  
- **Properties** - Used by Qubell to store the parameters necessary to complete application deployment, configuration and management. For example, `db_connection_string = jdbc://somewhere` is a parameter needed by the application to resolve the location of the database driver in this particular environment. We will use properties to pass the location of files stored on S3 between the web store and the analytic engine.
- **Policies** - These overwrite the values of parameters defined by the application. Different environments may impose different rules on the application. For example, while "test" environment may be configured to offer a choice of Ubuntu or CentOS for an operating system, the "production" environment may allow only RHEL. We are going to define a few policies related to the cloud account. 

Before an application can be launched, there must be at least one environment set up, and that environment must have all services required by the application. Now, let's continue with configuring our application deployment environment.  

## 1. Sign up for Qubell
To sign up for Qubell, navigate to [qubell.com](http://qubell.com/). Select the "**Sign Up**" link and create an account.

![Sign up](images/sign-up.png)

Note that the following services come pre-installed with Qubell:

* **Secure Vault 2.0** - The default credentials service
* **Workflow Service** - The default workflow service

These services are accessible from **Applications > System**.

![Default Services](images/default-services.png)

## 2. Add Your AWS Account Information to the Qubell Platform
Once you create your Qubell account, you need to add your AWS account information to the platform. You can obtain your Amazon secret and access keys by following Amazon's [Getting Your Access Key ID and Secret Access Key](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html) instructions. Then, go to Qubell and click the menu icon in the upper left corner of the screen. Select **Cloud Accounts**. 

![Add cloud](images/qubell-add-cloud-account-1.png)

Select the "**Add a cloud account**" button. 

![Add cloud](images/qubell-add-cloud-account-2.png)

Specify your account name, provider (select **Amazon EC2**), AWS credentials, and security group, and select the "**Save**" button.

![Cloud info](images/qubell-cloud-info.png)

## 3. Generate and Store SSH Keys
SSH uses public-key cryptography to authenticate the remote computer and allow it to authenticate the user (without the need for a password). SSH keys always come in pairs (private and public). The public key can be distributed with any SSH server, while the private key is to be safely guarded by the owner. The key pair authenticates the user by verifying that the public and private keys match. 

**Secure Vault 2.0**, Qubell's default credentials service, is pre-configured with an SSH key pair. To access the key pair, navigate to **Applications > System**.

![Default Services](images/default-services.png)

Select the **Secure Vault 2.0** link, and then click the **Default credentials service** link.

![Default credentials service](images/default-cred-service.png)

Lastly, select **SSH keys** from the sub-menu.

![SSH keys](images/ssh-keys.png)

Here, you can download the pre-configured public and private keys. To upload a different SSH key pair, click the **Upload** button. You can also create a new key pair by clicking the **Regenerate** button.

##4. Set up Environment with Cloud Account and Properties

Qubell comes pre-installed with a **default** environment. To view this environment, click the menu icon in the upper left corner of the screen and select **Environments**.

![Environment menu](images/menu-environments.png)

Click the **default** link or the **edit** button to view the details associated with this environment.

![Environment details](images/environment-details.png)

To associate a cloud account with this environment, select the **Set a Cloud Account** button. Choose your cloud account from the list (recall we added it in Step 2) and select **Save**.

![Set cloud account](images/set-cloud-account.png)

To add environment properties, click the "**Add a property**" button. In the pop-up window, you will need to add the *property name*, *property type* (for all properties in ATG Starter Kit, the type is "string") and the *property value.* Add all properties shown below (be sure to click the **Add** button for each).

![Add property](images/environment-property.png)

- **Password properties** *(Values should be 8 symbols long and contain at least 1 digit and 1 capital letter)*
  + `atg_admin` - Password for ATG BCC admin
  + `atg_db_production` - Password for production db user
  + `atg_db_publishing` - Password for publishing db user
  + `weblogic` - Password for Weblogic domain
  + `oracle_db` - Password for Oracle DB 'system' user
- **Binary URLs properties** *(To obtain binaries, please refer to the [Getting Artifacts Guide](get-artifacts.md))*
  + `atg_binary_url` - ATG Platform (.bin)
  + `atg_store_url` - ATG Commerce Reference Store (.bin)
  + `cas_url` - Endeca Content Acquisition System Documentation (.sh)
  + `jrockit_binary_url` - JRockit (.bin)
  + `mdex_url` - Endeca MDEX (.sh)
  + `oracle_db_xe_zip` - Oracle Database XE 11g (.zip)
  + `platform_services_binary_url` - Endeca Platform Services (.sh)
  + `presentation_api_url` - Endeca Presentation API (.tgz)
  + `taf_url` - Endeca Tools and Frameworks (.sh)
  + `weblogic_binary_url` - Weblogic 10.3.6 (.jar)
- **Git repository URL property** `(optional)`
  + `git_repo` (note that if your repository isn't public, you must the auth username and password directly in your URL, e.g. https://username:password@path/to/git/repo.git)

#### Next step: [Get the ATG Starter Kit](step-3-get-starter-kit.md)
