var iJabConf =
{
    client_type:"xmpp",
    app_type:"bar",
    theme:"standard",
    debug:true,
    avatar_url:"http://localhost:8888/portal_memberdata/portraits/{username}",
    enable_roster_manage:true,
    enable_talkto_stranger:true,
    expand_bar_default:false,
    enable_login_dialog:true,
    hide_online_group:false,
    disable_option_setting:false,
    disable_msg_browser_prompt:false,
    xmpp:{
        domain:"ccpd.uc.edu",
        http_bind:"/http-bind/",
        host:"",
        port:5222,
        server_type:"openfire",
        auto_login:false,
        none_roster:false,
        get_roster_delay:true,
        username_cookie_field:"username",
        token_cookie_field:"SID",
        anonymous_prefix:"",
        max_reconnect:3,
        // enable_muc:false,
        // muc_servernode:"conference.anzsoft.com",
        // vcard_search_servernode:"vjud.anzsoft.com",
            
    },
    disable_toolbox:true,
    tools:
    [
    	{
    		href:"http://www.google.com",
    		target:"_blank",
    		img:"http://www.google.cn/favicon.ico",
    		text:"Google Search"
    	},
    	{
    		href:"http://www.xing.com/",
    		target:"_blank",
    		img:"http://www.xing.com/favicon.ico",
    		text:"Xing"
    	}
    ],
    shortcuts:
    [
    	// {
    	// 	href:"http://www.anzsoft.com/",
    	// 	target:"_blank",
    	// 	img:"http://www.anzsoft.com/favicon.ico",
    	// 	text:"Go to anzsoft"
    	// },
    	// {
    	// 	href:"http://www.google.com",
    	// 	target:"_blank",
    	// 	img:"http://www.google.cn/favicon.ico",
    	// 	text:"Google Search"
    	// }
    ],
    ijabcometd:{
    }
};