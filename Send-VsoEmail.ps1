<# 
.SYNOPSIS  
	Sends email containing data from Visual Studio Online
 
.DESCRIPTION 
    This runbook receives webhook data from Visual Studio Online (VSO).  This data is sent to the runbook
	via a Service Hook setup in VSO.  The runbook will parse the data sent and send an email out to the 
	addresses specified.  The runbook uses an Automation Credential to authenticate the user sending the email.
	Link to more information:  http://azure.microsoft.com/blog/2015/07/06/start-automation-runbooks-in-response-to-events-in-visual-studio-online/
	Link to Script Center source:  https://gallery.technet.microsoft.com/Send-Email-from-Azure-e7b49e16
 
.PARAMETER WebhookData 
    Object containing the data from VSO in JSON
	
.EXAMPLE 
    Send-VsoEmail -WebhookData {}
 
.NOTES 
    AUTHOR:  Christopher Mank
    LASTEDIT: June 18, 2015
#>
workflow Send-VsoEmail
{	
	# Inputs
    param (
        [Object] $WebhookData
    )
	
	# Manually configured variables
	$StrCredentialName = "MyAzureCredentialName"
	$StrMessageTo = @("recipient1@domain.com", "recipient2@domain.com")
	$StrSmtpServer = 'smtp.office365.com'
	
    # Convert request JSON to PS object
	$StrRequestBody = $WebhookData.RequestBody
	$ObjRequestBody = $StrRequestBody | ConvertFrom-Json
	
	# Build Work Item variables
	$StrTitle = $ObjRequestBody.resource.fields.'System.Title'
	$StrCreatedBy = $ObjRequestBody.resource.fields.'System.CreatedBy'
	$StrAreaPath = $ObjRequestBody.resource.fields.'System.AreaPath'
	$StrTeamProject = $ObjRequestBody.resource.fields.'System.TeamProject'
	$StrWorkItemType = $ObjRequestBody.resource.fields.'System.WorkItemType'
	$StrSeverity = $ObjRequestBody.resource.fields.'Microsoft.VSTS.Common.Severity'
	$StrWorkItemId = $ObjRequestBody.resource.'id'
	$StrUrl = $ObjRequestBody.resource.'url'
	
	# Build email variables
	$StrMessageSubject = 'New ' + $StrWorkItemType + ' created in the ' + $StrTeamProject + ' project'
	$StrMessageBody = "<font face=`"Calibri`">Hey Folks!<br><br>
    
        There was a new $StrWorkItemType created in the $StrTeamProject project.<br><br>
        	
		<b>Work Item Details</b><br>
		Id:  $StrWorkItemId<br>
		Title:  $StrTitle<br>
		Area Path:  $StrAreaPath<br>
		Type:  $StrWorkItemType<br>
		Severity:  $StrSeverity<br>
		Created By:  $StrCreatedBy<br>
		URL:  $StrUrl<br><br>
		
		This item will be reviewed and prioritized appropriately.<br><br>
		
		Thank you!<br><br>
		
		The $StrTeamProject Project Team</font>"
 
    # Retrieve automation credentials
    $ObjAzureCred = Get-AutomationPSCredential -Name $StrCredentialName
	
 	# Send Email
    if ($ObjAzureCred) 
    {
        Send-MailMessage -To $StrMessageTo -Subject $StrMessageSubject -Body $StrMessageBody -UseSsl -Port 587 -SmtpServer $StrSmtpServer -From $ObjAzureCred.UserName -BodyAsHtml -Credential $ObjAzureCred
	}
}