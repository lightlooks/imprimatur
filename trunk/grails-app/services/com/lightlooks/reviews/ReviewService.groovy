package com.lightlooks.reviews

import org.codehaus.groovy.grails.commons.GrailsApplication;

class ReviewService {
	
	def grailsApplication

    static transactional = true
	
	static HashMap reviewerMap = new HashMap()

    def review(file, metadata, review) {
		reviewerMap.values.each { reviewer ->
			
			reviewer.review(file, metadata, review)
			
		}
		
    }
	
	def clear() {
		reviewerMap.clear()
	}
	
	def refreshReviewers(){
		this.clear()
		new File( grailsApplication.config.reviewersDir ).eachFile {
			file ->
			def config = new ConfigSlurper().parse (file.toURL())
			reviewers.put config.key, config
			log.debug("Loaded reviewer ${config.name} from file ${file}")
			
			 }
	}
	
}
