<cfcomponent>
  <cffunction name="run" access="remote">
    <cfset var emails = "rcole@dch.org,speerba@ucmail.uc.edu,rountrjf@ucmail.uc.edu,forneyba@uc.edu,tylersn@uc.edu,mary.gallo@uc.edu,coledr@uc.edu,levikl@ucmail.uc.edu,lglick@dch.org,rzemek@yahoo.com,christine.sullivan@tmcmed.org,mark.steele@tmcmed.org,sarah_fabiano@urmc.rochester.edu,bogdanvr@ucmail.uc.edu,eli73@aol.com,lise.nigrovic@childrens.harvard.edu,daniel.nishijima@ucdmc.ucdavis.edu,nicknicholson@sbcglobal.net,bhassiem@ucmail.uc.edu,kate.cox-scheben@stelizabeth.com,lyonsme@ucmail.uc.edu,zinzuwsh@yahoo.com,joanne.oakes@uth.tmc.edu,apanchal@aemrc.arizona.edu,sschneider@acep.org,gorbelyan@gmail.com,palascje@ucmail.uc.edu,ronanse@ucmail.uc.edu,peterfarr.md@gmail.com,physicianexec@gmail.com,vagt@stanford.edu,richard.nelson@osumc.edu,flavia_nobay@urmc.rochester.edu,kyadav@alum.mit.edu,boppansa@ucmail.uc.edu,znadah@yahoo.com,brian.nelson@ttuhsc.edu,salkenmd@ucmail.uc.edu,kimberly.biery@thechristhospital.com,lynne.yancey@ucdenver.edu,wlnicholsrn@gmail.com,atwehge@ucmail.uc.edu,groysman@gmail.com,nyoussef@tuftsmedicalcenter.org,deborah.webb@dinsmore.com,jkolli@rossmed.edu.dm,latiftr@ucmail.uc.edu,zgurzynp@ummhc.org,tescar50@gmail.com,atflanigan@yahoo.com,john.pancoast@va.gov,rucknadl@ucmail.uc.edu,nestorbnestor@gmail.com,aymanyassa@gmail.com,tagonagy@pipeline.com,brethas@ccf.org,pnouhan10@comcast.net,szehtabchi@yahoo.com,kgorourke@gmail.com,kenyudigit@gmail.com,panagosp@wusm.wustl.edu,karimnf@ucmail.uc.edu,olshaker@bu.edu,rnowak1@hfhs.org,yealydm@upmc.edu,tnowick@harthosp.org,jnomura@comcast.net,cnickels@ufl.edu,reo4x@virginia.edu,ronan.osullivan@olchc.ie,krohm@ccf.org,pacellacb@upmc.edu,nazario65@mac.com,john.morris2@uc.edu,turtle481@hotmail.com,rollsn@ucmail.uc.edu,jessie.g.nelson@gmail.com,james.palma@usuhs.mil,arthur.pancioli@uc.edu,apark@aahs.org,jeffa@iglou.com,aasimpadela@yahoo.com,novik911@gmail.com,mjwagner@cris.com,lanty-oconnor@northwestern.edu,okeefek@ecu.edu,jdacker@emory.edu,edward.otten@uc.edu,mjoneill@massmed.org,j-vozenilek@northwestern.edu,taku.taira@stonybrook.edu,stevenbird@hotmail.com,sheron@emory.edu,pshayne@emory.edu,lynn.babcockcimpello@cchmc.org,dwwrigh@emory.edu,leigh.evans@yale.edu,dgordon05@gmail.com,jklig@partners.org,losman@med.umich.edu,msmith2@metrohealth.org,jeannettewolfe@yahoo.com,torres.20@osu.edu,enslayden@gmail.com,mifl@yahoo.com,charleneirvinmd@gmail.com,akadewale@yahoo.com,matthew.a.silver@kp.org,federico.vaca@yale.edu,pichatt@gmail.com,michael.w.vanmeter@uth.tmc.edu,zackmeisel@yahoo.com,fkorley1@jhmi.edu,dwashke@llu.edu,cstark@hmc.psu.edu,delbridget@ecu.edu,yousentwhohome@gmail.com,loriwinstonmd@gmail.com,petra.duran@jax.ufl.edu,hshokoohi@mfa.gwu.edu,smith253@umn.edu,sharonrwilson@earthlink.net,sandi.s.wewerka@healthpartners.com,gmartin1@hfhs.org,sbuzzel1@hfhs.org,gmvilke@ucsd.edu,bholroyd@ualberta.ca,asucov@lifespan.org,javegn@lsuhsc.edu,stifflek@summahealth.org,touger@mindspring.com,mawalsh@salud.unm.edu,jtupesis@medicine.wisc.edu,kev_007_007@yahoo.com,judymorris02@hotmail.com,jin.h.han@vanderbilt.edu,weiner_d@tch.harvard.edu,rob.woods@usask.ca,fernanre@comcast.net,danielle.turner-lawrence@beaumont.edu,jeffrey_thompson@hotmail.com,mslezak1@hfhs.org,ccairns@med.unc.edu,basmah.safdar@yale.edu,agormdpem@aol.com,katrin.takenaka@uth.tmc.edu,raweinb@uky.edu,robie@umich.edu,susan.stroud@hsc.utah.edu,dwiener@chpnet.org,jason.hoppe@ucdenver.edu,jeffrey.sankoff@dhha.org,william.chiang@nyumc.org,j-collings@northwestern.edu,gerar001@mc.duke.edu,timwalther@yahoo.com,don.byars@me.com,stetzjessica@yahoo.com,tward4@live.com,mkbriggs@post.harvard.edu,dan@aemrc.arizona.edu,angcirilli@gmail.com,stanleyr@med.umich.edu,mbreyer1@comcast.net,esimon78@yahoo.com,piachatt@gmail.com,marcanthonyv@yahoo.com,howard.smithline@bhs.org,jholliman@cdham.org,kajista@yahoo.com,swglick@yahoo.com,sweiner@massmed.org,mdorfman@reshealthcare.org,mmalhot1@hfhs.org,jfahimi@gmail.com,sstern@u.washington.edu,mglenn07@gmail.com,jbroder@nc.rr.com,peter.taillac@hsc.utah.edu,elizabeth_nestor@brown.edu,jwalline@slu.edu,lregan@jhmi.edu,sorabh.khandelwal@osumc.edu,carrb@upenn.edu,hwattsmd@gmail.com,richard.sinert@downstate.edu,stevenygb5@yahoo.com,bindu2004@gmail.com,james.moak@virginia.edu,messier_alex@hotmail.com,dander@emory.edu,sultanaqureshi@gmail.com,lisaethomas@gmail.com,stephen.wall@nyumc.org,newgardc@ohsu.edu,nicholas.dyc@stjohn.org,sepstein@bidmc.harvard.edu,alisouthern5@yahoo.com,elisha.p.dekoning@hitchcock.org,mmjtruesdale@netspace.net.au,cwolco@lsuhsc.edu,barenj@uphs.upenn.edu,tthomas@llu.edu,elaine.rabin@mssm.edu,rcharwood@aol.com,zigrosda@hotmail.com,nemeth@bcm.edu,mollenc@email.chop.edu,mcudnik@hotmail.com,tranomaha@hotmail.com,brian.r.macleod@gmail.com,mfryan@ufl.edu,phawley@umich.edu,chwilloughby@gmail.com,soxdoc6@yahoo.com,tobiasa@upmc.edu,stroh@umich.edu,laurenwh@med.umich.edu,jvalente@lifespan.org,rcsmd82@comcast.net,lstead@ufl.edu,matthewfields@gmail.com,jdhewlet@iupui.edu,wayne.moore@nashvilleha.org,mwitt001@umaryland.edu,pw91@columbia.edu,brent.king@uth.tmc.edu,ericlalonde13@yahoo.ca,creese@christianacare.org,harsh.sule@jefferson.edu,david.karras@temple.edu,aweltge@comcast.net,bwalshmd@massmed.org,bcummins@utahep.com,waseemm2001@hotmail.com,tplattsm@med.unc.edu,tamato@nshs.edu,clunac@hotmail.com,kreedmd1@hotmail.com,adam.singer@stonybrook.edu,dszyld@gmail.com,jliebze@emory.edu,ernestwangmd@gmail.com,khtodd@mdanderson.org,mg7561@gmail.com,vicken.totten@uhhospitals.org,lschweigler@lifespan.org,as2cd@virginia.edu,rwahl@med.wayne.edu,rsummers@umc.edu,ellen.weber@ucsf.edu,gullett88@hotmail.com,amvisconti@aol.com,docjwag@mac.com,cpruden@ccmckids.org,jburkhar@umich.edu,rthompson27@gmail.com,amtichter@gmail.com,krodgers@iuhealth.org,ilgen@u.washington.edu,lynne.richardson@mssm.edu,sanjaymd@gmail.com,dhowes@medicine.bsd.uchicago.edu,jason.shapiro@mssm.edu,randy-pilgrim@schumachergroup.com,robert.woolard@ttuhsc.edu,pesokolove@ucdavis.edu,sohoni79@gmail.com,thibodl@mail.amc.edu,marchick@ufl.edu,emergentt@gmail.com,marjansiadat7@gmail.com,arvindvenkat@hotmail.com,genevieve.tessier@usherbrooke.ca,jnlove1@verizon.net,frank.zwemer@va.gov,michael-takacs@uiowa.edu,robinett77@yahoo.com,ddrigalla@swmail.sw.org,holsond@nychhc.org,bhoffma8@jhmi.edu,laura.walker@yale.edu,jason.thurman@vanderbilt.edu,raswor@beaumont.edu,mstevens@mcw.edu,whiten427@gmail.com,bsimon@acmedctr.org,chulintsai@gmail.com,wardmj@uc.edu,deborah.battaglia@hsc.utah.edu,jfisher2@bidmc.harvard.edu,tquest@emory.edu,tom.morrissey@jax.ufl.edu,roger@emedharbor.edu,jes9038@med.cornell.edu,jmanning@med.unc.edu,bijal.shah@emory.edu,agh@medicine.wisc.edu,jcmbfla@aol.com,grantlip@hotmail.com,simmonsde@hotmail.com,wonchungmd@gmail.com,jeffrey.druck@ucdenver.edu,esenecal@partners.org,dsklar@salud.unm.edu,nathan_hudepohl@brown.edu,jhess@emory.edu,dgp3a@hscmail.mcc.virginia.edu,rjsobehart@mac.com,jsbushra@me.com,andrej.urumov@gmail.com,dmcmicken@ufl.edu,aaron.z.hettinger@medstar.net,dvega@yorkhospital.edu,ychow@jpshealth.org,gaieskid@uphs.upenn.edu,richard.ruddy@cchmc.org,jmuell1@lumc.edu,rmorchi@emedharbor.edu,matthew.sullivan@carolinashealthcare.org,agarcia1@hfhs.org,jedd.roe@beaumont.edu,anandswaminathan77@gmail.com,dsalzman005@md.northwestern.edu,lanolting@gmail.com,des9028@med.cornell.edu,todd.larabee@ucdenver.edu,cmswickhamer@gmail.com,aulrich@bu.edu,thomash@ohsu.edu,stephanie.a.taft@healthpartners.com,griffeyr@wusm.wustl.edu,sakhtar@chpnet.org,timothy.mader@bhs.org,edsloanuic@gmail.com,aisakov@emory.edu,manini.alex@gmail.com,cpoole@christianacare.org,mbollinger@christianacare.org,anhvoi@hotmail.com,seltzerd@wusm.wustl.edu,judd.hollander@uphs.upenn.edu,doc_aghera@yahoo.com,jrose@maimonidesmed.org,jeffrey.schneider@bmc.org,abelwakai@gmail.com,steveshane@sbcglobal.net,david.pearson@carolinas.org,jim.christenson@ubc.ca,reedert@ecu.edu,mapuskarich@gmail.com,salzmanm@einstein.edu,jpennington@metrohealth.org,niels.rathlev@tufts.edu,kbp9@columbia.edu,rahul_patwari@rush.edu,david.j.robinson@uth.tmc.edu,kinjal.sethuraman@gmail.com,elizschoen@gmail.com,jripper@sbhcs.com,jerri.rose@uhhospitals.org,prichmanmdmba@gmail.com,johnrogersmd@bellsouth.net,quinnj@stanford.edu,na_nadol@hotmail.com,ors1@columbia.edu,cpearson@med.wayne.edu,crosen2@bidmc.harvard.edu,maproc01@hotmail.com,shahcn@umdnj.edu,shahanan@upenn.edu,rosalynreades@gmail.com,madeos@gmail.com,mariarramos@gmail.com,sakles@aemrc.arizona.edu,srpitts@emory.edu,kaush.shah@gmail.com,gschiff@partners.org,dr.joseorlandorivera@hotmail.com,lpstat@aol.com,pankaj.patel@kp.org,tfpayton@geisinger.edu,iliriana.sela@gmail.com,michael.rest@yale.edu,doctorep@telus.net,dsp3a@hscmail.mcc.virginia.edu,s.philip@ekrtx.com,maria.raven@med.nyu.edu,ssanten@emory.edu,ppang@northwestern.edu,jschuur@partners.org,michael.runyon@carolinas.org,sampsonc@wusm.wustl.edu,megan_ranney@brown.edu,stacy.reynolds@carolinas.org,jserra@ucsd.edu,alex.rosenau@gmail.com,emilie.powell@gmail.com,jschrock@metrohealth.org,kvr@sp2.upenn.edu,elissa.schechter@gmail.com,zroit@nshs.edu,mjs@ices.on.ca,bpetinaux@mfa.gwu.edu,phelanm@ccf.org,lsanche1@bidmc.harvard.edu,wesley.self@vanderbilt.edu,stacey.poznanski@gmail.com,susan.promes@ucsf.edu,schiebel.nicola@mayo.edu,michael.juliano@med.navy.mil,oaks61596@aol.com,dmresop@gmail.com,tysonpillow@gmail.com" />
    <cfloop list="#emails#" index="i" delimiters=",">
      <cfquery name="qPerson" datasource="#application.settings.dsn#">
        SELECT personid,firstname,certname,displayname FROM users
        WHERE email = '#i#'
      </cfquery>
      <cfif qPerson.recordCount GT 0>
        <cfset application.email.send(emailstyleid=7,toPersonId=qPerson.personid) />
        <cfoutput><div>#qPerson.certname# [#i#] - sent.</div></cfoutput>
         <cfflush>
      </cfif>
    </cfloop>
    Done.
  </cffunction>
</cfcomponent>