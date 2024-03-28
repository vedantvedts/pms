package com.vts.pfms.mail;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.RestTemplate;

import com.vts.pfms.service.RfpMainService;

import org.springframework.web.bind.annotation.RestController;

@RestController
public class CustomSMSProxySender {

    private final RestTemplate restTemplate;
    private static final Logger logger=LogManager.getLogger(CustomSMSProxySender.class);
    
    @Autowired
	RfpMainService service;

    @Autowired
	Environment env;
    
    @Autowired
    public CustomSMSProxySender(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

   // @Scheduled(cron = "0 47 14 * * ?")
    public void myDailySmsSend() {
      logger.info(new Date() + " Inside CONTROLLER myDailySmsSend ");
      try {
          long SmsTrackingId = 0;
          long SmsTrackingInsightsId = 0;
          long DailyPendingSmSendInitiation = service.GetSMSInitiatedCount("D");
          if (DailyPendingSmSendInitiation == 0) {
        	  SmsTrackingId = service.InsertSmsTrackInitiator("D");
          }
            //the list of daily pending reply details
              List<Object[]> PendingAssigneeEmpsDetailstoSendSms = service.GetDailyPendingAssigneeEmpData();
             if (SmsTrackingId > 0 && PendingAssigneeEmpsDetailstoSendSms != null && PendingAssigneeEmpsDetailstoSendSms.size() > 0) {
              	 SmsTrackingInsightsId = service.InsertDailySmsPendingInsights(SmsTrackingId);
              	   if(SmsTrackingInsightsId > 0) {
                  service.updateSmsSuccessCount(SmsTrackingId, SmsTrackingInsightsId, "D");
            }   
           // if No EmpId is found to send daily message
             } else {
                  service.UpdateNoSmsPendingReply("D");
              }
          
      } catch (Exception e) {
          e.printStackTrace();
          logger.error(new Date() + " Inside CONTROLLER myDailyPendingScheduledSmsTask " + e);
      }
  }
    
    
   // @Scheduled(cron = "0 48 14 * * ?")
    public void DirectorDailySmsSend() {
      logger.info(new Date() + " Inside CONTROLLER DirectorDailySmsSend ");
      try {
    	  long SmsTrackingId = 0;
          long SmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          SmsTrackingId = service.DirectorInsertSmsTrackInitiator("D");
          List<Object[]> DirectorPendingReplyEmpsDetailstoSendSms = service.GetDirectorDailyPendingAssignEmpData("LRDE");
          if (SmsTrackingId > 0 && DirectorPendingReplyEmpsDetailstoSendSms != null && DirectorPendingReplyEmpsDetailstoSendSms.size() > 0) {
         	 SmsTrackingInsightsId = service.DirectorInsertDailySmsPendingInsights(SmsTrackingId);
         	   if(SmsTrackingInsightsId > 0) {
               service.updateSmsSuccessCount(SmsTrackingId, SmsTrackingInsightsId, "D");
              }
   
			// if No EmpId is found to send daily message
			  } else {
			       service.UpdateNoSmsPendingReply("D");
			   }

      } catch (Exception e) {
          e.printStackTrace();
          logger.error(new Date() + " Inside CONTROLLER DirectorDailySmsSend " + e);
       }
  }
    
    //@Scheduled(cron = "0 10 7 * * ?")
    public void myDailyCommitteSmsSend() {
      logger.info(new Date() + " Inside CONTROLLER myDailyCommitteSmsSend ");
      try {
          long CommitteSmsTrackingId = 0;
          long CommitteSmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          long DailyCommitteSmSendInitiation = service.GetCommitteSMSInitiatedCount("D");
          if (DailyCommitteSmSendInitiation == 0) {
        	  CommitteSmsTrackingId = service.InsertCommitteSmsTrackInitiator("D");
          }
            //the list of daily pending reply details
              List<Object[]> CommitteEmpsDetailstoSendSms = service.GetCommitteEmpsDetailstoSendSms();
             if (CommitteSmsTrackingId > 0 && CommitteEmpsDetailstoSendSms != null && CommitteEmpsDetailstoSendSms.size() > 0) {
            	 CommitteSmsTrackingInsightsId = service.InsertDailyCommitteSmsInsights(CommitteSmsTrackingId);
              	   if(CommitteSmsTrackingInsightsId > 0) {
                  service.updateCommitteSmsSuccessCount(CommitteSmsTrackingId,CommitteSmsTrackingInsightsId, "D");
            }   
           // if No EmpId is found to send daily message
             } else {
                  service.UpdateCommitteNoSmsPending("D");
              }
          
      } catch (Exception e) {
          e.printStackTrace();
          logger.error(new Date() + " Inside CONTROLLER myDailyCommitteSmsSend " + e);
      }
  }
}
