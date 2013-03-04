<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Public -->
<circuit access="public">
	<fuseaction name="Cert">
    	<do action="mPublic.getCertType" />
		<do action="mPublic.getCertData" />
		<do action="mPublic.getDetail" />
		<do action="vPublic.CertRails" />
        <do action="vLayout.None" />
	</fuseaction>

	<fuseaction name="CertRails">
    	<do action="mPublic.getCertType" />
		<do action="mPublic.getCertData" />
		<do action="mPublic.getDetail" />
		<do action="vPublic.CertRails" />
        <do action="vLayout.None" />
	</fuseaction>
    
	<fuseaction name="Download">
		<do action="vPublic.downloadFile" />
	</fuseaction>
    
	<fuseaction name="Signup">
		<do action="mPublic.doSignup" />
		<do action="vPublic.SignupForm" contentvariable="Request.Page.Body" />
		<do action="vLayout.Blank" />
	</fuseaction>
	
	<fuseaction name="FileView">
		<do action="mPublic.getFileInfo" />
		<do action="vPublic.FileView" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.None" />
	</fuseaction>
    
    <fuseaction name="Register">
		<do action="mPublic.LookupActivity" />
    	<do action="mActivity.getActivity" />
        
		<switch expression="#Attributes.Step#">
			<case value="Finished">
				<do action="vPublic.RegFinished" contentvariable="Request.Page.Body" />
				<set name="Request.Page.Title" value="Online Registration Finished!" />
			</case>
			<defaultcase>
				<do action="mPublic.RegPayment" />
				<do action="vPublic.RegisterMain" contentvariable="Request.Page.Body" />
				<set name="Request.Page.Title" value="Online Registration" />
			</defaultcase>
		</switch>
		
        <do action="vLayout.Register" />
    </fuseaction>
</circuit>