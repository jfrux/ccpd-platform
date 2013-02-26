<cfcomponent displayname="Translate Modern English to Middle English">
	<cfparam name="url.reinit" default="false" />
	<cfset sourcePaths = [expandPath("\_java\opennlp\opennlp-tools-1.5.0.jar"),expandPath("\_java\opennlp\lib\maxent-3.0.0.jar"),expandPath("\_java\opennlp\lib\jwnl-1.3.3.jar"),expandPath("\_java\stanfordnlp\stanford-parser.jar")] />

	<cfif NOT isDefined("application.babelJavaloader") OR url.reinit>
	<cfset application.babelJavaloader = createObject("component", "javaloader.JavaLoader").init(sourcePaths) />
	<cfset application.babeleth.relations = getRelations() />
	<cfset application.babeleth.tags = getTags() />
	</cfif>
	<!---
	<cfset application.babeleth.exceptions = getExceptions() />--->
	<cfset exceptions = getExceptions() />
	<cfset javaloader = application.babelJavaloader />
	
	<cffunction name="init" access="public" output="no" returntype="_com.mideng">
		
	</cffunction>
	
	<cffunction name="getExceptions" access="public" output="no" returntype="query">
		<cfset var qExceptions = "" />
		
		<cfquery name="qExceptions" datasource="#application.settings.dsn#">
			WITH CTE_Ranked As (
				/* RANK 3 */
				SELECT     id, word, replaceWord, wordCount, isNull(gramRelate_id,0) As gramRelate_id, isNull(posTag_id,0) As posTag_id, [rank] = 3+wordCount
				FROM         bbl_exception
				WHERE     (isNull(gramRelate_id,0) > 0) AND (isNull(posTag_id,0) > 0)
			
				UNION
			
				/* RANK 2 */
				SELECT     id, word, replaceWord, wordCount, isNull(gramRelate_id,0) As gramRelate_id, isNull(posTag_id,0) As posTag_id, [rank] = 2+wordCount
				FROM         bbl_exception
				WHERE     (isNull(gramRelate_id,0) > 0) AND (isNull(posTag_id,0) = 0) OR
						   (gramRelate_id IS NULL) AND (isNull(posTag_id,0) > 0)
			
				UNION
			
				/* RANK 1 */
				SELECT     id, word, replaceWord, wordCount, isNull(gramRelate_id,0) As gramRelate_id, isNull(posTag_id,0) As posTag_id, [rank] = 1+wordCount
				FROM         bbl_exception
				WHERE     (gramRelate_id IS NULL) AND (isNull(posTag_id,0) = 0)
			) 
			SELECT exception.id, 
							exception.word,
							exception.replaceWord, 
							isNull(exception.gramRelate_id,0) As gramRelate_id, 
							ISNULL(exception.wordCount, 1) AS wordCount, 
							gramRelate.nameshort AS gramRelate,
							isNull(exception.posTag_id,0) As posTag_id, 
							posTag.tag AS posTag
							,
							[rank]
							 FROM CTE_Ranked AS exception 
			LEFT OUTER JOIN
			bbl_gramRelate AS gramRelate ON exception.gramRelate_id = gramRelate.id 
			LEFT OUTER JOIN
			bbl_posTag AS posTag ON exception.posTag_id = posTag.id
			ORDER BY [rank] DESC;
		</cfquery>
		
		
		<cfreturn qExceptions />
	</cffunction>
	
	<cffunction name="getRelations" access="public" output="no" returntype="query">
		<cfset var returned = "" />
		<cfset var qQuery = "" />
		
		<cfquery name="qQuery" datasource="#application.settings.dsn#">
			SELECT * FROM bbl_gramRelate
			ORDER BY name
		</cfquery>
		
		<cfset returned = qQuery />
		
		<cfreturn returned />
	</cffunction>
	
	<cffunction name="getTags" access="public" output="no" returntype="query">
		<cfset var returned = "" />
		
		<cfset var qQuery = "" />
		<cfquery name="qQuery" datasource="#application.settings.dsn#">
			SELECT * FROM bbl_posTag
			ORDER BY tag
		</cfquery>
		<cfset returned = qQuery />
		
		<cfreturn returned />
	</cffunction>
	
	<!---
	<cffunction name="saveRelations" access="remote" output="no" returntype="any" returnformat="plain">
		<cfset relations = getRelations() />
		
		<cfloop query="relations">
		<cfquery name="insert" datasource="#application.settings.dsn#">
					INSERT INTO bbl_gramRelate
					(
						name,
						nameshort,
						namelong,
						description,
						examples
					) VALUES (
						<cfqueryparam value="#relations.name#" cfsqltype="cf_sql_varchar" />,
						
						<cfqueryparam value="#relations.shortname#" cfsqltype="cf_sql_varchar" />,
						
						<cfqueryparam value="#relations.longname#" cfsqltype="cf_sql_varchar" />,
						
						<cfqueryparam value="#relations.description#" cfsqltype="cf_sql_varchar" />,
						
						<cfqueryparam value="#relations.example#" cfsqltype="cf_sql_varchar" />
					)
				</cfquery>
		</cfloop>
	</cffunction>--->
	
	<cffunction name="getReplacement" access="public" output="no" returntype="string">
		<cfargument name="word" type="string" required="yes" />
		<cfargument name="gramRelate" type="string" required="no" default="" />
		<cfargument name="posTag" type="string" required="no" default="" />

		<cfset var excepts = exceptions />

		<cfquery name="qExcept" dbtype="query">
			SELECT
				*
			FROM         
				excepts
			WHERE 
				word = <cfqueryparam value="#arguments.word#" cfsqltype="cf_sql_varchar" />
				<cfif len(arguments.gramRelate)> 
				AND gramRelate = <cfqueryparam value="#arguments.gramRelate#" cfsqltype="cf_sql_varchar" />
				</cfif>
				OR
				word = <cfqueryparam value="#arguments.word#" cfsqltype="cf_sql_varchar" />
				<cfif len(arguments.gramRelate)> 
				AND posTag = <cfqueryparam value="#arguments.posTag#" cfsqltype="cf_sql_varchar" />
				</cfif>
				
				OR word = <cfqueryparam value="#arguments.word#" cfsqltype="cf_sql_varchar" />
			ORDER BY
				wordCount DESC
		</cfquery>
		
		<cfif qExcept.recordcount>
			<cfset returnVar = qExcept.replaceWord />
		<cfelse>
			<cfset returnVar = arguments.word />
		</cfif>
		
		<cfreturn returnVar />
	</cffunction>
	
	<cffunction name="translate" access="remote" output="yes">
		<cfargument name="text" type="string" required="yes">
		
		<cfset var excepts = exceptions />
		<cfset var relations = application.babeleth.relations />
		<cfset var tags = application.babeleth.tags />
		
		<cfset var original = arguments.text />
		<cfset var translated = original />
		
		<!--- general java --->
		<cfset var string = CreateObject("java", "java.lang.String") />
		<cfset var array = CreateObject("java", "java.lang.reflect.Array") />
		
		<!--- stanford --->
		<cfset var stanfordParser = javaloader.create("edu.stanford.nlp.parser.lexparser.LexicalizedParser").init(expandPath("\_java\stanfordnlp\englishPCFG.ser.gz")) />
		<!---
		<cfset var stanfordTreePrint = javaloader.create("edu.stanford.nlp.trees.TreePrint").init("wordsAndTags,penn,typedDependencies") />--->
		
		<cfset var stanfordParserOpts = ["-maxLength",
											"500",
											"-retainTmpSubcategories",
											"-outputFormatOptions",
											"basicDependencies"
										] />
		
		<cfset var stanfordOptsSet = stanfordParser.setOptionFlags(stanfordParserOpts) />
		<cfset var stanfordLangPack  = javaloader.create("edu.stanford.nlp.trees.PennTreebankLanguagePack").init() />
		<cfset var stanfordGramStructFactory = stanfordLangPack.grammaticalStructureFactory() />
		<cfset var stanfordDocProcessor = javaloader.create("edu.stanford.nlp.process.DocumentPreprocessor").init() />
		
		<!--- openNLP --->
		<!--- Models --->
		<cfset var openSentModelInput = javaloader.create("java.io.FileInputStream").init(expandPath("/_java/opennlp/bin/en-sent.bin")) />
		<cfset var openSentModel = javaloader.create("opennlp.tools.sentdetect.SentenceModel").init(openSentModelInput) />
		<cfset var openPosModelInput = javaloader.create("java.io.FileInputStream").init(expandPath("/_java/opennlp/bin/en-pos-maxent.bin")) />
		<cfset var openPosModel = javaloader.create("opennlp.tools.postag.POSModel").init(openPosModelInput) />
		
		<!--- Main Max Enthropy Classes --->
		<cfset var openSentDetector = javaloader.create("opennlp.tools.sentdetect.SentenceDetectorME").init(openSentModel) />
		<cfset var openPosTagger = javaloader.create("opennlp.tools.postag.POSTaggerME").init(openPosModel) />	
		
		<cfset var sentences = openSentDetector.sentDetect(original) />	
		
		<style type="text/css">
			.sentence {     
				background-color: ##F7F7F7;
				border: 1px solid ##999999;
				font-family: Arial;
				font-size: 11px;
				margin: 3px;
				padding: 5px;
				width: 381px;
			}
			.sentenceText {    font-weight: bold; }
			.dep { }
			.dep ul { }
			.dep ul li { }
			
			.original { width:400px; }
			.translated { width:400px; }
			.replaced { font-weight:bold; }
		</style>
		
		<link href="/static/css/blueprint/screen.css" rel="stylesheet" type="text/css" />
		<link href="/static/css/util.css" rel="stylesheet" type="text/css" />
		
		<cfquery name="simpleExcept" dbtype="query">
			SELECT * FROM excepts
			WHERE gramRelate_id = 0 AND posTag_id = 0
		</cfquery>
		
		<cfset sentArray = [] />
		<!--- MATCH / REPLACES --->
		<cfloop from="1" to="#arrayLen(sentences)#" index="i">
			<cfset srSentence = javaloader.create("java.io.StringReader").init(sentences[i]) />
			<cfset stanfordWordTokenFactory = javaloader.create("edu.stanford.nlp.process.WordTokenFactory").init() />
			<cfset stanfordTokenizer = javaloader.create("edu.stanford.nlp.process.PTBTokenizer").factory(false,stanfordWordTokenFactory) />
			
			<cfset parse = stanfordParser.apply(sentences[i]) /><!---
			<cfset tokens = stanfordTokenizer.getTokenizer(srSentence).tokenize() />--->
			<cfset stanfordParser.parse(sentences[i]) />
			<cfset stanfordGramStruct = stanfordGramStructFactory.newGrammaticalStructure(parse) />
			<cfset stanfordDepends = stanfordGramStruct.typedDependenciesCCprocessed() />

			<cfset sentStruct = {
				original = sentences[i],
				tagged = parse.taggedYield().toString(false),
				taggedDelimited  = replace(sentStruct.tagged,' ','|','ALL'),
				translated  = "",
				words = []
			} />
			<cfset taggedWordsArray = listToArray(sentStruct.taggedDelimited,'|') />
			
			<cfloop from="1" to="#arraylen(taggedWordsArray)#" index="e">
				<cfset item = {
								word = listFirst(taggedWordsArray[e],'/'),
								tag = listLast(taggedWordsArray[e],'/'),
								tagInfo = {},
								capitals = REFind('[A-Z+]',item.word,0,true)
							} />
				
				<cfquery name="qTag" dbtype="query">
					SELECT * FROM tags
					WHERE 
						tag = <cfqueryparam value="#item.tag#" cfsqltype="cf_sql_varchar" />
				</cfquery>
				
				<cfset itemData = application.udf.queryToStruct(qTag,1) />
				
				<cfset item.tagInfo = itemData />
				
				<cfset arrayAppend(sentStruct.words,item) />
			</cfloop>
			
			<!--- gramRelations --->
			<cfloop from="1" to="#arrayLen(stanfordDepends)#" index="e">
				<cfset position = listLast(stanfordDepends[e].dep().toString(),'-') />
				<cfquery name="qRelate" dbtype="query">
					SELECT * FROM relations
					WHERE 
						nameShort = <cfqueryparam value="#stanfordDepends[e].reln().toString()#" cfsqltype="cf_sql_varchar" />
				</cfquery>
				<cfset itemData = application.udf.queryToStruct(qRelate,1) />
				
				<cfset sentStruct.words[position].relationInfo = itemData />
				<cfset sentStruct.words[position].relation = stanfordDepends[e].reln().toString() />
			</cfloop>
			
			<!--- TRANSLATE --->
			<cfloop from="1" to="#arrayLen(taggedWordsArray)#" index="e">
					<cfset item = sentStruct.words[e] />
					<cfset strippedWord = stripAllBut(item.word,"a-zA-Z'",false) />
					<cfquery name="qReplacements" dbtype="query">
						SELECT * FROM excepts
						WHERE 
							lower(word) = <cfqueryparam value="#lcase(strippedWord)#" cfsqltype="cf_sql_varchar" />
							<cfif item.tagInfo.ID GT 0>
							AND posTag_id = <cfqueryparam value="#item.tagInfo.ID#" cfsqltype="cf_sql_integer" />
							</cfif>
							OR
							
							lower(word) = <cfqueryparam value="#lcase(strippedWord)#" cfsqltype="cf_sql_varchar" />
							<cfif isDefined("item.relationInfo") AND item.relationInfo.ID GT 0>
							AND gramRelate_id = <cfqueryparam value="#item.relationInfo.ID#" cfsqltype="cf_sql_integer" />
							</cfif>
						ORDER BY [rank] DESC
					</cfquery>
					
					<cfset item.replacements = application.udf.queryToStruct(qReplacements) />
					
					<cfif arrayLen(item.replacements) GT 0>
						<cfset item.chosenReplacement = replaceNoCase(item.word,strippedWord,item.replacements[1].replaceWord) />
					<cfelse>
						<cfset item.chosenReplacement = item.word />
					</cfif>
					<cfif item.capitals['LEN'][1] EQ 1 AND item.capitals['POS'][1] EQ 1>
						<cfset item.chosenReplacement = capFirstList(item.chosenReplacement) />
					</cfif>
					<!---
					<!--- non-3rd person verbs (VBP) --->
					<cfif listFindNoCase("VBP",item.tag)>
						<cfset item.chosenReplacement = item.chosenReplacement & "st" />
					</cfif>--->
					
					<!--- 3rd person (singular) (VBZ) 
					<cfif listFindNoCase("VBZ,VB",item.tag)>
						<cfif right(item.chosenReplacement,1) EQ "e">
							<cfset item.chosenReplacement = item.chosenReplacement & "th" />
						<cfelse>
							<cfset item.chosenReplacement = item.chosenReplacement & "eth" />
						</cfif>
					</cfif>--->
					
					<cfset sentStruct.translated = sentStruct.translated & " " & item.chosenReplacement />
			</cfloop>
			
			<cfloop query="simpleExcept">
				<cfset sentStruct.translated = REreplaceNoCase( sentStruct.translated,"\b#simpleExcept.word#\b"," " & simpleExcept.replaceWord & " ",'all') />
			</cfloop>
			<cfset sentStruct.translated = upperFirst(sentStruct.translated) />
			<cfset arrayAppend(sentArray,sentStruct) />
		</cfloop>
		
		<div class="comparisons clearfix">
			<div class="original mts mrs mls mbs pts pbs pls prs uiBoxGray lfloat">
				<h3>Original</h3>
				<cfloop from="1" to="#arraylen(sentArray)#" index="i">
				<div class="sentence">#sentArray[i].original#</div>
				</cfloop>
			</div>
			<div class="translated mts mrs mls mbs pts pbs pls prs uiBoxGray lfloat">
				<h3>Translated</h3>
				<cfloop from="1" to="#arraylen(sentArray)#" index="i">
				<div class="sentence">#upperFirst(JavaCast('string',sentArray[i].translated))#</div>
				</cfloop>
			</div>
		</div>
		<cfdump var="#sentArray#">
		
		<!---<cfloop from="1" to="#arrayLen(sentences)#" index="i">
			<cfset sentence = sentences[i] />
			<cfdump var="#sentence.toString()#">
			<cfset oSentence = javaloader.create("edu.stanford.nlp.ling.Sentence") />
			
			<cfset oSentence.setWords(sentence) />
			<cfset strSentence = oSentence.toString() />
			
			<cfset parse = lp.apply(sentence) />
			<cfset srSentence = javaloader.create("java.io.StringReader").init(strSentence) />
			<cfset tokens = tf.getTokenizer(srSentence).tokenize() />
			<cfset lp.parse(tokens) />
			<cfset gs = gsf.newGrammaticalStructure(parse) />
			<cfset tdl = gs.typedDependenciesCCprocessed() />
			<cfset tdl = gs.typedDependenciesCCprocessed(true) />
			<cfset aWords = [] />
			tdl = #arrayLen(tdl)#;
			tokens = #arrayLen(tokens)#
			
			<cfloop from="1" to="#arrayLen(tokens)#" index="x">
				<cfset wordStruct = {
								word = tokens[x].word(),
								gramRelate = "",
								replaceWord = ""
								} />
			</cfloop>
			<cfloop from="1" to="#arrayLen(tdl)#" index="e">
				<cfset gramRelateName = tdl[e].reln().toString() />
				<cfset word = tdl[e].dep() />
				<li>
					#word# (#getReplacement(word=ListFirst(word,'-'),gramRelate=gramRelateName)#)
				</li>
			</cfloop>
			<div class="sentence">
				<div class="sentenceText">
					#strSentence#
				</div>
				<div class="words">
					<ul>
						<cfloop from="1" to="#arrayLen(tokens)#" index="x">
						<li>
						#tokens[x].word()#
						</li>
						</cfloop>
					</ul>
				</div>
				<div class="dep">
					<ul>
						<cfloop from="1" to="#arrayLen(tdl)#" index="e">
							<cfset gramRelateName = tdl[e].reln().toString() />
							<cfset word = tdl[e].dep() />
							<li>
								#word# (#getReplacement(word=ListFirst(word,'-'),gramRelate=gramRelateName)#)
							</li>
						</cfloop>
					</ul>
				</div>
			</div>
		</cfloop>--->
		
		
		
	</cffunction>
	<cfscript>
			function stripAllBut(str,strip) {
				var badList = "\";
				var okList = "\\";
				var bCS = true;
			
				if(arrayLen(arguments) gte 3) bCS = arguments[3];
			
				strip = replaceList(strip,badList,okList);
				
				if(bCS) return rereplace(str,"[^#strip#]","","all");
				else return rereplaceNoCase(str,"[^#strip#]","","all");
			}
		</cfscript>
	<cffunction name="addWords" access="remote" output="yes" returnformat="plain">
		<cfargument name="word" type="string" required="yes">
		<cfargument name="definition" type="string" required="yes">
		
		<cfquery name="insert" datasource="#application.settings.dsn#">
			INSERT INTO elizabethan
					   (word
					   ,definition)
				 VALUES
					   (<cfqueryparam value="#arguments.word#" cfsqltype="cf_sql_varchar" />
					   ,<cfqueryparam value="#arguments.definition#" cfsqltype="cf_sql_varchar" />)
		</cfquery>
		
		<cfreturn "success" />
	</cffunction>
	
	<cffunction name="checkWord" access="remote" output="yes" returnformat="plain">
		<cfargument name="word" type="string" required="yes">
		
	</cffunction>
	
	<cffunction name="scraper" access="remote" output="yes">
		<cfset var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
		<cfset var baseUrl = "http://www.elizabethan-era.org.uk/" />
		<cfset var jTidy = createObject("component","_com.jTidy") />
		
		<cfloop from="1" to="1" index="i">
			<cfset letter = mid(letters,i,1) />
			<strong>#letter#</strong><br /><cfflush>
			<cfset filepath = expandPath('\_java\stanfordnlp\elizabethanhtml\letter_#letter#.html') />
			
			<cffile action="read" file="#filepath#" variable="fileread">
			
			<cfset outstr = jTidy.XHTMLParser(fileread,'markup').markup />
			<cfset column1 = XMLParse(outstr).html.body.div.table.tr.td.div.table.tr[2].td.div.table.tr.td.div.table.tr[3].td[1].XMLChildren />
			<cfset column2 = XMLParse(outstr).html.body.div.table.tr.td.div.table.tr[2].td.div.table.tr.td.div.table.tr[3].td[2].XMLChildren />
			
			<cfloop from="1" to="#arrayLen(column1)#" index="i">
				<cfset className = column1[i].XmlAttributes.class />
				
				<cfdump var="#className#">
			</cfloop>
			<cfflush>
		</cfloop>
	</cffunction>
	<!---<cffunction name="scraper" access="remote" output="yes">
		<cfset var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
		<cfset var baseUrl = "http://www.elizabethan-era.org.uk/" />
		<cfset var jTidy = createObject("component","_com.jTidy") />
		<cfloop from="1" to="26" index="i">
			<cfset letter = mid(letters,i,1) />
			<cfset fullUrl = baseUrl & "letter-" & LCase(letter) & ".htm" />
			<strong>#letter# - <a href="#fullUrl#">#fullUrl#</a></strong><br /><cfflush>
			<cfset filepath = expandPath('\_java\stanfordnlp\elizabethanhtml\letter_#letter#.html') />
			<cfif NOT fileExists(filepath)>
				<cfhttp url="#fullUrl#" method="get" result="letterPage" resolveURL="yes" useragent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.2) Gecko/20060308 Firefox/1.5.0.2">
					
				</cfhttp>
				<cfset parsed = jTidy.XHTMLParser(letterPage.fileContent,"content") />
				
				<cfsavecontent variable="pageoutput">
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
					<html xmlns="http://www.w3.org/1999/xhtml">
					<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<title>Elizabethan - Letter #letter#</title>
					</head>
					
					<body>
						#parsed.content#
					</body>
					</html>
				</cfsavecontent>
				
				<cffile action="write" file="#filepath#" output="#pageoutput#">
		</cfif>
			
		</cfloop>
		
		<!--- INSULTS --->
		<cfloop from="1" to="26" index="i">
			<cfset letter = mid(letters,i,1) />
			<cfset fullUrl = baseUrl & "elizabethan-insults-letter-" & LCase(letter) & ".htm" />
			<strong>#letter# - <a href="#fullUrl#">#fullUrl#</a></strong><br /><cfflush>
			<cfset filepath = expandPath('\_java\stanfordnlp\elizabethanhtml\insults_letter_#letter#.html') />
			<cfif NOT fileExists(filepath)>
				<cfhttp url="#fullUrl#" method="get" result="letterPage" resolveURL="yes" useragent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.2) Gecko/20060308 Firefox/1.5.0.2">
					
				</cfhttp>
				<cftry>
					<cfset parsed = jTidy.XHTMLParser(letterPage.fileContent,"content") />
					<cfsavecontent variable="pageoutput">
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
					<html xmlns="http://www.w3.org/1999/xhtml">
					<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<title>Elizabethan - Insults Letter #letter#</title>
					</head>
					
					<body>
						#parsed.content#
					</body>
					</html>
				</cfsavecontent>
				
				<cffile action="write" file="#filepath#" output="#pageoutput#">
					<cfcatch>
					
					</cfcatch>
				</cftry>
				
		</cfif>
			
		</cfloop>
	</cffunction>--->
	
	<cfscript>
/**
* Splits a string according to another string or multiple delimiters.
*
* @param str      String to split. (Required)
* @param splitstr      String to split on. Defaults to a comma. (Optional)
* @param treatsplitstrasstr      If false, splitstr is treated as multiple delimiters, not one string. (Optional)
* @return Returns an array.
* @author Steven Van Gemert (&#115;&#118;&#103;&#50;&#64;&#112;&#108;&#97;&#99;&#115;&#46;&#110;&#101;&#116;)
* @version 3, February 12, 2005
*/
function split(str) {
    var results = arrayNew(1);
    var splitstr = ",";
    var treatsplitstrasstr = true;
    var special_char_list = "\,+,*,?,.,[,],^,$,(,),{,},|,-";
    var esc_special_char_list = "\\,\+,\*,\?,\.,\[,\],\^,\$,\(,\),\{,\},\|,\-";    
    var regex = ",";
    var test = "";
    var pos = 0;
    var oldpos = 1;

    if(ArrayLen(arguments) GTE 2){
        splitstr = arguments[2]; //If a split string was passed, then use it.
    }
    
    regex = ReplaceList(splitstr, special_char_list, esc_special_char_list);
    
    if(ArrayLen(arguments) GTE 3 and isboolean(arguments[3])){
        treatsplitstrasstr = arguments[3]; //If a split string method was passed, then use it.
        if(not treatsplitstrasstr){
            pos = len(splitstr) - 1;
            while(pos GTE 1){
                splitstr = mid(splitstr,1,pos) & "_Separator_" & mid(splitstr,pos+1,len(splitstr) - (pos));
                pos = pos - 1;
            }
            splitstr = ReplaceList(splitstr, special_char_list, esc_special_char_list);
            splitstr = Replace(splitstr, "_Separator_", "|", "ALL");
            regex = splitstr;
        }
    }
    test = REFind(regex,str,1,1);
    pos = test.pos[1];

    if(not pos){
        arrayAppend(results,str);
        return results;
    }

    while(pos gt 0) {
        arrayAppend(results,mid(str,oldpos,pos-oldpos));
        oldpos = pos+test.len[1];
        test = REFind(regex,str,oldpos,1);
        pos = test.pos[1];
    }
    //Thanks to Thomas Muck
    if(len(str) gte oldpos) arrayappend(results,right(str,len(str)-oldpos + 1));

    if(len(str) lt oldpos) arrayappend(results,"");

    return results;
}
</cfscript>
<cffunction name="upperFirst" access="public" returntype="string" output="yes" hint="I convert the first letter of a string to upper case, while leaving the rest of the string alone.">
        <cfargument name="name" type="string" required="true">
		<cfset var returnStr = "" />
		<cfset var origString = Trim(arguments.name) />
		<cfset var firstLetter = uCase(left(origString,1)) />
		<cfset var restOfString = right(origString,len(origString)-1) />
		
		<cfset returnStr = firstLetter & restOfString />
        <cfreturn returnStr>
</cffunction>
<cffunction name="capFirstList" returntype="string" output="false">
<cfargument name="str" type="string" required="true" />
<cfargument name="delimiter" default="," required="false">

<cfset var newstr = "" />
<cfset var word = "" />
<cfset var separator = "" />

<cfloop index="word" list="#arguments.str#" delimiters="#arguments.delimiter#">
<cfset newstr = newstr & separator & UCase(left(word,1)) />
<cfif len(word) gt 1>
<cfset newstr = newstr & right(word,len(word)-1) />
</cfif>
<cfset separator = arguments.delimiter />
</cfloop>

<cfreturn newstr />
</cffunction>
</cfcomponent>