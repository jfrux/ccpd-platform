<cfoutput>
<div class="email-list listinator">
  <cfloop query="emailList">
    <cfset rowClasses = "" />
    <cfif emailList.isPrimaryEmail>
      <cfset rowClasses &= " is-primary" />
    </cfif>
    <cfif emailList.allow_login>
      <cfset rowClasses &= " is-allow-login" />
    </cfif>
    <cfif emailList.is_verified>
      <cfset rowClasses &= " is-verified" />
    </cfif>
  <div class="list-row js-list-row email-#emailList.email_id# view-row#rowClasses#" data-key="#emailList.email_id#" id="view-email-#emailList.email_id#">
    <div class="email-address span16"><a href="mailto:#emailList.email_address#">#emailList.email_address#</a></div>
    <div class="row-status span8">
      <ul class="status-group">
        <li class="primary-icon">
        <cfif emailList.isPrimaryEmail>
          <i class="icon-star"></i>
        <cfelse>
          <i class="icon-star"></i>
        </cfif>
        </li>
        <li class="allow-login-icon">
        <cfif emailList.allow_login>
          <i class="icon-lock"></i>
        <cfelse>
          <i class="icon-lock-open"></i>
        </cfif>
        </li>
        <li class="verified-icon">
        <cfif emailList.is_verified>
         <i class="icon-ok"></i>
        <cfelse>
          <i class="icon-hammer"></i>
        </cfif>
        </li>
        <li>
          <i></i>
        </li>
      </ul>
    </div>
    <div class="row-actions span8">
      <div class="btn-group">
        <cfif emailList.isPrimaryEmail>
          <a href="javascript://" class="primary-icon makeprimary-link active disabled btn" data-tooltip-title="Is currently the primary email." id="makeprimary-#emailList.email_id#"><i class="icon-star"></i></a>
        <cfelse>
          <cfif emailList.is_verified>
          <a href="javascript://" class="primary-icon makeprimary-link btn" data-tooltip-title="Mark as Primary Email Address" id="makeprimary-#emailList.email_id#"><i class="icon-star"></i></a>
          <cfelse>
          <a href="javascript://" class="primary-icon disabled btn" data-tooltip-title="Mark as Primary Email Address" id="makeprimary-#emailList.email_id#"><i class="icon-star"></i></a>
          </cfif>
        </cfif>
        
        <cfif emailList.allow_login>
          <a href="javascript://" class="allow-login-icon allowlogin-link active btn" data-button-action="disable" data-tooltip-title="Disable authentication with this email address." id="allowlogin-#emailList.email_id#"><i class="icon-lock"></i></a>
        <cfelse>
          <cfif emailList.is_verified>
            <a href="javascript://" class="allow-login-icon allowlogin-link btn" data-button-action="enable" data-tooltip-title="Enable authentication with this email address." id="allowlogin-#emailList.email_id#"><i class="icon-lock-open"></i></a>
          <cfelse>
            <a href="javascript://" class="allow-login-icon disabled btn" data-button-action="enable" data-tooltip-title="Enable authentication with this email address." id="allowlogin-#emailList.email_id#"><i class="icon-lock-open"></i></a>
          </cfif>
        </cfif>
        
        <cfif emailList.is_verified>
          <a href="javascript://" class="verified-icon activated active disabled btn" data-tooltip-title="Email has been verified!" id="isverified-#emailList.email_id#"><i class="icon-ok"></i></a>
        <cfelse>
          <a href="javascript://" class="verified-icon isverified-link btn" data-tooltip-title="Send Verification Request Email" id="isverified-#emailList.email_id#"><i class="icon-hammer"></i></a>
        </cfif>
      </div>
      <div class="btn-group">
        <a href="javascript://" class="delete-link btn" data-tooltip-title="Delete Email Address" id="delete-#emailList.email_id#"><i class="icon-trash"></i></a>
      </div>
    </div>
  </div>
  </cfloop>
</div>
</cfoutput>