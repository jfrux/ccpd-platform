<cfparam name="Attributes.Overview" default="" />
<cfparam name="Attributes.Keywords" default="" />
<cfparam name="Attributes.Objectives" default="" />
<cfparam name="Attributes.Goals" default="" />
<cfparam name="Attributes.PublishDate" default="" />
<cfparam name="Attributes.RemoveDate" default="" />
<cfparam name="Attributes.FeaturedFlag" default="N" />
<cfparam name="Attributes.extHostFlag" default="N" />
<cfparam name="Attributes.extHostLink" default="" />
<cfparam name="Attributes.PaymentFlag" default="N" />
<cfparam name="Attributes.PaymentFee" default="0.00" />
<cfparam name="Attributes.TermsFlag" default="N" />
<cfparam name="Attributes.AllowCommentFlag" default="N" />
<cfparam name="Attributes.CommentApproveFlag" default="N" />
<cfparam name="Attributes.NotifyEmails" default="" />
<cfparam name="Attributes.TermsText" default="" />
<cfparam name="Attributes.RestrictedFlag" default="N" />

<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />

<script>
// tinyMCE.init({
//  mode : "exact",
//  elements : "Overview,Objectives,Keywords",
//  theme : "simple",
//  width:'450px',
//  height:'150px',
//  setup: function(ed) {
//       ed.onKeyUp.add(function(ed, e) {
//      Unsaved();
//      });
//     }
// });

$(document).ready(function() {
  //CKEDITOR.replace("");
  CKEDITOR.replace( 'js-overview-input',
  {
    on:
     {
        blur: function( evt ) {
          var $editor = $(this.container.$);
          $editor.find('.cke_top').addClass('hide');
        },
        focus: function( evt ) {
          var $editor = $(this.container.$);
          $editor.find('.cke_top').removeClass('hide');
        },
        instanceReady : function ( evt )
        {
           var $editor = $(this.container.$);
            $editor.find('.cke_top').addClass('hide');
        }
     }
  });
  CKEDITOR.replace("js-objectives-input",
    {
      on:
       {
          blur: function( evt ) {
            var $editor = $(this.container.$);
            $editor.find('.cke_top').addClass('hide');
          },
          focus: function( evt ) {
            var $editor = $(this.container.$);
            $editor.find('.cke_top').removeClass('hide');
          },
          instanceReady : function ( evt )
          {
             var $editor = $(this.container.$);
              $editor.find('.cke_top').addClass('hide');
          }
       }
    });

  $(".TermsBox").click(function() {
    if($(this).val() == 'Y') {
      $("#TermsContainer").show();
    } else {
      $("#TermsContainer").hide();
    }
  });
  
  $("#PaymentFlagY,#PaymentFlagN").click(function() {
    var sValue = $(this).val();
    
    if(sValue == 'Y') {
      $(".PaymentFeeArea").show();
    } else if (sValue == 'N') {
      $("#PaymentFee").val('0.00');
      $(".PaymentFeeArea").hide();
    }
  });
  
  $('.extHostFlag').change(function() {
    if($(this).val() == 'Y') {
      $('#ext-host-container').show();
    } else {
      $('#ext-host-container').hide();
    }
  });
});
</script>
<cfoutput>
<div class="ViewSection">
  <form action="#Application.Settings.RootPath#/_com/AJAX_Activity.cfc" method="post" class="form-horizontal" name="frmPubGeneral" id="EditForm">

      <input type="hidden" name="method" value="savePubGeneral" />
      <input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
      <input type="hidden" name="returnFormat" value="plain" />
    <cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" />
    <div class="control-group">
      <label class="control-label" for="Overview">Overview</label></td>
      <div class="controls">
        <textarea name="Overview" id="js-overview-input">#Attributes.Overview#</textarea> 
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="Objectives">Objectives</label>
      <div class="controls">
        <textarea name="Objectives" id="js-objectives-input">#Attributes.Objectives#</textarea>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="Keywords">Keywords</label>
      <div class="controls">
        <textarea name="Keywords" id="Keywords">#Attributes.Keywords#</textarea>
      </div>
    </div>
      <div class="control-group">
        <label class="control-label" for="PublishDate">Publish Date</label>
        <div class="controls">
          <input type="text" name="PublishDate" id="PublishDate" class="DatePicker" value="#Attributes.PublishDate#" style="width:100px;" /> (date desired to be published)
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="RemoveDate">Remove Date</label>
        <div class="controls">
          <input type="text" name="RemoveDate" id="RemoveDate" class="DatePicker" value="#Attributes.RemoveDate#" style="width:100px;" /> (date desired to be removed from sites)
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="PaymentFlagY">Require Payment?</label>
        <div class="controls">
          <label class="radio inline" for="PaymentFlagY" class="radio inline">
            <input type="radio" name="PaymentFlag" id="PaymentFlagY" value="Y"<cfif Attributes.PaymentFlag EQ "Y"> checked</cfif> /> 
            Yes
          </label> 
          <label class="radio inline" for="PaymentFlagN" class="radio inline">
            <input type="radio" name="PaymentFlag" id="PaymentFlagN" value="N"<cfif Attributes.PaymentFlag EQ "N"> checked</cfif> /> 
            No
          </label>
        </div>
      </div>
      <div class="control-group PaymentFeeArea"<cfif Attributes.PaymentFlag EQ "N"> style="display:none;"</cfif>>
        <label class="control-label" for="PaymentFlagY">Fee Amount</label>
        <div class="controls">
          <input type="text" name="PaymentFee" id="PaymentFee" style="width:70px;" value="#Attributes.PaymentFee#" /> (ex: 30.00)
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="PaymentFlagY">Restrict to Registrants List?</label>
        <div class="controls">
          <label class="radio inline" for="RestrictedFlagY"><input type="radio" name="RestrictedFlag" id="RestrictedFlagY" value="Y"<cfif Attributes.RestrictedFlag EQ "Y"> checked</cfif> />
           Yes</label> 
          <label class="radio inline" for="RestrictedFlagN"><input type="radio" name="RestrictedFlag" id="RestrictedFlagN" value="N"<cfif Attributes.RestrictedFlag EQ "N"> checked</cfif> />
           No</label>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="TermsFlag">Require Terms?</label>
        <div class="controls">
          <label class="radio inline" for="TermsFlagY"><input type="radio" name="TermsFlag" id="TermsFlagY" class="TermsBox" value="Y"<cfif Attributes.TermsFlag EQ "Y"> checked</cfif> />
           Yes</label> 
          <label class="radio inline" for="TermsFlagN"><input type="radio" name="TermsFlag" id="TermsFlagN" class="TermsBox" value="N"<cfif Attributes.TermsFlag EQ "N"> checked</cfif> />
           No</label>
        </div>
      </div>
      <div class="control-group TermsContainer"<cfif Attributes.TermsFlag EQ "N"> style="display:none;"</cfif>>
        <label class="control-label" for="TermsText">Terms Text</label>
        <div class="controls">
          <textarea name="TermsText" id="TermsText" style="width:425px;">#Attributes.TermsText#</textarea>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="FeaturedFlag">Featured Activity?</label>
        <div class="controls">
          <label class="radio inline" for="FeaturedFlagY"><input type="radio" name="FeaturedFlag" id="FeaturedFlagY" class="CommentsBox" value="Y"<cfif Attributes.FeaturedFlag EQ "Y"> checked</cfif> />
           Yes</label> 
          <label class="radio inline" for="FeaturedFlagN"><input type="radio" name="FeaturedFlag" id="FeaturedFlagN" class="CommentsBox" value="N"<cfif Attributes.FeaturedFlag EQ "N"> checked</cfif> />
           No</label>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="extHostFlag">Externally Hosted Activity?</label>
        <div class="controls">
          <label class="radio inline" for="extHostFlagY"><input type="radio" name="extHostFlag" class="extHostFlag" id="extHostFlagY" value="Y"<cfif Attributes.extHostFlag EQ "Y"> checked</cfif> />
           Yes</label> 
          <label class="radio inline" for="extHostFlagN"><input type="radio" name="extHostFlag" class="extHostFlag" id="extHostFlagN" value="N"<cfif Attributes.extHostFlag EQ "N"> checked</cfif> />
           No</label> <span id="ext-host-container"<cfif Attributes.extHostFlag EQ "N"> style="display:none;"</cfif>><input type="text" name="extHostLink" id="extHostLink" value="#attributes.extHostLink#" placeholder="External Activity Address" style="width: 225px;" /></span>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="AllowCommentFlag">Allow Comments</label>
        <div class="controls">
          <label class="radio inline" for="AllowCommentFlagY">
            <input type="radio" name="AllowCommentFlag" id="AllowCommentFlagY" class="CommentsBox" value="Y"<cfif Attributes.AllowCommentFlag EQ "Y"> checked</cfif> />
            Yes
          </label> 
          <label class="radio inline" for="AllowCommentFlagN"> 
            <input type="radio" name="AllowCommentFlag" id="AllowCommentFlagN" class="CommentsBox" value="N"<cfif Attributes.AllowCommentFlag EQ "N"> checked</cfif> />
            No
          </label>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="CommentApproveFlag">Require Comment Approval</label>
        <div class="controls">
          <label class="radio inline" for="CommentApprovalFlagY"><input type="radio" name="CommentApproveFlag" id="CommentApproveFlagY" class="CommentApprovalBox" value="Y"<cfif Attributes.CommentApproveFlag EQ "Y"> checked</cfif> />
           Yes</label> 
          <label class="radio inline" for="CommentApproveFlagN"><input type="radio" name="CommentApproveFlag" id="CommentApproveFlagN" class="CommentApprovalBox" value="N"<cfif Attributes.CommentApproveFlag EQ "N"> checked</cfif> />
           No</label>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="NotifyEmails">Notify Email Addresses</label>
        <div class="controls">
          <input type="text" name="NotifyEmails" id="NotifyEmailsN" class="EmailBox" value="#Attributes.NotifyEmails#" />
        </div>
      </div>
  </form>
</div>

</cfoutput>