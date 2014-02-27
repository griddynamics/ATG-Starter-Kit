Step 4. Launch Application
=============================

### Launching 

Go to "Application" tab navigation bar. List of applications contains application "ATG Starter Kit"

![Starler Kit Application](images/launch-app-screen.png)

To launch Starter Kit application press triangle button next to "Launch" - it's an options menu. Here you can select environment for application (avaliable only "default") or choose advanced lauch setup.

![Launch Starter Kit 1](images/launch-sk-1.png)

Press "Advanced Launch" button.
![Launch Starter Kit 2](images/launch-sk-2.png)

Now was opened lauch setup dialog. Here you can change default parameters for launching instance such as image ami, instance size, cookbooks location on S3. Select destory time for Starter kit. 

**!!! Destroy time should be at least 2 hours**

Press "Launch" button and wait until inctance gets a "Running state."
Full deployment process takes about an hour, so be patiant.

![Starter Kit Advanced Launch](images/launch-advanced-launch.png)

On status bar (1) displayes current status of inctance. To get more info click on "Jobs" menu (2).

![Launching instance](images/launch-instance-screen-1.png)

In menu "Jobs" displaying current running workflows with their start timestamp, current duration, name, user and status.

![Launching status](images/launch-instance-screen-2.png)

When launch workflow become "Finished" with all successeful sub-workflows, instance will get to the "Running State". It means that application ready to use now.

![Instance running](images/launch-instance-running.png)

Press "Open ATG Production Store" button to open demo store. CRS with Endeca search box will be opened. Test it by trying to search any kind of items, for example, jeans.

![CRS search](images/launch-browse-crs-search.png)

Results will appear shortly. For customization search results use left selection panel.

![Search results](images/launch-crs-search-results.png)

### Commerce Reference Store Redeployment

**!!! Set git_repo env propetry before using**

To redeploy CRS from customs sources from git repository press "Update_Reference_Store" triangle button and select "Advanced". Use master as default branch or specify another branch or revision and press "Execute", redeployment process takes about 15 minutes.
