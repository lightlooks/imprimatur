import org.codehaus.groovy.grails.commons.ApplicationHolder;

import com.lightlooks.reviews.Role
import com.lightlooks.reviews.Person
import com.lightlooks.reviews.PersonRole

class BootStrap {

	def springSecurityService
	
    def init = { servletContext ->
    
	
		def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
      def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

      String password = springSecurityService.encodePassword('egy9u8a5')
      if(! Person.findByUsername("mdaley")){
	  def testUser = new Person(username: 'mdaley', enabled: true, password: password)
      if(testUser.save(flush: true))
	  {
		  System.out.println("Success creating bootstrap user")
	  }else{
	  System.err.println("Failed to create bootstrap user")
	  }

      PersonRole.create testUser, adminRole, true

      assert Person.count() == 1
      assert Role.count() == 2
      assert PersonRole.count() == 1
      }else{
	  System.out.println("Bootstrap user exists");
	  }
    }
    def destroy = {
    }
}
