package com.lightlooks.reviews

class Review {
	String contact
	byte[] artefactHash
	String artefactName
	Calendar dateRaised
	SortedSet reviewErrors
	SortedSet reviewWarnings
	SortedSet signoffs
	static hasMany=[reviewErrors:ReviewError, reviewWarnings:Warning, signoffs:SignOff]
    
	
	
	static constraints = {
		contact(blank:false, nullable:false)		
	}
}
