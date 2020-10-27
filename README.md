Send Email from Azure Automation from a Visual Studio Online Service Hook
=========================================================================

            

Of all the current and soon to be released features in VSO, I'm most excited about the extensibility options.  One that was announced in 2014 was
[Service Hooks](https://www.visualstudio.com/en-us/get-started/integrate/integrating-with-service-hooks-vs).  Service Hooks let you perform tasks on other services when something happens in a VSO project (new build created, work item updated, etc.).  One of the available services is a
[Webhook](https://www.visualstudio.com/get-started/integrate/service-hooks/webhooks-and-vso-vs).  A Webhook can post JSON data about the event from VSO to any URL of your choice.  So that got me thinking… 


With the recent announcement of [Azure Automation Webhooks](http://azure.microsoft.com/en-in/documentation/articles/automation-webhooks/), that means you could trigger a custom Runbook hosted in Azure to perform any action you want when an event happens in VSO.  Is that not awesome!  Think of the possibilities this could open for your DevOps adventures.


The attached script is meant to be imported as a Runbook in Azure Automation.  I have an entire blog on how to set this all up, found here.  


[http://azure.microsoft.com/blog/2015/07/06/start-automation-runbooks-in-response-to-events-in-visual-studio-online/](http://www.concurrency.com/infrastructure/using-visual-studio-online-service-hooks-with-azure-automation-webhooks/)


 


Here's a peek at the script: 

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
