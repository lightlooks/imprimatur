package com.lightlooks.reviews

class SignOff implements Comparable{
	String username
	Calendar dateTimeSignedOff
	String comment
	
	static belongsTo = Review
	
    static constraints = {
		comment(blank: true, nullable:true, maxLength:512)
		username(blank: false)
		dateTimeSignedOff(blank:false)
    }
	
	int compareTo(other){
		return this.dateTimeSignedOff.compareTo(other?.dateTimeSignedOff)
	}
}
