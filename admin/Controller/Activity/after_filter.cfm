<cfif #structKeyExists(attributes,'activityid')# AND attributes.activityID GT 0>
  <cfinvoke object="myFusebox" 
    method="do" fuseaction="mActivity.getActivity" />
</cfif>
<cfif isPjax()>
  <cfif #structKeyExists(attributes,'activityid')# AND attributes.activityID GT 0>      
    <cfinvoke object="myFusebox" 
      method="do" fuseaction="vActivity.#params.action#','multiformcontent" />
    <cfif #request.currentTab.hasToolbar#>
      <cfinvoke object="myFusebox" 
        method="do" fuseaction="vActivity.#params.action#right','multiformright" />
    </cfif>
  </cfif>
    <cfinvoke object="myFusebox" 
      method="do" fuseaction="vLayout.Blank" />
<cfelse>
  <cfif isAjax()>
    <cfinvoke 
      object="myFusebox" 
      method="do" fuseaction="vLayout.Blank" />
  <cfelse>
    <cfif #structKeyExists(attributes,'activityid')# AND attributes.activityID GT 0>
      <cfif #request.currentTab.hasToolbar#>
        <cfinvoke 
          object="myFusebox" 
          method="do" fuseaction="vActivity.#request.page.action#right','multiformright" />
      </cfif>
      <cfinvoke object="myFusebox" 
        method="do" fuseaction="vActivity.#request.page.action#','multiformcontent" />
      <cfinvoke object="myFusebox" 
        method="do" fuseaction="vLayout.Hub','request.page.body" />
    <cfelse>
      <cfif NOT structKeyExists(attributes,'activityid') OR (structKeyExists(attributes,'activityid') AND attributes.activityID LTE 0)>
          <cfinvoke object="myFusebox" 
            method="do" fuseaction="vActivity.#params.action#','multiformcontent" />
          <cfinvoke object="myFusebox" 
            method="do" fuseaction="vLayout.sub_slim','request.page.body" />
      </cfif>
    </cfif>
    <cfinvoke object="myFusebox" 
      method="do" fuseaction="vLayout.Application" />
  </cfif>
</cfif>