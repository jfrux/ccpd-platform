
<!--- Check to see which version of the tag we are executing. --->
<cfswitch expression="#THISTAG.ExecutionMode#">

	<cfcase value="Start">
	
		<!--- Get a reference to the document tag context. --->
		<cfset VARIABLES.DocumentTag = GetBaseTagData( "cf_document" ) />

		<!--- Get a reference to the sheet tag context. --->
		<cfset VARIABLES.SheetTag = GetBaseTagData( "cf_sheet" ) />
		
		<!--- Get a reference to the row tag context. --->
		<cfset VARIABLES.RowTag = GetBaseTagData( "cf_row" ) />
		
		<!--- Get a reference to the cell tag context. --->
		<cfset VARIABLES.CellTag = GetBaseTagData( "cf_cell" ) />
		
		<!--- Param tag attributes. --->
		
		<!--- The file path to the image relative or physical --->
		<cfparam
			name="ATTRIBUTES.Src"
			type="string"
			/>
		<!--- 
			The index at which this image will be created. Defaults to be 
			appended to the row. 
		--->
		<cfparam
			name="ATTRIBUTES.Index"
			type="numeric"
			default="#VARIABLES.RowTag.CellIndex#"
			/>
			
		<!--- 
			Fixed height of image
		--->
		<cfparam
			name="ATTRIBUTES.Height"
			type="numeric"
			default="0"
			/>
		
		<!--- 
			Fixed width of image
		--->
		<cfparam
			name="ATTRIBUTES.Width"
			type="numeric"
			default="0"
			/>
		
		<cfset VARIABLES.inputStream = CreateObject("java","java.io.FileInputStream").init(expandPath(ATTRIBUTES.Src)) />
		<cfset VARIABLES.bytes = CreateObject("java","org.apache.poi.util.IOUtils").toByteArray(VARIABLES.inputStream) />
		<cfset VARIABLES.pictureIdx = javaCast('int',VARIABLES.DocumentTag.Workbook.addPicture(VARIABLES.bytes, VARIABLES.DocumentTag.Workbook.PICTURE_TYPE_JPEG)) />
		<cfset VARIABLES.inputStream.close() />
		
		<cfset VARIABLES.Helper = VARIABLES.DocumentTag.Workbook.getCreationHelper() />
		
		<cfset VARIABLES.Drawing = VARIABLES.SheetTag.sheet.createDrawingPatriarch() />
		
		<cfset VARIABLES.Anchor = VARIABLES.Helper.createClientAnchor() />
		<cfset VARIABLES.Anchor.setCol1(ATTRIBUTES.Index - 1) />
		<cfset VARIABLES.Anchor.setRow1(VARIABLES.SheetTag.RowIndex - 1) />
		
		<cfset VARIABLES.Pict = VARIABLES.Drawing.createPicture(VARIABLES.Anchor, VARIABLES.pictureIdx) />
		<cfset VARIABLES.Pict.resize() />
	</cfcase>
	
	
	<cfcase value="End">
	
	</cfcase>
	
</cfswitch>

