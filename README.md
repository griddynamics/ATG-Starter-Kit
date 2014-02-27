ATG Starter Kit
===============

Getting Started
---------------

### What is ATG Starter Kit?

ATG Starter Kit is a cloud environment for developers, who can develop and test their e-commerce applications on Amazon AWS with Qubell Adaptive PaaS. This starter kit presents a complete example of an ATG Commerce Reference Store with Endeca search engine runing on Weblogic and Oracle Database. 

This Starter Kits has everything one needs to: 

- Fast start with ATG platform
- Develop ATG e-commerce applications
- Deploy ATG applications from GIT repository
- Learn how to deploy and configure ATG Platform or Endeca Search Engine
- Understand how ATG Platform and Endeca Search work together

###Technologies

![oracledb_logo](docs/images/logos/oracledb.gif)
![weblogic_logo](docs/images/logos/weblogic_logo.gif)
![atg_endeca_logo](docs/images/logos/oracle_atg_endeca.png)

### Starter Kit Architecture

![Add service](docs/images/readme-atg-architectute.png)

### Requirements
Starter Kit requires m1.xlarge AWS instance or bigger and tested on specified images.

| Region  		| Image-AMI 			  		|
|:------------:	|:----------------------------:	|
|us-east-1		| us-east-1/ami-52009e3b		|
|eu-west-1		| eu-west-1/ami-8aa3a8fe		|
|us-west-1		| us-west-1/ami-0a2f024f		|
|us-west-2		| us-west-2/ami-e030a5d0		|
|ap-southeast-1	| ap-southeast-1/ami-0c034f5e	|
|ap-southeast-2	| ap-southeast-2/ami-f261f0c8	|
|ap-northeast-1	| ap-northeast-1/ami-651a9b64	|
|sa-east-1		| sa-east-1/ami-b32cf7ae		|

                
To use another image you have to specify it id in launch parameters and have 20+ gb partition mounted on /media/ephimeral0 or edit manifest to install components to .

We will provide you with all the code needed to deploy and modify reference store of the starter kit. All Oracle third-part software used in the kit is available on Oracle website. We will provide references to the external documentation for each tool used. You will need to bring things with you:

- Qubell account setup account
- Amazon AWS setup account
- Installation binaries
	+ ATG Platform 10.2
	+ ATG Commerce Reference Store 10.2
	+ JRockit 6r28
	+ Weblogic 10.3.6
	+ Oracle Database XE 11g
	+ Tools and Frameworks 3.1.2
	+ Platform Services 6.1.4
	+ CAS 3.1.2.1
	+ MDEX 6.4.1.2
- Access to git repository with CRS sources (optional)

Read how to get binaries in [getting artefacts guide](docs/get-artefacts.md).

### No experience with ATG or Endeca deployment is required

This Starter Kit is designed to help develop and test e-commerce stores on ATG Platform, based on default CRS application. The only core requirement is strong working knowledge of Java.

### Who wrote this Starter Kit and why?

This ATG Starter Kit was developed by Grid Dynamics, in partnership with Qubell, to improve developer process for ATG developers and QA engineers for fast creation of the solutions on ATG platform with Endeca search engine.

### How does this Kit work?

ATG Starter Kit has three main parts:

* **ATG Platform** - set of tools and libraries for develop, deploy and configure e-commerce applications.
* **ATG Commerce Reference Store** - default reference store example, written using ATG Platform
* **Endeca Search Engine** - search engine, providing indexing and executing search queries from ATG CRS.

Step-by-step Setup Guide
------------------------
- **[Step 1. Get Startet Kit](docs/step-1-get-starter-kit.md)**
- **[Step 2. Setup Amazon Account](docs/step-2-amazon-setup-guide.md)**
- **[Step 3. Setup Qubell Account](docs/step-3-qubell-setup-guide.md)**
- **[Step 4. Application launch](docs/step-4-launch-guide.md)**


Known Issues
------------
- **Long delay on request to the ATG Reference Store (CRS)**

	It’s a normal behaviour. Weblogic have to fully initialise CRS servlet, so it can takes a few minutes.
- **Search box doesn’t shows on CRS home page**
	
	First, check working of Endeca service on Endeca Workbench.
Second, try to refresh page. Sometimes search box doesn’t appear instantly.
