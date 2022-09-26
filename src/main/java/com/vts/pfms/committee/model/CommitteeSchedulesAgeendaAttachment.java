package com.vts.pfms.committee.model;

//@Entity
//@Table(name="committee_schedules_attachment")
public class CommitteeSchedulesAgeendaAttachment {

//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ScheduleAttachmentId;
	private Long ScheduleAgendaId;
//	@Lob
	private byte[] AgendaAttachment;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String AttachmentName;
	public Long getScheduleAttachmentId() {
		return ScheduleAttachmentId;
	}
	public void setScheduleAttachmentId(Long scheduleAttachmentId) {
		ScheduleAttachmentId = scheduleAttachmentId;
	}
	public Long getScheduleAgendaId() {
		return ScheduleAgendaId;
	}
	public void setScheduleAgendaId(Long scheduleAgendaId) {
		ScheduleAgendaId = scheduleAgendaId;
	}
	public byte[] getAgendaAttachment() {
		return AgendaAttachment;
	}
	public void setAgendaAttachment(byte[] agendaAttachment) {
		AgendaAttachment = agendaAttachment;
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
	public String getAttachmentName() {
		return AttachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		AttachmentName = attachmentName;
	}
 	
}
