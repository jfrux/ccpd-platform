<cfcomponent displayname="Config > Lists">
	<cffunction name="getAuthLevels" access="public" output="false" returntype="query">
		<cfset var qAuthLevels = queryNew("AuthID,Name,Description","cf_sql_integer,cf_sql_varchar,cf_sql_varchar")>
		<cfset var authlevelsCSV = "">
		<cfsavecontent variable="authlevelsCSV">
    	AuthID,Name,Description
        1,Contributor,Can only edit activities they are attached to
        2,Admin,Can edit all activities under current site
        3,Super Admin,Can edit privileges of users as well as edit all activities under current site
		</cfsavecontent>
		
		<cfset qAuthLevels = CSVtoQuery(authlevelsCSV)>
		
		<cfreturn qAuthLevels />
    </cffunction>
    
    <cffunction name="getOMBEthnicities" access="Public" output="false" returntype="query">
    	<cfset var qOMBEthnicities = queryNew("OMBEthinicityID,Code,Description,ActiveFlag","cf_sql_integer,cf_sql_varchar,cf_sql_varchar,cf_sql_varchar")>
        <cfset var OMBEthnicitiesCSV = "">
        
        <cfsavecontent variable="OMBEthnicitiesCSV">
        	OMBEthnicityID,Code,Description,ActiveFlag
            1,HL+,Hispanic or Latino,Y
            2,HL-,Not Hispanic or Latino,Y
        </cfsavecontent>
        
        <cfset qOMBEthnicities = CSVtoQuery(OMBEthnicitiesCSV)>
        
        <cfreturn qOMBEthnicities />
    </cffunction>
    
	<cffunction name="getStates" access="public" output="no" returntype="query">
		<cfset var qStates = queryNew("StateID,Name,Code","cf_sql_integer,cf_sql_varchar,cf_sql_varchar")>
		<cfset var statesCSV = "">
		<cfsavecontent variable="statesCSV">
		StateID,Name,Code,APAbbrv
		1,Alabama,AL,Ala
		2,Alaska,AK,Alaska
		3,Arizona,AZ,Ariz
		4,Arkansas,AR,Ark
		5,California,CA,Calif
		6,Colorado,CO,Colo
		7,Connecticut,CT,Conn
		8,Delaware,DE,Del
		9,District of Columbia,DC,D.C.
		10,Florida,FL,Fla
		11,Georgia,GA,Ga
		12,Hawaii,HI,Hawaii
		13,Idaho,ID,Idaho
		14,Illinois,IL,Ill
		15,Indiana,IN,Ind
		16,Iowa,IA,Iowa
		17,Kansas,KS,Kan
		18,Kentucky,KY,Ky
		19,Louisiana,LA,La
		20,Maine,ME,Maine
		21,Maryland,MD,Md
		22,Massachusetts,MA,Mass
		23,Michigan,MI,Mich
		24,Minnesota,MN,Minn
		25,Mississippi,MS,Miss
		26,Missouri,MO,Mo
		27,Montana,MT,Mont
		28,Nebraska,NE,Neb
		29,Nevada,NV,Nev
		30,New Hampshire,NH,N.H.
		31,New Jersey,NJ,N.J.
		32,New Mexico,NM,N.M.
		33,New York,NY,N.Y.
		34,North Carolina,NC,N.C.
		35,North Dakota,ND,N.D.
		36,Ohio,OH,Ohio
		37,Oklahoma,OK,Okla
		38,Oregon,OR,Ore
		39,Pennsylvania,PA,Pa
		40,Rhode Island,RI,R.I.
		41,South Carolina,SC,S.C.
		42,South Dakota,SD,S.D.
		43,Tennessee,TN,Tenn
		44,Texas,TX,Texas
		45,Utah,UT,Utah
		46,Vermont,VT,Vt
		47,Virginia,VA,Va
		48,Washington,WA,Wash
		49,West Virginia,WV,W. Va
		50,Wisconsin,WI,Wis
		51,Wyoming,WY,Wyo
		</cfsavecontent>
		
		<cfset qStates = CSVtoQuery(statesCSV)>
		
		<cfreturn qStates />
	</cffunction>
	
	<cffunction name="getCountries" access="public" output="no" returntype="query">
		<cfset var qQuery = "">
		<cfset var CSV = "">
		
		<cfquery name="qQuery" datasource="#application.settings.dsn#">
			SELECT     country.id As CountryId, country.name, country.code, countryDetail.ISO, countryDetail.ISO3, countryDetail.ISOnumeric, countryDetail.fips, countryDetail.country, 
			  countryDetail.capital, countryDetail.area, countryDetail.population, countryDetail.continent, countryDetail.tld, countryDetail.currencyCode, 
			  countryDetail.currencyName, countryDetail.phone, countryDetail.postalCodeFormat, countryDetail.postalCodeRegex, countryDetail.languages, 
			  countryDetail.geonameid, countryDetail.neighbors, countryDetail.equivFipsCode
			FROM         ceschema.ce_Sys_Country AS country INNER JOIN
			  ceschema.geonameCountryInfo AS countryDetail ON country.code = countryDetail.ISO
			 ORDER BY country.name
		</cfquery>
		<!---<cfsavecontent variable="CSV">
		CountryID,Name,FormalName,Type,SubType,Sovereignty,Capital,ISO4217CurrencyCode,ISO4217CurrencyName,ITUTTelephoneCode,ISO316612LetterCode,ISO316613LetterCode,ISO31661Number,IANACountryCodeTLD
		1,Afghanistan,Islamic State of Afghanistan,Independent State,,,Kabul,AFN,Afghani,+93,AF,AFG,004,.af
		2,Albania,Republic of Albania,Independent State,,,Tirana,ALL,Lek,+355,AL,ALB,008,.al
		3,Algeria,People's Democratic Republic of Algeria,Independent State,,,Algiers,DZD,Dinar,+213,DZ,DZA,012,.dz
		4,Andorra,Principality of Andorra,Independent State,,,Andorra la Vella,EUR,Euro,+376,AD,AND,020,.ad
		5,Angola,Republic of Angola,Independent State,,,Luanda,AOA,Kwanza,+244,AO,AGO,024,.ao
		6,Antigua and Barbuda,,Independent State,,,Saint John's,XCD,Dollar,+1-268,AG,ATG,028,.ag
		7,Argentina,Argentine Republic,Independent State,,,Buenos Aires,ARS,Peso,+54,AR,ARG,032,.ar
		8,Armenia,Republic of Armenia,Independent State,,,Yerevan,AMD,Dram,+374,AM,ARM,051,.am
		9,Australia,Commonwealth of Australia,Independent State,,,Canberra,AUD,Dollar,+61,AU,AUS,036,.au
		10,Austria,Republic of Austria,Independent State,,,Vienna,EUR,Euro,+43,AT,AUT,040,.at
		11,Azerbaijan,Republic of Azerbaijan,Independent State,,,Baku,AZN,Manat,+994,AZ,AZE,031,.az
		12,Bahamas, The,Commonwealth of The Bahamas,Independent State,,,Nassau,BSD,Dollar,+1-242,BS,BHS,044,.bs
		13,Bahrain,Kingdom of Bahrain,Independent State,,,Manama,BHD,Dinar,+973,BH,BHR,048,.bh
		14,Bangladesh,People's Republic of Bangladesh,Independent State,,,Dhaka,BDT,Taka,+880,BD,BGD,050,.bd
		15,Barbados,,Independent State,,,Bridgetown,BBD,Dollar,+1-246,BB,BRB,052,.bb
		16,Belarus,Republic of Belarus,Independent State,,,Minsk,BYR,Ruble,+375,BY,BLR,112,.by
		17,Belgium,Kingdom of Belgium,Independent State,,,Brussels,EUR,Euro,+32,BE,BEL,056,.be
		18,Belize,,Independent State,,,Belmopan,BZD,Dollar,+501,BZ,BLZ,084,.bz
		19,Benin,Republic of Benin,Independent State,,,Porto-Novo,XOF,Franc,+229,BJ,BEN,204,.bj
		20,Bhutan,Kingdom of Bhutan,Independent State,,,Thimphu,BTN,Ngultrum,+975,BT,BTN,064,.bt
		21,Bolivia,Republic of Bolivia,Independent State,,,La Paz (administrative/legislative) and Sucre (judical),BOB,Boliviano,+591,BO,BOL,068,.bo
		22,Bosnia and Herzegovina,,Independent State,,,Sarajevo,BAM,Marka,+387,BA,BIH,070,.ba
		23,Botswana,Republic of Botswana,Independent State,,,Gaborone,BWP,Pula,+267,BW,BWA,072,.bw
		24,Brazil,Federative Republic of Brazil,Independent State,,,Brasilia,BRL,Real,+55,BR,BRA,076,.br
		25,Brunei,Negara Brunei Darussalam,Independent State,,,Bandar Seri Begawan,BND,Dollar,+673,BN,BRN,096,.bn
		26,Bulgaria,Republic of Bulgaria,Independent State,,,Sofia,BGN,Lev,+359,BG,BGR,100,.bg
		27,Burkina Faso,,Independent State,,,Ouagadougou,XOF,Franc,+226,BF,BFA,854,.bf
		28,Burundi,Republic of Burundi,Independent State,,,Bujumbura,BIF,Franc,+257,BI,BDI,108,.bi
		29,Cambodia,Kingdom of Cambodia,Independent State,,,Phnom Penh,KHR,Riels,+855,KH,KHM,116,.kh
		30,Cameroon,Republic of Cameroon,Independent State,,,Yaounde,XAF,Franc,+237,CM,CMR,120,.cm
		31,Canada,,Independent State,,,Ottawa,CAD,Dollar,+1,CA,CAN,124,.ca
		32,Cape Verde,Republic of Cape Verde,Independent State,,,Praia,CVE,Escudo,+238,CV,CPV,132,.cv
		33,Central African Republic,,Independent State,,,Bangui,XAF,Franc,+236,CF,CAF,140,.cf
		34,Chad,Republic of Chad,Independent State,,,N'Djamena,XAF,Franc,+235,TD,TCD,148,.td
		35,Chile,Republic of Chile,Independent State,,,Santiago (administrative/judical) and Valparaiso (legislative),CLP,Peso,+56,CL,CHL,152,.cl
		36,China, People's Republic of,People's Republic of China,Independent State,,,Beijing,CNY,Yuan Renminbi,+86,CN,CHN,156,.cn
		37,Colombia,Republic of Colombia,Independent State,,,Bogota,COP,Peso,+57,CO,COL,170,.co
		38,Comoros,Union of Comoros,Independent State,,,Moroni,KMF,Franc,+269,KM,COM,174,.km
		39,Congo, Democratic Republic of the (Congo – Kinshasa),Democratic Republic of the Congo,Independent State,,,Kinshasa,CDF,Franc,+243,CD,COD,180,.cd
		40,Congo, Republic of the (Congo – Brazzaville),Republic of the Congo,Independent State,,,Brazzaville,XAF,Franc,+242,CG,COG,178,.cg
		41,Costa Rica,Republic of Costa Rica,Independent State,,,San Jose,CRC,Colon,+506,CR,CRI,188,.cr
		42,Cote d'Ivoire (Ivory Coast),Republic of Cote d'Ivoire,Independent State,,,Yamoussoukro,XOF,Franc,+225,CI,CIV,384,.ci
		43,Croatia,Republic of Croatia,Independent State,,,Zagreb,HRK,Kuna,+385,HR,HRV,191,.hr
		44,Cuba,Republic of Cuba,Independent State,,,Havana,CUP,Peso,+53,CU,CUB,192,.cu
		45,Cyprus,Republic of Cyprus,Independent State,,,Nicosia,CYP,Pound,+357,CY,CYP,196,.cy
		46,Czech Republic,,Independent State,,,Prague,CZK,Koruna,+420,CZ,CZE,203,.cz
		47,Denmark,Kingdom of Denmark,Independent State,,,Copenhagen,DKK,Krone,+45,DK,DNK,208,.dk
		48,Djibouti,Republic of Djibouti,Independent State,,,Djibouti,DJF,Franc,+253,DJ,DJI,262,.dj
		49,Dominica,Commonwealth of Dominica,Independent State,,,Roseau,XCD,Dollar,+1-767,DM,DMA,212,.dm
		50,Dominican Republic,,Independent State,,,Santo Domingo,DOP,Peso,+1-809 and 1-829,DO,DOM,214,.do
		51,Ecuador,Republic of Ecuador,Independent State,,,Quito,USD,Dollar,+593,EC,ECU,218,.ec
		52,Egypt,Arab Republic of Egypt,Independent State,,,Cairo,EGP,Pound,+20,EG,EGY,818,.eg
		53,El Salvador,Republic of El Salvador,Independent State,,,San Salvador,USD,Dollar,+503,SV,SLV,222,.sv
		54,Equatorial Guinea,Republic of Equatorial Guinea,Independent State,,,Malabo,XAF,Franc,+240,GQ,GNQ,226,.gq
		55,Eritrea,State of Eritrea,Independent State,,,Asmara,ERN,Nakfa,+291,ER,ERI,232,.er
		56,Estonia,Republic of Estonia,Independent State,,,Tallinn,EEK,Kroon,+372,EE,EST,233,.ee
		57,Ethiopia,Federal Democratic Republic of Ethiopia,Independent State,,,Addis Ababa,ETB,Birr,+251,ET,ETH,231,.et
		58,Fiji,Republic of the Fiji Islands,Independent State,,,Suva,FJD,Dollar,+679,FJ,FJI,242,.fj
		59,Finland,Republic of Finland,Independent State,,,Helsinki,EUR,Euro,+358,FI,FIN,246,.fi
		60,France,French Republic,Independent State,,,Paris,EUR,Euro,+33,FR,FRA,250,.fr
		61,Gabon,Gabonese Republic,Independent State,,,Libreville,XAF,Franc,+241,GA,GAB,266,.ga
		62,Gambia, The,Republic of The Gambia,Independent State,,,Banjul,GMD,Dalasi,+220,GM,GMB,270,.gm
		63,Georgia,Republic of Georgia,Independent State,,,Tbilisi,GEL,Lari,+995,GE,GEO,268,.ge
		64,Germany,Federal Republic of Germany,Independent State,,,Berlin,EUR,Euro,+49,DE,DEU,276,.de
		65,Ghana,Republic of Ghana,Independent State,,,Accra,GHS,Cedi,+233,GH,GHA,288,.gh
		66,Greece,Hellenic Republic,Independent State,,,Athens,EUR,Euro,+30,GR,GRC,300,.gr
		67,Grenada,,Independent State,,,Saint George's,XCD,Dollar,+1-473,GD,GRD,308,.gd
		68,Guatemala,Republic of Guatemala,Independent State,,,Guatemala,GTQ,Quetzal,+502,GT,GTM,320,.gt
		69,Guinea,Republic of Guinea,Independent State,,,Conakry,GNF,Franc,+224,GN,GIN,324,.gn
		70,Guinea-Bissau,Republic of Guinea-Bissau,Independent State,,,Bissau,XOF,Franc,+245,GW,GNB,624,.gw
		71,Guyana,Co-operative Republic of Guyana,Independent State,,,Georgetown,GYD,Dollar,+592,GY,GUY,328,.gy
		72,Haiti,Republic of Haiti,Independent State,,,Port-au-Prince,HTG,Gourde,+509,HT,HTI,332,.ht
		73,Honduras,Republic of Honduras,Independent State,,,Tegucigalpa,HNL,Lempira,+504,HN,HND,340,.hn
		74,Hungary,Republic of Hungary,Independent State,,,Budapest,HUF,Forint,+36,HU,HUN,348,.hu
		75,Iceland,Republic of Iceland,Independent State,,,Reykjavik,ISK,Krona,+354,IS,ISL,352,.is
		76,India,Republic of India,Independent State,,,New Delhi,INR,Rupee,+91,IN,IND,356,.in
		77,Indonesia,Republic of Indonesia,Independent State,,,Jakarta,IDR,Rupiah,+62,ID,IDN,360,.id
		78,Iran,Islamic Republic of Iran,Independent State,,,Tehran,IRR,Rial,+98,IR,IRN,364,.ir
		79,Iraq,Republic of Iraq,Independent State,,,Baghdad,IQD,Dinar,+964,IQ,IRQ,368,.iq
		80,Ireland,,Independent State,,,Dublin,EUR,Euro,+353,IE,IRL,372,.ie
		81,Israel,State of Israel,Independent State,,,Jerusalem,ILS,Shekel,+972,IL,ISR,376,.il
		82,Italy,Italian Republic,Independent State,,,Rome,EUR,Euro,+39,IT,ITA,380,.it
		83,Jamaica,,Independent State,,,Kingston,JMD,Dollar,+1-876,JM,JAM,388,.jm
		84,Japan,,Independent State,,,Tokyo,JPY,Yen,+81,JP,JPN,392,.jp
		85,Jordan,Hashemite Kingdom of Jordan,Independent State,,,Amman,JOD,Dinar,+962,JO,JOR,400,.jo
		86,Kazakhstan,Republic of Kazakhstan,Independent State,,,Astana,KZT,Tenge,+7,KZ,KAZ,398,.kz
		87,Kenya,Republic of Kenya,Independent State,,,Nairobi,KES,Shilling,+254,KE,KEN,404,.ke
		88,Kiribati,Republic of Kiribati,Independent State,,,Tarawa,AUD,Dollar,+686,KI,KIR,296,.ki
		89,Korea, Democratic People's Republic of (North Korea),Democratic People's Republic of Korea,Independent State,,,Pyongyang,KPW,Won,+850,KP,PRK,408,.kp
		90,Korea, Republic of  (South Korea),Republic of Korea,Independent State,,,Seoul,KRW,Won,+82,KR,KOR,410,.kr
		91,Kuwait,State of Kuwait,Independent State,,,Kuwait,KWD,Dinar,+965,KW,KWT,414,.kw
		92,Kyrgyzstan,Kyrgyz Republic,Independent State,,,Bishkek,KGS,Som,+996,KG,KGZ,417,.kg
		93,Laos,Lao People's Democratic Republic,Independent State,,,Vientiane,LAK,Kip,+856,LA,LAO,418,.la
		94,Latvia,Republic of Latvia,Independent State,,,Riga,LVL,Lat,+371,LV,LVA,428,.lv
		95,Lebanon,Lebanese Republic,Independent State,,,Beirut,LBP,Pound,+961,LB,LBN,422,.lb
		96,Lesotho,Kingdom of Lesotho,Independent State,,,Maseru,LSL,Loti,+266,LS,LSO,426,.ls
		97,Liberia,Republic of Liberia,Independent State,,,Monrovia,LRD,Dollar,+231,LR,LBR,430,.lr
		98,Libya,Great Socialist People's Libyan Arab Jamahiriya,Independent State,,,Tripoli,LYD,Dinar,+218,LY,LBY,434,.ly
		99,Liechtenstein,Principality of Liechtenstein,Independent State,,,Vaduz,CHF,Franc,+423,LI,LIE,438,.li
		100,Lithuania,Republic of Lithuania,Independent State,,,Vilnius,LTL,Litas,+370,LT,LTU,440,.lt
		101,Luxembourg,Grand Duchy of Luxembourg,Independent State,,,Luxembourg,EUR,Euro,+352,LU,LUX,442,.lu
		102,Macedonia,Republic of Macedonia,Independent State,,,Skopje,MKD,Denar,+389,MK,MKD,807,.mk
		103,Madagascar,Republic of Madagascar,Independent State,,,Antananarivo,MGA,Ariary,+261,MG,MDG,450,.mg
		104,Malawi,Republic of Malawi,Independent State,,,Lilongwe,MWK,Kwacha,+265,MW,MWI,454,.mw
		105,Malaysia,,Independent State,,,Kuala Lumpur (legislative/judical) and Putrajaya (administrative),MYR,Ringgit,+60,MY,MYS,458,.my
		106,Maldives,Republic of Maldives,Independent State,,,Male,MVR,Rufiyaa,+960,MV,MDV,462,.mv
		107,Mali,Republic of Mali,Independent State,,,Bamako,XOF,Franc,+223,ML,MLI,466,.ml
		108,Malta,Republic of Malta,Independent State,,,Valletta,MTL,Lira,+356,MT,MLT,470,.mt
		109,Marshall Islands,Republic of the Marshall Islands,Independent State,,,Majuro,USD,Dollar,+692,MH,MHL,584,.mh
		110,Mauritania,Islamic Republic of Mauritania,Independent State,,,Nouakchott,MRO,Ouguiya,+222,MR,MRT,478,.mr
		111,Mauritius,Republic of Mauritius,Independent State,,,Port Louis,MUR,Rupee,+230,MU,MUS,480,.mu
		112,Mexico,United Mexican States,Independent State,,,Mexico,MXN,Peso,+52,MX,MEX,484,.mx
		113,Micronesia,Federated States of Micronesia,Independent State,,,Palikir,USD,Dollar,+691,FM,FSM,583,.fm
		114,Moldova,Republic of Moldova,Independent State,,,Chisinau,MDL,Leu,+373,MD,MDA,498,.md
		115,Monaco,Principality of Monaco,Independent State,,,Monaco,EUR,Euro,+377,MC,MCO,492,.mc
		116,Mongolia,,Independent State,,,Ulaanbaatar,MNT,Tugrik,+976,MN,MNG,496,.mn
		117,Montenegro,Republic of Montenegro,Independent State,,,Podgorica,EUR,Euro,+382,ME,MNE,499,.me and .yu
		118,Morocco,Kingdom of Morocco,Independent State,,,Rabat,MAD,Dirham,+212,MA,MAR,504,.ma
		119,Mozambique,Republic of Mozambique,Independent State,,,Maputo,MZM,Meticail,+258,MZ,MOZ,508,.mz
		120,Myanmar (Burma),Union of Myanmar,Independent State,,,Naypyidaw,MMK,Kyat,+95,MM,MMR,104,.mm
		121,Namibia,Republic of Namibia,Independent State,,,Windhoek,NAD,Dollar,+264,NA,NAM,516,.na
		122,Nauru,Republic of Nauru,Independent State,,,Yaren,AUD,Dollar,+674,NR,NRU,520,.nr
		123,Nepal,,Independent State,,,Kathmandu,NPR,Rupee,+977,NP,NPL,524,.np
		124,Netherlands,Kingdom of the Netherlands,Independent State,,,Amsterdam (administrative) and The Hague (legislative/judical),EUR,Euro,+31,NL,NLD,528,.nl
		125,New Zealand,,Independent State,,,Wellington,NZD,Dollar,+64,NZ,NZL,554,.nz
		126,Nicaragua,Republic of Nicaragua,Independent State,,,Managua,NIO,Cordoba,+505,NI,NIC,558,.ni
		127,Niger,Republic of Niger,Independent State,,,Niamey,XOF,Franc,+227,NE,NER,562,.ne
		128,Nigeria,Federal Republic of Nigeria,Independent State,,,Abuja,NGN,Naira,+234,NG,NGA,566,.ng
		129,Norway,Kingdom of Norway,Independent State,,,Oslo,NOK,Krone,+47,NO,NOR,578,.no
		130,Oman,Sultanate of Oman,Independent State,,,Muscat,OMR,Rial,+968,OM,OMN,512,.om
		131,Pakistan,Islamic Republic of Pakistan,Independent State,,,Islamabad,PKR,Rupee,+92,PK,PAK,586,.pk
		132,Palau,Republic of Palau,Independent State,,,Melekeok,USD,Dollar,+680,PW,PLW,585,.pw
		133,Panama,Republic of Panama,Independent State,,,Panama,PAB,Balboa,+507,PA,PAN,591,.pa
		134,Papua New Guinea,Independent State of Papua New Guinea,Independent State,,,Port Moresby,PGK,Kina,+675,PG,PNG,598,.pg
		135,Paraguay,Republic of Paraguay,Independent State,,,Asuncion,PYG,Guarani,+595,PY,PRY,600,.py
		136,Peru,Republic of Peru,Independent State,,,Lima,PEN,Sol,+51,PE,PER,604,.pe
		137,Philippines,Republic of the Philippines,Independent State,,,Manila,PHP,Peso,+63,PH,PHL,608,.ph
		138,Poland,Republic of Poland,Independent State,,,Warsaw,PLN,Zloty,+48,PL,POL,616,.pl
		139,Portugal,Portuguese Republic,Independent State,,,Lisbon,EUR,Euro,+351,PT,PRT,620,.pt
		140,Qatar,State of Qatar,Independent State,,,Doha,QAR,Rial,+974,QA,QAT,634,.qa
		141,Romania,,Independent State,,,Bucharest,RON,Leu,+40,RO,ROU,642,.ro
		142,Russia,Russian Federation,Independent State,,,Moscow,RUB,Ruble,+7,RU,RUS,643,.ru and .su
		143,Rwanda,Republic of Rwanda,Independent State,,,Kigali,RWF,Franc,+250,RW,RWA,646,.rw
		144,Saint Kitts and Nevis,Federation of Saint Kitts and Nevis,Independent State,,,Basseterre,XCD,Dollar,+1-869,KN,KNA,659,.kn
		145,Saint Lucia,,Independent State,,,Castries,XCD,Dollar,+1-758,LC,LCA,662,.lc
		146,Saint Vincent and the Grenadines,,Independent State,,,Kingstown,XCD,Dollar,+1-784,VC,VCT,670,.vc
		147,Samoa,Independent State of Samoa,Independent State,,,Apia,WST,Tala,+685,WS,WSM,882,.ws
		148,San Marino,Republic of San Marino,Independent State,,,San Marino,EUR,Euro,+378,SM,SMR,674,.sm
		149,Sao Tome and Principe,Democratic Republic of Sao Tome and Principe,Independent State,,,Sao Tome,STD,Dobra,+239,ST,STP,678,.st
		150,Saudi Arabia,Kingdom of Saudi Arabia,Independent State,,,Riyadh,SAR,Rial,+966,SA,SAU,682,.sa
		151,Senegal,Republic of Senegal,Independent State,,,Dakar,XOF,Franc,+221,SN,SEN,686,.sn
		152,Serbia,Republic of Serbia,Independent State,,,Belgrade,RSD,Dinar,+381,RS,SRB,688,.rs and .yu
		153,Seychelles,Republic of Seychelles,Independent State,,,Victoria,SCR,Rupee,+248,SC,SYC,690,.sc
		154,Sierra Leone,Republic of Sierra Leone,Independent State,,,Freetown,SLL,Leone,+232,SL,SLE,694,.sl
		155,Singapore,Republic of Singapore,Independent State,,,Singapore,SGD,Dollar,+65,SG,SGP,702,.sg
		156,Slovakia,Slovak Republic,Independent State,,,Bratislava,SKK,Koruna,+421,SK,SVK,703,.sk
		157,Slovenia,Republic of Slovenia,Independent State,,,Ljubljana,EUR,Euro,+386,SI,SVN,705,.si
		158,Solomon Islands,,Independent State,,,Honiara,SBD,Dollar,+677,SB,SLB,090,.sb
		159,Somalia,,Independent State,,,Mogadishu,SOS,Shilling,+252,SO,SOM,706,.so
		160,South Africa,Republic of South Africa,Independent State,,,Pretoria (administrative), Cape Town (legislative), and Bloemfontein (judical),ZAR,Rand,+27,ZA,ZAF,710,.za
		161,Spain,Kingdom of Spain,Independent State,,,Madrid,EUR,Euro,+34,ES,ESP,724,.es
		162,Sri Lanka,Democratic Socialist Republic of Sri Lanka,Independent State,,,Colombo (administrative/judical) and Sri Jayewardenepura Kotte (legislative),LKR,Rupee,+94,LK,LKA,144,.lk
		163,Sudan,Republic of the Sudan,Independent State,,,Khartoum,SDG,Pound,+249,SD,SDN,736,.sd
		164,Suriname,Republic of Suriname,Independent State,,,Paramaribo,SRD,Dollar,+597,SR,SUR,740,.sr
		165,Swaziland,Kingdom of Swaziland,Independent State,,,Mbabane (administrative) and Lobamba (legislative),SZL,Lilangeni,+268,SZ,SWZ,748,.sz
		166,Sweden,Kingdom of Sweden,Independent State,,,Stockholm,SEK,Kronoa,+46,SE,SWE,752,.se
		167,Switzerland,Swiss Confederation,Independent State,,,Bern,CHF,Franc,+41,CH,CHE,756,.ch
		168,Syria,Syrian Arab Republic,Independent State,,,Damascus,SYP,Pound,+963,SY,SYR,760,.sy
		169,Tajikistan,Republic of Tajikistan,Independent State,,,Dushanbe,TJS,Somoni,+992,TJ,TJK,762,.tj
		170,Tanzania,United Republic of Tanzania,Independent State,,,Dar es Salaam (administrative/judical) and Dodoma (legislative),TZS,Shilling,+255,TZ,TZA,834,.tz
		171,Thailand,Kingdom of Thailand,Independent State,,,Bangkok,THB,Baht,+66,TH,THA,764,.th
		172,Timor-Leste (East Timor),Democratic Republic of Timor-Leste,Independent State,,,Dili,USD,Dollar,+670,TL,TLS,626,.tp and .tl
		173,Togo,Togolese Republic,Independent State,,,Lome,XOF,Franc,+228,TG,TGO,768,.tg
		174,Tonga,Kingdom of Tonga,Independent State,,,Nuku'alofa,TOP,Pa'anga,+676,TO,TON,776,.to
		175,Trinidad and Tobago,Republic of Trinidad and Tobago,Independent State,,,Port-of-Spain,TTD,Dollar,+1-868,TT,TTO,780,.tt
		176,Tunisia,Tunisian Republic,Independent State,,,Tunis,TND,Dinar,+216,TN,TUN,788,.tn
		177,Turkey,Republic of Turkey,Independent State,,,Ankara,TRY,Lira,+90,TR,TUR,792,.tr
		178,Turkmenistan,,Independent State,,,Ashgabat,TMM,Manat,+993,TM,TKM,795,.tm
		179,Tuvalu,,Independent State,,,Funafuti,AUD,Dollar,+688,TV,TUV,798,.tv
		180,Uganda,Republic of Uganda,Independent State,,,Kampala,UGX,Shilling,+256,UG,UGA,800,.ug
		181,Ukraine,,Independent State,,,Kiev,UAH,Hryvnia,+380,UA,UKR,804,.ua
		182,United Arab Emirates,United Arab Emirates,Independent State,,,Abu Dhabi,AED,Dirham,+971,AE,ARE,784,.ae
		183,United Kingdom,United Kingdom of Great Britain and Northern Ireland,Independent State,,,London,GBP,Pound,+44,GB,GBR,826,.uk
		184,United States of America,United States of America,Independent State,,,Washington,USD,Dollar,+1,US,USA,840,.us
		185,Uruguay,Oriental Republic of Uruguay,Independent State,,,Montevideo,UYU,Peso,+598,UY,URY,858,.uy
		186,Uzbekistan,Republic of Uzbekistan,Independent State,,,Tashkent,UZS,Som,+998,UZ,UZB,860,.uz
		187,Vanuatu,Republic of Vanuatu,Independent State,,,Port-Vila,VUV,Vatu,+678,VU,VUT,548,.vu
		188,Vatican City,State of the Vatican City,Independent State,,,Vatican City,EUR,Euro,+379,VA,VAT,336,.va
		189,Venezuela,Bolivarian Republic of Venezuela,Independent State,,,Caracas,VEB,Bolivar,+58,VE,VEN,862,.ve
		190,Vietnam,Socialist Republic of Vietnam,Independent State,,,Hanoi,VND,Dong,+84,VN,VNM,704,.vn
		191,Yemen,Republic of Yemen,Independent State,,,Sanaa,YER,Rial,+967,YE,YEM,887,.ye
		192,Zambia,Republic of Zambia,Independent State,,,Lusaka,ZMK,Kwacha,+260,ZM,ZMB,894,.zm
		193,Zimbabwe,Republic of Zimbabwe,Independent State,,,Harare,ZWD,Dollar,+263,ZW,ZWE,716,.zw
		194,Abkhazia,Republic of Abkhazia,Proto Independent State,,,Sokhumi,RUB,Ruble,+995,GE,GEO,268,.ge
		195,China, Republic of (Taiwan),Republic of China,Proto Independent State,,,Taipei,TWD,Dollar,+886,TW,TWN,158,.tw
		196,Nagorno-Karabakh,Nagorno-Karabakh Republic,Proto Independent State,,,Stepanakert,AMD,Dram,+374-97,AZ,AZE,031,.az
		197,Northern Cyprus,Turkish Republic of Northern Cyprus,Proto Independent State,,,Nicosia,TRY,Lira,+90-392,CY,CYP,196,.nc.tr
		198,Pridnestrovie (Transnistria),Pridnestrovian Moldavian Republic,Proto Independent State,,,Tiraspol,,Ruple,+373-533,MD,MDA,498,.md
		199,Somaliland,Republic of Somaliland,Proto Independent State,,,Hargeisa,,Shilling,+252,SO,SOM,706,.so
		200,South Ossetia,Republic of South Ossetia,Proto Independent State,,,Tskhinvali,RUB and GEL,Ruble and Lari,+995,GE,GEO,268,.ge
		201,Ashmore and Cartier Islands,Territory of Ashmore and Cartier Islands,Dependency,External Territory,Australia,,,,,AU,AUS,036,.au
		202,Christmas Island,Territory of Christmas Island,Dependency,External Territory,Australia,The Settlement (Flying Fish Cove),AUD,Dollar,+61,CX,CXR,162,.cx
		203,Cocos (Keeling) Islands,Territory of Cocos (Keeling) Islands,Dependency,External Territory,Australia,West Island,AUD,Dollar,+61,CC,CCK,166,.cc
		204,Coral Sea Islands,Coral Sea Islands Territory,Dependency,External Territory,Australia,,,,,AU,AUS,036,.au
		205,Heard Island and McDonald Islands,Territory of Heard Island and McDonald Islands,Dependency,External Territory,Australia,,,,,HM,HMD,334,.hm
		206,Norfolk Island,Territory of Norfolk Island,Dependency,External Territory,Australia,Kingston,AUD,Dollar,+672,NF,NFK,574,.nf
		207,New Caledonia,,Dependency,Sui generis Collectivity,France,Noumea,XPF,Franc,+687,NC,NCL,540,.nc
		208,French Polynesia,Overseas Country of French Polynesia,Dependency,Overseas Collectivity,France,Papeete,XPF,Franc,+689,PF,PYF,258,.pf
		209,Mayotte,Departmental Collectivity of Mayotte,Dependency,Overseas Collectivity,France,Mamoudzou,EUR,Euro,+262,YT,MYT,175,.yt
		210,Saint Barthelemy,Collectivity of Saint Barthelemy,Dependency,Overseas Collectivity,France,Gustavia,EUR,Euro,+590,GP,GLP,312,.gp
		211,Saint Martin,Collectivity of Saint Martin,Dependency,Overseas Collectivity,France,Marigot,EUR,Euro,+590,GP,GLP,312,.gp
		212,Saint Pierre and Miquelon,Territorial Collectivity of Saint Pierre and Miquelon,Dependency,Overseas Collectivity,France,Saint-Pierre,EUR,Euro,+508,PM,SPM,666,.pm
		213,Wallis and Futuna,Collectivity of the Wallis and Futuna Islands,Dependency,Overseas Collectivity,France,Mata'utu,XPF,Franc,+681,WF,WLF,876,.wf
		214,French Southern and Antarctic Lands,Territory of the French Southern and Antarctic Lands,Dependency,Overseas Territory,France,Martin-de-Viviès,,,,TF,ATF,260,.tf
		215,Clipperton Island,,Dependency,Possession,France,,,,,PF,PYF,258,.pf
		216,Bouvet Island,,Dependency,Territory,Norway,,,,,BV,BVT,074,.bv
		217,Cook Islands,,Dependency,Self-Governing in Free Association,New Zealand,Avarua,NZD,Dollar,+682,CK,COK,184,.ck
		218,Niue,,Dependency,Self-Governing in Free Association,New Zealand,Alofi,NZD,Dollar,+683,NU,NIU,570,.nu
		219,Tokelau,,Dependency,Territory,New Zealand,,NZD,Dollar,+690,TK,TKL,772,.tk
		220,Guernsey,Bailiwick of Guernsey,Dependency,Crown Dependency,United Kingdom,Saint Peter Port,GGP,Pound,+44,GG,GGY,831,.gg
		221,Isle of Man,,Dependency,Crown Dependency,United Kingdom,Douglas,IMP,Pound,+44,IM,IMN,833,.im
		222,Jersey,Bailiwick of Jersey,Dependency,Crown Dependency,United Kingdom,Saint Helier,JEP,Pound,+44,JE,JEY,832,.je
		223,Anguilla,,Dependency,Overseas Territory,United Kingdom,The Valley,XCD,Dollar,+1-264,AI,AIA,660,.ai
		224,Bermuda,,Dependency,Overseas Territory,United Kingdom,Hamilton,BMD,Dollar,+1-441,BM,BMU,060,.bm
		225,British Indian Ocean Territory,,Dependency,Overseas Territory,United Kingdom,,,,+246,IO,IOT,086,.io
		226,British Sovereign Base Areas,,Dependency,Overseas Territory,United Kingdom,Episkopi,CYP,Pound,+357,,,,
		227,British Virgin Islands,,Dependency,Overseas Territory,United Kingdom,Road Town,USD,Dollar,+1-284,VG,VGB,092,.vg
		228,Cayman Islands,,Dependency,Overseas Territory,United Kingdom,George Town,KYD,Dollar,+1-345,KY,CYM,136,.ky
		229,Falkland Islands (Islas Malvinas),,Dependency,Overseas Territory,United Kingdom,Stanley,FKP,Pound,+500,FK,FLK,238,.fk
		230,Gibraltar,,Dependency,Overseas Territory,United Kingdom,Gibraltar,GIP,Pound,+350,GI,GIB,292,.gi
		231,Montserrat,,Dependency,Overseas Territory,United Kingdom,Plymouth,XCD,Dollar,+1-664,MS,MSR,500,.ms
		232,Pitcairn Islands,,Dependency,Overseas Territory,United Kingdom,Adamstown,NZD,Dollar,,PN,PCN,612,.pn
		233,Saint Helena,,Dependency,Overseas Territory,United Kingdom,Jamestown,SHP,Pound,+290,SH,SHN,654,.sh
		234,South Georgia and the South Sandwich Islands,,Dependency,Overseas Territory,United Kingdom,,,,,GS,SGS,239,.gs
		235,Turks and Caicos Islands,,Dependency,Overseas Territory,United Kingdom,Grand Turk,USD,Dollar,+1-649,TC,TCA,796,.tc
		236,Northern Mariana Islands,Commonwealth of The Northern Mariana Islands,Dependency,Commonwealth,United States,Saipan,USD,Dollar,+1-670,MP,MNP,580,.mp
		237,Puerto Rico,Commonwealth of Puerto Rico,Dependency,Commonwealth,United States,San Juan,USD,Dollar,+1-787 and 1-939,PR,PRI,630,.pr
		238,American Samoa,Territory of American Samoa,Dependency,Territory,United States,Pago Pago,USD,Dollar,+1-684,AS,ASM,016,.as
		239,Baker Island,,Dependency,Territory,United States,,,,,UM,UMI,581,
		240,Guam,Territory of Guam,Dependency,Territory,United States,Hagatna,USD,Dollar,+1-671,GU,GUM,316,.gu
		241,Howland Island,,Dependency,Territory,United States,,,,,UM,UMI,581,
		242,Jarvis Island,,Dependency,Territory,United States,,,,,UM,UMI,581,
		243,Johnston Atoll,,Dependency,Territory,United States,,,,,UM,UMI,581,
		244,Kingman Reef,,Dependency,Territory,United States,,,,,UM,UMI,581,
		245,Midway Islands,,Dependency,Territory,United States,,,,,UM,UMI,581,
		246,Navassa Island,,Dependency,Territory,United States,,,,,UM,UMI,581,
		247,Palmyra Atoll,,Dependency,Territory,United States,,,,,UM,UMI,581,
		248,U.S. Virgin Islands,United States Virgin Islands,Dependency,Territory,United States,Charlotte Amalie,USD,Dollar,+1-340,VI,VIR,850,.vi
		249,Wake Island,,Dependency,Territory,United States,,,,,UM,UMI,850,
		250,Hong Kong,Hong Kong Special Administrative Region,Proto Dependency,Special Administrative Region,China,,HKD,Dollar,+852,HK,HKG,344,.hk
		251,Macau,Macau Special Administrative Region,Proto Dependency,Special Administrative Region,China,Macau,MOP,Pataca,+853,MO,MAC,446,.mo
		252,Faroe Islands,,Proto Dependency,,Denmark,Torshavn,DKK,Krone,+298,FO,FRO,234,.fo
		253,Greenland,,Proto Dependency,,Denmark,Nuuk (Godthab),DKK,Krone,+299,GL,GRL,304,.gl
		254,French Guiana,Overseas Region of Guiana,Proto Dependency,Overseas Region,France,Cayenne,EUR,Euro,+594,GF,GUF,254,.gf
		255,Guadeloupe,Overseas Region of Guadeloupe,Proto Dependency,Overseas Region,France,Basse-Terre,EUR,Euro,+590,GP,GLP,312,.gp
		256,Martinique,Overseas Region of Martinique,Proto Dependency,Overseas Region,France,Fort-de-France,EUR,Euro,+596,MQ,MTQ,474,.mq
		257,Reunion,Overseas Region of Reunion,Proto Dependency,Overseas Region,France,Saint-Denis,EUR,Euro,+262,RE,REU,638,.re
		258,Aland,,Proto Dependency,,Finland,Mariehamn,EUR,Euro,+358-18,AX,ALA,248,.ax
		259,Aruba,,Proto Dependency,,Netherlands,Oranjestad,AWG,Guilder,+297,AW,ABW,533,.aw
		260,Netherlands Antilles,,Proto Dependency,,Netherlands,Willemstad,ANG,Guilder,+599,AN,ANT,530,.an
		261,Svalbard,,Proto Dependency,,Norway,Longyearbyen,NOK,Krone,+47,SJ,SJM,744,.sj
		262,Ascension,,Proto Dependency,Dependency of Saint Helena,United Kingdom,Georgetown,SHP,Pound,+247,AC,ASC,,.ac
		263,Tristan da Cunha,,Proto Dependency,Dependency of Saint Helena,United Kingdom,Edinburgh,SHP,Pound,+290,TA,TAA,,
		264,Antarctica,,Disputed Territory,,Undetermined,,,,,AQ,ATA,010,.aq
		265,Kosovo,,Disputed Territory,,Administrated by the UN,Pristina,CSD and EUR,Dinar and Euro,+381,CS,SCG,891,.cs and .yu
		266,Palestinian Territories (Gaza Strip and West Bank),,Disputed Territory,,Administrated by Israel,Gaza City (Gaza Strip) and Ramallah (West Bank),ILS,Shekel,+970,PS,PSE,275,.ps
		267,Western Sahara,,Disputed Territory,,Administrated by Morocco,El-Aaiun,MAD,Dirham,+212,EH,ESH,732,.eh
		268,Australian Antarctic Territory,,Antarctic Territory,External Territory,Australia,,,,,AQ,ATA,010,.aq
		269,Ross Dependency,,Antarctic Territory,Territory,New Zealand,,,,,AQ,ATA,010,.aq
		270,Peter I Island,,Antarctic Territory,Territory,Norway,,,,,AQ,ATA,010,.aq
		271,Queen Maud Land,,Antarctic Territory,Territory,Norway,,,,,AQ,ATA,010,.aq
		272,British Antarctic Territory,,Antarctic Territory,Overseas Territory,United Kingdom,,,,,AQ,ATA,010,.aq
		</cfsavecontent>
		
		<cfset qQuery = CSVtoQuery(CSV)>--->
        
		<cfreturn qQuery />
	</cffunction>
	
	<cffunction name="getHistoryStyles" access="public" output="no" returntype="query">
		<cfquery name="qNewStyle" datasource="#Application.Settings.DSN#">
			SELECT HistoryStyleID,Title,OldTitles
			FROM ce_Sys_HistoryStyle
			ORDER BY Title
		</cfquery>
		
		<cfreturn qNewStyle />
	</cffunction>
	
	<cffunction name="getActivityTypes" access="public" output="no" returntype="query">
		<cfquery name="qActivityTypes" datasource="#Application.Settings.DSN#">
			SELECT     ActivityTypeID, Name, Description, Code, Created, Updated, Deleted, DeletedFlag
			FROM         ceschema.ce_Sys_ActivityType
			ORDER BY Code
		</cfquery>
		
		<cfreturn qActivityTypes />
	</cffunction>
	
	<cffunction name="getGroupings" access="public" output="no" returntype="query">
		<cfquery name="qGroupings" datasource="#Application.Settings.DSN#">
			SELECT     GroupingID, ActivityTypeID, Name, Created
			FROM         ceschema.ce_Sys_Grouping
			ORDER BY GroupingID
		</cfquery>
		
		<cfreturn qGroupings />
	</cffunction>
	
	<cffunction name="getNoiseWords" access="public" output="no" returntype="string">
		
		<cfset var sOutput = "">
		<cffile action="read" file="#ExpandPath('/_com/noiseENU.txt')#" variable="test" />
		<cfset sOutput = Replace(Replace(test,' ',',','ALL'),chr(13)&chr(10),',','ALL')>
		
		<cfreturn sOutput />
	</cffunction>
	
	<cfinclude template="/_com/_UDF/CSVtoQuery.cfm" />
</cfcomponent>