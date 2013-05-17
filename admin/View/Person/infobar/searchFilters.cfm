<cfoutput>
<span>
  <a href="#myself#Person.Create?Instance=#Attributes.Instance#&Mode=Insert&ActivityID=#Attributes.ActivityID#" class="btn btn-create"><i class="icon-edit icon-large"></i> Create Person</a>
</span>
<div class="filters">
  <!--- <h3><a class="js-filter" data-type="easy">Easy Search</a></h3>
  <div class="box">
    <div class="row-fluid">
      <form name="frmSearch" class="form-inline" method="post" action="#myself##xfa.SearchSubmit#">
        <input type="text" name="q" class="span24" placeholder="Type to search" data-tooltip-title="Start typing names, emails, birthdates, etc." value="#attributes.q#" />
      </form>
    </div>
  </div> --->
  <h3><a class="js-filter" data-type="advanced">Search Criteria</a></h3>
  <div class="js-filter-form box">
    <div class="row-fluid">
      <form name="frmSearch" class="form-search-filters" method="get" action="#myself#main.people">
        <input type="text" name="LastName" id="LastName" class="input-block-level" placeholder="Last Name" value="#Attributes.LastName#" />
        <input type="text" name="FirstName" id="FirstName" class="input-block-level" placeholder="First Name" value="#Attributes.FirstName#" />
        <input type="text" name="Birthdate" id="Birthdate" class="input-block-level" placeholder="Date of Birth" value="#Attributes.Birthdate#" />
        <input type="text" name="Email" id="Email" class="input-block-level" placeholder="Email Address" value="#Attributes.Email#" />
        <input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
        <button class="btn"><i class="icon-search"></i></button>
        <input type="hidden" name="Search" value="1" />
        <input type="hidden" name="Instance" value="#Attributes.Instance#" />
      </form>
    </div>
  </div>
</div>
</cfoutput>