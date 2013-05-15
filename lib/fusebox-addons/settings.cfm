<cfscript>
	application.settings.cache = {};
	application.settings.cache.sql = {};
	application.settings.cache.image = {};
	application.settings.cache.main = {};
	application.settings.cache.action = {};
	application.settings.cache.page = {};
	application.settings.cache.partial = {};
	application.settings.cache.query = {};
	application.settings.cacheLastCulledAt = Now();

	// set up paths to various folders in the framework
	application.settings.assetWebPath = "";
	application.settings.webPath = Replace(request.cgi.script_name, Reverse(spanExcluding(Reverse(request.cgi.script_name), "/")), "");
	application.settings.rootPath = "/" & ListChangeDelims(application.settings.webPath, "/", "/");
	application.settings.rootcomponentPath = ListChangeDelims(application.settings.webPath, ".", "/");
	//application.settings.assetsPath = "/assets";
	application.settings.wheelsComponentPath = ListAppend(application.settings.rootcomponentPath, "wheels", ".");
	application.settings.configPath = "config";
	application.settings.eventPath = "events";
	application.settings.filePath = "files";
	application.settings.imagePath = "images";
	application.settings.javascriptPath = "javascripts";
	application.settings.modelPath = "Models";
	application.settings.modelComponentPath = "models";
	application.settings.pluginPath = "plugins";
	application.settings.pluginComponentPath = "plugins";
	application.settings.stylesheetPath = "stylesheets";
	application.settings.viewPath = "Views";

	// rewrite settings based on web server rewrite capabilites
	application.settings.rewriteFile = "rewrite.cfm";
	if (Right(request.cgi.script_name, 12) == "/" & application.settings.rewriteFile)
		application.settings.URLRewriting = "On";
	else if (Len(request.cgi.path_info))
		application.settings.URLRewriting = "Partial";
	else
		application.settings.URLRewriting = "Off";

	// set datasource name to same as the folder the app resides in unless the developer has set it with the global setting already
	if (StructKeyExists(this, "dataSource"))
		application.settings.dataSourceName = this.dataSource;
	else
		application.settings.dataSourceName = LCase(ListLast(GetDirectoryFromPath(GetBaseTemplatePath()), Right(GetDirectoryFromPath(GetBaseTemplatePath()), 1)));
	application.settings.dataSourceUserName = "";
	application.settings.dataSourcePassword = "";
	application.settings.transactionMode = "commit"; // use 'commit', 'rollback' or 'none' to set default transaction handling for creates, updates and deletes

	// cache settings
	application.settings.cacheDatabaseSchema = false;
	application.settings.cacheFileChecking = false;
	application.settings.cacheImages = false;
	application.settings.cacheModelInitialization = false;
	application.settings.cacheControllerInitialization = false;
	application.settings.cacheRoutes = false;
	application.settings.cacheActions = false;
	application.settings.cachePages = false;
	application.settings.cachePartials = false;
	application.settings.cacheQueries = false;
	application.settings.cachePlugins = true;
	if (application.settings.environment != "design")
	{
		application.settings.cacheDatabaseSchema = true;
		application.settings.cacheFileChecking = true;
		application.settings.cacheImages = true;
		application.settings.cacheModelInitialization = true;
		application.settings.cacheControllerInitialization = true;
		application.settings.cacheRoutes = true;
	}
	if (application.settings.environment != "design" && application.settings.environment != "development")
	{
		application.settings.cacheActions = true;
		application.settings.cachePages = true;
		application.settings.cachePartials = true;
		application.settings.cacheQueries = true;
	}

	// debugging and error settings
	application.settings.showDebugInformation = true;
	application.settings.showErrorInformation = true;
	application.settings.sendEmailOnError = false;
	application.settings.errorEmailSubject = "Error";
	application.settings.excludeFromErrorEmail = "";
	if (request.cgi.server_name Contains ".")
		application.settings.errorEmailAddress = "webmaster@" & Reverse(ListGetAt(Reverse(request.cgi.server_name), 2,".")) & "." & Reverse(ListGetAt(Reverse(request.cgi.server_name), 1, "."));
	else
		application.settings.errorEmailAddress = "";
	if (application.settings.environment == "production")
	{
		application.settings.showErrorInformation = false;
		application.settings.sendEmailOnError = true;
	}
	if (application.settings.environment != "design" && application.settings.environment != "development")
		application.settings.showDebugInformation = false;

	// asset path settings
	// assetPaths can be struct with two keys,  http and https, if no https struct key, http is used for secure and non-secure
	// ex. {http="asset0.domain1.com,asset2.domain1.com,asset3.domain1.com", https="secure.domain1.com"}
	application.settings.assetQueryString = false;
	application.settings.assetPaths = false;
	if (application.settings.environment != "design" && application.settings.environment != "development")
		application.settings.assetQueryString = true;

	// paths
	application.settings.controllerPath = "controllers";

	// miscellaneous settings
	application.settings.tableNamePrefix = "";
	application.settings.obfuscateURLs = false;
	application.settings.reloadPassword = "";
	application.settings.softDeleteProperty = "deletedAt";
	application.settings.timeStampOnCreateProperty = "createdAt";
	application.settings.timeStampOnUpdateProperty = "updatedAt";
	application.settings.ipExceptions = "";
	application.settings.overwritePlugins = true;
	application.settings.deletePluginDirectories = true;
	application.settings.loadIncompatiblePlugins = true;
	application.settings.loadDefaultRoutes = true;
	application.settings.automaticValidations = true;
	application.settings.setUpdatedAtOnCreate = true;
	application.settings.useExpandedColumnAliases = false;

	// if session management is enabled in the application we default to storing flash data in the session scope, if not we use a cookie
	if (StructKeyExists(this, "sessionManagement") && this.sessionManagement)
	{
		application.settings.sessionManagement = true;
		application.settings.flashStorage = "session";
	}
	else
	{
		application.settings.sessionManagement = false;
		application.settings.flashStorage = "cookie";
	}

	// caching settings
	application.settings.maximumItemsToCache = 5000;
	application.settings.cacheCullPercentage = 10;
	application.settings.cacheCullInterval = 5;
	application.settings.cacheDatePart = "n";
	application.settings.defaultCacheTime = 60;
	application.settings.clearQueryCacheOnReload = true;
	application.settings.cacheQueriesDuringRequest = true;
	
	// possible formats for provides
	application.settings.formats = {};
	application.settings.formats.html = "text/html";
	application.settings.formats.xml = "text/xml";
	application.settings.formats.json = "application/json";
	application.settings.formats.csv = "text/csv";
	application.settings.formats.pdf = "application/pdf";
	application.settings.formats.xls = "application/vnd.ms-excel";

	// function defaults
	application.settings.functions = {};
	application.settings.functions.average = {distinct=false, parameterize=true, ifNull=""};
	application.settings.functions.belongsTo = {joinType="inner"};
	application.settings.functions.buttonTo = {onlyPath=true, host="", protocol="", port=0, text="", confirm="", image="", disable=""};
	application.settings.functions.buttonTag = {type="submit", value="save", content="Save changes", image="", disable=""};
	application.settings.functions.caches = {time=60, static=false};
	application.settings.functions.checkBox = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors", checkedValue=1, unCheckedValue=0};
	application.settings.functions.checkBoxTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", value=1};
	application.settings.functions.count = {parameterize=true};
	application.settings.functions.create = {parameterize=true, reload=false};
	application.settings.functions.dateSelect = {label=false, labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors", includeBlank=false, order="month,day,year", separator=" ", startYear=Year(Now())-5, endYear=Year(Now())+5, monthDisplay="names"};
	application.settings.functions.dateSelectTags = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, order="month,day,year", separator=" ", startYear=Year(Now())-5, endYear=Year(Now())+5, monthDisplay="names"};
	application.settings.functions.dateTimeSelect = {label=false, labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors", includeBlank=false, dateOrder="month,day,year", dateSeparator=" ", startYear=Year(Now())-5, endYear=Year(Now())+5, monthDisplay="names", timeOrder="hour,minute,second", timeSeparator=":", minuteStep=1, secondStep=1, separator=" - "};
	application.settings.functions.dateTimeSelectTags = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, dateOrder="month,day,year", dateSeparator=" ", startYear=Year(Now())-5, endYear=Year(Now())+5, monthDisplay="names", timeOrder="hour,minute,second", timeSeparator=":", minuteStep=1, secondStep=1,separator=" - "};
	application.settings.functions.daySelectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false};
	application.settings.functions.delete = {parameterize=true};
	application.settings.functions.deleteAll = {reload=false, parameterize=true, instantiate=false};
	application.settings.functions.deleteByKey = {reload=false};
	application.settings.functions.deleteOne = {reload=false};
	application.settings.functions.distanceOfTimeInWords = {includeSeconds=false};
	application.settings.functions.errorMessageOn = {prependText="", appendText="", wrapperElement="span", class="errorMessage"};
	application.settings.functions.errorMessagesFor = {class="errorMessages", showDuplicates=true};
	application.settings.functions.exists = {reload=false, parameterize=true};
	application.settings.functions.fileField = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors"};
	application.settings.functions.fileFieldTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel=""};
	application.settings.functions.findAll = {reload=false, parameterize=true, perPage=10, order="", group="", returnAs="query", returnIncluded=true};
	application.settings.functions.findByKey = {reload=false, parameterize=true, returnAs="object"};
	application.settings.functions.findOne = {reload=false, parameterize=true, returnAs="object"};
	application.settings.functions.flashKeep = {};
	application.settings.functions.flashMessages = {class="flashMessages", includeEmptyContainer="false", lowerCaseDynamicClassValues=false};
	application.settings.functions.hasMany = {joinType="outer", dependent=false};
	application.settings.functions.hasOne = {joinType="outer", dependent=false};
	application.settings.functions.hiddenField = {};
	application.settings.functions.highlight = {delimiter=",", tag="span", class="highlight"};
	application.settings.functions.hourSelectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false};
	application.settings.functions.imageTag = {};
	application.settings.functions.includePartial = {layout="", spacer="", dataFunction=true};
	application.settings.functions.javaScriptIncludeTag = {type="text/javascript", head=false};
	application.settings.functions.linkTo = {onlyPath=true, host="", protocol="", port=0};
	application.settings.functions.mailTo = {encode=false};
	application.settings.functions.maximum = {parameterize=true, ifNull=""};
	application.settings.functions.minimum = {parameterize=true, ifNull=""};
	application.settings.functions.minuteSelectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, minuteStep=1};
	application.settings.functions.monthSelectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, monthDisplay="names"};
	application.settings.functions.nestedProperties = {autoSave=true, allowDelete=false, sortProperty="", rejectIfBlank=""};
	application.settings.functions.paginationLinks = {windowSize=2, alwaysShowAnchors=true, anchorDivider=" ... ", linkToCurrentPage=false, prepend="", append="", prependToPage="", prependOnFirst=true, prependOnAnchor=true, appendToPage="", appendOnLast=true, appendOnAnchor=true, classForCurrent="", name="page", showSinglePage=false, pageNumberAsParam=true};
	application.settings.functions.passwordField = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors"};
	application.settings.functions.passwordFieldTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel=""};
	application.settings.functions.radioButton = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors"};
	application.settings.functions.radioButtonTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel=""};
	application.settings.functions.redirectTo = {onlyPath=true, host="", protocol="", port=0, addToken=false, statusCode=302, delay=false};
	application.settings.functions.renderPage = {layout=""};
	application.settings.functions.renderWith = {layout=""};
	application.settings.functions.renderPageToString = {layout=true};
	application.settings.functions.renderPartial = {layout="", dataFunction=true};
	application.settings.functions.save = {parameterize=true, reload=false};
	application.settings.functions.secondSelectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, secondStep=1};
	application.settings.functions.select = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors", includeBlank=false, valueField="", textField=""};
	application.settings.functions.selectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, multiple=false, valueField="", textField=""};
	application.settings.functions.sendEmail = {layout=false, detectMultipart=true, from="", to="", subject=""};
	application.settings.functions.sendFile = {disposition="attachment"};
	application.settings.functions.startFormTag = {onlyPath=true, host="", protocol="", port=0, method="post", multipart=false, spamProtection=false};
	application.settings.functions.styleSheetLinkTag = {type="text/css", media="all", head=false};
	application.settings.functions.submitTag = {value="Save changes", image="", disable="", prepend="", append=""};
	application.settings.functions.sum = {distinct=false, parameterize=true, ifNull=""};
	application.settings.functions.textArea = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors"};
	application.settings.functions.textAreaTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel=""};
	application.settings.functions.textField = {label="useDefaultLabel", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors"};
	application.settings.functions.textFieldTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel=""};
	application.settings.functions.timeAgoInWords = {includeSeconds=false};
	application.settings.functions.timeSelect = {label=false, labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", errorElement="span", errorClass="fieldWithErrors", includeBlank=false, order="hour,minute,second", separator=":", minuteStep=1, secondStep=1};
	application.settings.functions.timeSelectTags = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, order="hour,minute,second", separator=":", minuteStep=1, secondStep=1};
	application.settings.functions.timeUntilInWords = {includeSeconds=false};
	application.settings.functions.toggle = {save=true};
	application.settings.functions.truncate = {length=30, truncateString="..."};
	application.settings.functions.update = {parameterize=true, reload=false};
	application.settings.functions.updateAll = {reload=false, parameterize=true, instantiate=false};
	application.settings.functions.updateByKey = {reload=false};
	application.settings.functions.updateOne = {reload=false};
	application.settings.functions.updateProperty = {parameterize=true};
	application.settings.functions.updateProperties = {parameterize=true};
	application.settings.functions.URLFor = {onlyPath=true, host="", protocol="", port=0};
	application.settings.functions.validatesConfirmationOf = {message="[property] should match confirmation"};
	application.settings.functions.validatesExclusionOf = {message="[property] is reserved", allowBlank=false};
	application.settings.functions.validatesFormatOf = {message="[property] is invalid", allowBlank=false};
	application.settings.functions.validatesInclusionOf = {message="[property] is not included in the list", allowBlank=false};
	application.settings.functions.validatesLengthOf = {message="[property] is the wrong length", allowBlank=false, exactly=0, maximum=0, minimum=0, within=""};
	application.settings.functions.validatesNumericalityOf = {message="[property] is not a number", allowBlank=false, onlyInteger=false, odd="", even="", greaterThan="", greaterThanOrEqualTo="", equalTo="", lessThan="", lessThanOrEqualTo=""};
	application.settings.functions.validatesPresenceOf = {message="[property] can't be empty"};
	application.settings.functions.validatesUniquenessOf = {message="[property] has already been taken", allowBlank=false};
	application.settings.functions.verifies = {handler=""};
	application.settings.functions.wordTruncate = {length=5, truncateString="..."};
	application.settings.functions.yearSelectTag = {label="", labelPlacement="around", prepend="", append="", prependToLabel="", appendToLabel="", includeBlank=false, startYear=Year(Now())-5, endYear=Year(Now())+5};

	// set a flag to indicate that all settings have been loaded
	application.settings.initialized = true;

	// mime types
	application.settings.mimetypes = {
		txt="text/plain"
		,gif="image/gif"
		,jpg="image/jpg"
		,jpeg="image/jpg"
		,pjpeg="image/jpg"
		,png="image/png"
		,wav="audio/wav"
		,mp3="audio/mpeg3"
		,pdf="application/pdf"
		,zip="application/zip"
		,ppt="application/powerpoint"
		,pptx="application/powerpoint"
		,doc="application/word"
		,docx="application/word"
		,xls="application/excel"
		,xlsx="application/excel"
	};
</cfscript>