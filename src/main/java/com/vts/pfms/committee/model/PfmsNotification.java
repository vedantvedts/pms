package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="pfms_notification")
public class PfmsNotification {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long NotificationId;
	private Long EmpId;
	private Long Notificationby;
	private String NotificationDate;
	private String NotificationMessage;
	private String NotificationUrl;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Long ScheduleId;
	private String Status;
	
	public Long getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(Long scheduleId) {
		ScheduleId = scheduleId;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	
	public Long getNotificationId() {
		return NotificationId;
	}
	public void setNotificationId(Long notificationId) {
		NotificationId = notificationId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public Long getNotificationby() {
		return Notificationby;
	}
	public void setNotificationby(Long notificationby) {
		Notificationby = notificationby;
	}
	public String getNotificationDate() {
		return NotificationDate;
	}
	public void setNotificationDate(String notificationDate) {
		NotificationDate = notificationDate;
	}
	public String getNotificationMessage() {
		return NotificationMessage;
	}
	public void setNotificationMessage(String notificationMessage) {
		NotificationMessage = notificationMessage;
	}
	public String getNotificationUrl() {
		return NotificationUrl;
	}
	public void setNotificationUrl(String notificationUrl) {
		NotificationUrl = notificationUrl;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
}
