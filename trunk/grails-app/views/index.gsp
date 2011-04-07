<html>
    <head>
        <title>Welcome to Re:view</title>
        <meta name="layout" content="main" />
        <style type="text/css" media="screen">

        #nav {
            margin-top:20px;
            margin-left:30px;
            width:228px;
            float:left;

        }
        .homePagePanel * {
            margin:0px;
        }
        .homePagePanel .panelBody ul {
            list-style-type:none;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody h1 {
            text-transform:uppercase;
            font-size:1.1em;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody {
            background: url(images/leftnav_midstretch.png) repeat-y top;
            margin:0px;
            padding:15px;
        }
        .homePagePanel .panelBtm {
            background: url(images/leftnav_btm.png) no-repeat top;
            height:20px;
            margin:0px;
        }

        .homePagePanel .panelTop {
            background: url(images/leftnav_top.png) no-repeat top;
            height:11px;
            margin:0px;
        }
        h2 {
            margin-top:15px;
            margin-bottom:15px;
            font-size:1.2em;
        }
        #pageBody {
            margin-left:280px;
            margin-right:20px;
        }
        </style>
    </head>
    <body>
        <div id="nav">
            <div class="homePagePanel">
                <div class="panelTop"></div>
                <div class="panelBody">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                    <h1>Your profile</h1>
                    <roles:list></roles:list>
                    
                    
                    <h1>Application Status</h1>
                    <ul>
                        <li>App version: <g:meta name="app.version"></g:meta></li>
                        <li>Grails version: <g:meta name="app.grails.version"></g:meta></li>
                        <li>Groovy version: ${org.codehaus.groovy.runtime.InvokerHelper.getVersion()}</li>
                        <li>JVM version: ${System.getProperty('java.version')}</li>
                        <li>Controllers: ${grailsApplication.controllerClasses.size()}</li>
                        <li>Domains: ${grailsApplication.domainClasses.size()}</li>
                        <li>Services: ${grailsApplication.serviceClasses.size()}</li>
                        <li>Tag Libraries: ${grailsApplication.tagLibClasses.size()}</li>
                    </ul>
                    <h1>Installed Plugins</h1>
                    <ul>
                        <g:set var="pluginManager"
                               value="${applicationContext.getBean('pluginManager')}"></g:set>

                        <g:each var="plugin" in="${pluginManager.allPlugins}">
                            <li>${plugin.name} - ${plugin.version}</li>
                        </g:each>

                    </ul>
                    </sec:ifAllGranted>
                    <sec:ifNotGranted roles="ROLE_ADMIN">
                    	<h1>Welcome to the BA Review application</h1>
                    	<p>This is just a bit of reassuring blurb.</p>
                    	<p>One day, this app will review lots of things that are either produced before there's a code module,
                    	or that are a bit more sophisticated than aye/nay and need to record signoff. Mind you, it'll probably
                    	be running on BA's infrastructure too by then...</p>
                    </sec:ifNotGranted>
                </div>
                <div class="panelBtm"></div>
            </div>
        </div>
        <div id="pageBody">
            <h1>Welcome to Re:view<sec:ifLoggedIn>, <sec:username /></sec:ifLoggedIn>    </h1>
            <p>Welcome to the BA autoreview application. Here are some of the actions you can take....</p>

			<div id="controllerList" class="dialog">
				<h2>Things you can do from here...</h2>
				<ul>
					<li><g:link controller="login" >Log In</g:link></li>
					<sec:ifLoggedIn>
					<li><g:link controller="logout" >Log Out</g:link></li>
					</sec:ifLoggedIn>
					<sec:ifAllGranted roles="ROLE_ADMIN">
					<li><g:link controller="person">Manage users </g:link></li>
					<li><g:link controller="personRole">Manage which users have which roles</g:link></li>
					<li><g:link controller="role">Manage Roles</g:link></li>
					</sec:ifAllGranted>
					<li><g:link controller="review" action="create">Create a new review</g:link></li>
					<li><g:link controller="review" action="list">View a list of reviews</g:link></li>
					<li><g:link controller="review" action="forfile">See if a review exists for a given file</g:link></li>
				</ul>
			</div>
<sec:ifAllGranted roles="ROLE_ADMIN">
            <div id="controllerList" class="dialog">
                <h2>Available Controllers:</h2>
                <ul>
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                        <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
                    </g:each>
                </ul>
            </div>	</sec:ifAllGranted>
        </div>
    </body>
</html>
