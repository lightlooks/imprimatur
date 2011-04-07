package com.lightlooks.reviews

class RoleListTagLib {

	
	/* dependency injected from spring-security-core plugin */
	def springSecurityService
	
	static namespace = 'roles'
	
	/**
	 * 
	 */
	def list= { 
		def uname = springSecurityService.principal.username
		def p = Person.findByUsername(uname)
		out << '<h1>Roles for '
		out << uname
		out << '</h1><ul>'
		p.getAuthorities().each { personRole -> 
			out << '<li>'
			out << personRole.authority
			out <<'</li>'
			
			}	
		out << '</ul>'	
		}
		
}
