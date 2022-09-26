package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_eventcreator")
public class PftsEventCreator 
{
@Id
private int eventCreatorId;
private char userType;
private String eventCreator;
public int getEventCreatorId() {
	return eventCreatorId;
}
public void setEventCreatorId(int eventCreatorId) {
	this.eventCreatorId = eventCreatorId;
}
public char getUserType() {
	return userType;
}
public void setUserType(char userType) {
	this.userType = userType;
}
public String getEventCreator() {
	return eventCreator;
}
public void setEventCreator(String eventCreator) {
	this.eventCreator = eventCreator;
}

}
