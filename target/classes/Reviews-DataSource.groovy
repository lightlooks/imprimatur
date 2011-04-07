dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            pooled= true
			driverClassName="org.apache.derby.jdbc.EmbeddedDriver"
			url="jdbc:derby:/var/lib/tomcat6/db/reviewDB;create=true"
			dbCreate="create-drop"
//			dbCreate = "create-drop" // one of 'create', 'create-drop','update'
//          url = "jdbc:hsqldb:mem:devDB"
        }
    }
    testMac {
        dataSource {
          pooled= true
			driverClassName="org.apache.derby.jdbc.EmbeddedDriver"
			url="jdbc:derby:/U/reviewDB;create=true"
			dbCreate="create-drop"
        }
    }
    production {
        dataSource {
            pooled= true
			driverClassName="org.apache.derby.jdbc.EmbeddedDriver"
			url="jdbc:derby:/var/lib/tomcat6/db/reviewDB;create=true"
			dbCreate="update"
        }
    }
}
