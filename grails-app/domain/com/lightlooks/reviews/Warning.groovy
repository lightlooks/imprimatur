package com.lightlooks.reviews

class Warning implements Comparable{
	int lineNumber
	String code
	String description
	static belongsTo = Review
    static constraints = {
    }
	int compareTo(other){
		this.lineNumber <=> other?.lineNumber
	}
}
