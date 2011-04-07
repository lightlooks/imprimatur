package com.lightlooks.reviews

class ReviewError implements Comparable{
	int lineNumber
	String code
	String description

	static belongsTo = Review
    static constraints = {
		description(maxLength:512)
    }
	@Override
	public String toString() {
		 return "l "+lineNumber+": ["+code+"] \""+description+"\""
	}
	
	int compareTo(other){
		this.lineNumber <=> other?.lineNumber
	}
}
