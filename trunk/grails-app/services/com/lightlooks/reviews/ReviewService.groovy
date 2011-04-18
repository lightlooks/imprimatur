package com.lightlooks.reviews

import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.springframework.web.multipart.MultipartFile

class ReviewService {
	
	def grailsApplication

    static transactional = true
	
	static HashMap reviewerMap = new HashMap()
	

    def review(MultipartFile file, metadata, reviewInstance) {
		System.out.println("Been asked to review "+file+ "using reviewrmap: "+reviewerMap);
		reviewerMap.values().each { config ->
			config.doReview(file, metadata, reviewInstance)
			
		}
		
    }
	
	def clear() {
		reviewerMap.clear()
	}
	
	def refreshReviewers(){
		this.clear()
		new File( grailsApplication.config.reviewersDir ).eachFile {
			file ->
			if(file.getName().endsWith("Plugin.groovy")){
			def config = new ConfigSlurper().parse (file.toURL())
			reviewerMap.put config.key, config
			System.out.println("Loaded reviewer ${config.name} from file ${file}")
			System.out.println("The config is "+config);
			System.out.println("config.doReview.toString() is "+config.doReview.toString())
			}
			 }
	}
	/* convenience methods for plugin scripts to insulate them from domain classes */
	def addError={ line, code, description, reviewInstance ->
		def re = new ReviewError(line, code, description)
		reviewInstance.addToReviewErrors(re)
	}
	def addWarning={ line, code, description, reviewInstance ->
		def re = new Warning(line, code, description)
		reviewInstance.addToReviewWarnings(re)
	}
	
}
