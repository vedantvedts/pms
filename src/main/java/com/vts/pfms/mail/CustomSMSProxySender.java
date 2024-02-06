package com.vts.pfms.mail;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.RestTemplate;

import com.vts.pfms.committee.dto.SmsDto;
import com.vts.pfms.service.RfpMainService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    
	/*
	 * @GetMapping("proxySmsSender.htm") public String proxyRequest(@RequestParam
	 * String msg, @RequestParam String mobile) {
	 * System.out.println("CALL PROXY SMS MESSAGE" + msg);
	 * System.out.println("CALL PROXY SMS RECEIVER" + mobile);
	 * 
	 * 
	 * //To the externalUrl pass query parameters msg and mobile String externalUrl
	 * = "http://10.128.5.103/lrdesms/sendSMSApi.php"; String fullUrl = externalUrl
	 * + "?msg=" + msg + "&mobile=" + mobile;
	 * 
	 * try { // Make the proxy request String response =
	 * restTemplate.getForObject(fullUrl, String.class);
	 * 
	 * // Log the message after the request is complete
	 * 
	 * System.out.
	 * println("SMS status request sent for MobileNo@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@: "
	 * + mobile);
	 * 
	 * return response; } catch (Exception e) { e.printStackTrace(); // Handle any
	 * errors as needed return "Error: " + e.getMessage(); } }
	 */
    
    
    
    public String proxyRequest(@RequestParam String msg, @RequestParam String mobile) {
    	System.out.println("CALL PROXY SMS MESSAGE" + msg);
    	System.out.println("CALL PROXY SMS RECEIVER" + mobile);
        

        //To the externalUrl pass query parameters msg and mobile
    	String externalUrl = env.getProperty("sms_url");
        String fullUrl = externalUrl + "?msg=" + msg + "&mobile=" + mobile;
        
        System.out.println("fullurl:"+fullUrl);

        try {
        	
            // Make the proxy request
            String response = restTemplate.getForObject(fullUrl, String.class);
            
            // Log the message after the request is complete

            System.out.println("SMS status request sent for MobileNo@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@: " + mobile);
            
            return "1";
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any errors as needed
            return "-1";
        }	
    }
    
    @Scheduled(cron = "0 0 7 * * ?")
    public void myDailySmsSend() {
      logger.info(new Date() + " Inside CONTROLLER myDailySmsSend ");
      try {
          long SmsTrackingId = 0;
          long SmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          AtomicInteger SmsSendSuccessCount = new AtomicInteger(0);

          long DailyPendingSmSendInitiation = service.GetSMSInitiatedCount("D");
          if (DailyPendingSmSendInitiation == 0) {
        	  SmsTrackingId = service.InsertSmsTrackInitiator("D");
          }
          
          final long effectivelyFinalSmsTrackingId = SmsTrackingId;

            //the list of daily pending reply details
              List<Object[]> PendingAssigneeEmpsDetailstoSendSms = service.GetDailyPendingAssigneeEmpData();
             if (SmsTrackingId > 0 && PendingAssigneeEmpsDetailstoSendSms != null && PendingAssigneeEmpsDetailstoSendSms.size() > 0) {
              	 SmsTrackingInsightsId = service.InsertDailySmsPendingInsights(SmsTrackingId);
              	   
              	   if(SmsTrackingInsightsId > 0) {
                  
                            // Create a map to store unique EmpId, emails, DakNos, and Sources
                             Map<Object, SmsDto> empToDataMap = new HashMap<>();
      
                            //iterate over the PendingReplyEmpsDetailstoSendMail and constructs a map empToDataMa) to group information by unique EmpId.
                            //It collects the email addresses, DakNos, and Sources for each EmpId.  
                  
                           for (Object[] obj : PendingAssigneeEmpsDetailstoSendSms) {
                      
                  	           Object empId = obj[1];
                               Object ActionItem = obj[5];
                               Object dueDate = obj[6];
                               String MobileNo = null;
                               if(obj[4] != null && !obj[4].toString().trim().isEmpty()) {
                            	   MobileNo = obj[4].toString();
                      	     }

                               if (empId != null && MobileNo != null && !MobileNo.isEmpty()) {
                                   if (!empToDataMap.containsKey(empId)) {
                                   empToDataMap.put(empId, new SmsDto(MobileNo));
                               }

                                   if (ActionItem != null && !ActionItem.toString().isEmpty()) {
                                       empToDataMap.get(empId).addActionItemAndPdcDate(ActionItem.toString(), dueDate.toString());
                                   }
                              }
                               
                          }

            
                     // Iterate over the map and sends an email to each unique EmpId
                       //It creates an HTML table in the email body to display the DakNos and Sources related to each EmpId
                
                        // After building the empToDataMap, iterate over it to send Sms
                       for (Map.Entry<Object, SmsDto> SmsMapData : empToDataMap.entrySet()) {
                         Object empId = SmsMapData.getKey();
                         SmsDto emailData = SmsMapData.getValue();
                         String MobileNo = emailData.getMobileNo();
                         
                          Object[] ActionAssignCounts =service.ActionAssignCounts(Long.parseLong(empId.toString()),LocalDate.now().toString());
                          System.out.println("DakCounts[0]"+ActionAssignCounts[0].toString());
                            if (MobileNo != null && !MobileNo.equalsIgnoreCase("0") && MobileNo.trim().length()>0 && MobileNo.trim().length()==10 && Integer.parseInt(ActionAssignCounts[0].toString())>0) {
                                 // Create and format the Sms content
                                 String message = "Good Morning,\n Today Status:  AA= " +ActionAssignCounts[0].toString() + "  OG= "+ActionAssignCounts[1].toString() +"  DO= " +ActionAssignCounts[2].toString()+"\n-PMS Team. ";
                                       // Send the Sms asynchronously within the loop
                                       String sendResult = proxyRequest(message,MobileNo);
                                       CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> sendResult);
                                // Chain actions once the Sms sending is complete
                                       future.thenAcceptAsync(result -> {
                                    	    if ("1".equalsIgnoreCase(result)) {
                                    	        // Successfully sent
                                    	      try {
												 service.UpdateParticularEmpSmsStatus("D", "S", Long.parseLong(empId.toString()), effectivelyFinalSmsTrackingId,message);
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
                                    	        System.out.println("Success");
                                    	        SmsSendSuccessCount.incrementAndGet(); // Increment success count atomically
                                    	    } else {
                                    	        // Failed to send
                                    	        try {
													service.UpdateParticularEmpSmsStatus("D", "N", Long.parseLong(empId.toString()), effectivelyFinalSmsTrackingId,"");
												} catch (Exception e) {
													// TODO Auto-generated catch block
													e.printStackTrace();
												}
                                    	        System.out.println("Failure");
                                    	    }
                                    	}).exceptionally(ex -> {
                                    	    System.out.println("Exception occurred: " + ex.getMessage());
                                    	    return null;
                                    	});

                                    	// Wait for completion if needed
                                    	future.join();
                      }
                  }
                  // After the loop, update the count in your table with the success count
                  // You can call a service method to perform the update
                  // Wait for all asynchronous Sms tasks to complete
                  CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
                  allOf.join(); // This ensures all tasks have completed

                  if(SmsSendSuccessCount.get()>0) {
                  service.updateSmsSuccessCount(SmsTrackingId, SmsSendSuccessCount.get(), "D");
                  }
              
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
    
    
    @Scheduled(cron = "0 5 7 * * ?")
    public void DirectorDailySmsSend() {
      logger.info(new Date() + " Inside CONTROLLER DirectorDailySmsSend ");
      try {
    	  long SmsTrackingId = 0;
          long SmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          AtomicInteger SmsSendSuccessCount = new AtomicInteger(0);

          SmsTrackingId = service.DirectorInsertSmsTrackInitiator("D");
          final long effectivelyFinalSmsTrackingId = SmsTrackingId;
          
          List<Object[]> DirectorPendingReplyEmpsDetailstoSendSms = service.GetDirectorDailyPendingAssignEmpData("LRDE");
          if (SmsTrackingId > 0 && DirectorPendingReplyEmpsDetailstoSendSms != null && DirectorPendingReplyEmpsDetailstoSendSms.size() > 0) {
         	 SmsTrackingInsightsId = service.DirectorInsertDailySmsPendingInsights(SmsTrackingId);
         	   if(SmsTrackingInsightsId > 0) {
         		   long EmpId=Long.parseLong(DirectorPendingReplyEmpsDetailstoSendSms.get(0)[0].toString());
                   String MobileNo = DirectorPendingReplyEmpsDetailstoSendSms.get(0)[1].toString();
              
                   Object[] DirectorActionAssignCounts =service.DirectorActionAssignCounts(LocalDate.now().toString());
               System.out.println("DakCounts[0]"+DirectorActionAssignCounts[0].toString());
                 if (MobileNo != null && !MobileNo.equalsIgnoreCase("0") && MobileNo.trim().length()>0 && MobileNo.trim().length()==10 && Integer.parseInt(DirectorActionAssignCounts[0].toString())>0) {
                      // Create and format the Sms content
                      String message = "Good Morning,\nToday Status:  AA= " +DirectorActionAssignCounts[0].toString() + "  OG= "+DirectorActionAssignCounts[1].toString() +"  DO= " +DirectorActionAssignCounts[2].toString()+"\n-PMS Team.";
                            // Send the Sms asynchronously within the loop
                            String sendResult = proxyRequest(message,MobileNo);
                            CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> sendResult);
                     // Chain actions once the Sms sending is complete
                            future.thenAcceptAsync(result -> {
                         	    if ("1".equalsIgnoreCase(result)) {
                         	        // Successfully sent
                         	      try {
										 service.UpdateParticularEmpSmsStatus("D", "S", EmpId, effectivelyFinalSmsTrackingId,message);
									} catch (Exception e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
                         	        System.out.println("Success");
                         	        SmsSendSuccessCount.incrementAndGet(); // Increment success count atomically
                         	    } else {
                         	        // Failed to send
                         	        try {
											service.UpdateParticularEmpSmsStatus("D", "N", EmpId, effectivelyFinalSmsTrackingId,"");
										} catch (Exception e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										}
                         	        System.out.println("Failure");
                         	    }
                         	}).exceptionally(ex -> {
                         	    System.out.println("Exception occurred: " + ex.getMessage());
                         	    return null;
                         	});

                         	// Wait for completion if needed
                         	future.join();
           }
       }
       // After the loop, update the count in your table with the success count
       // You can call a service method to perform the update
       // Wait for all asynchronous Sms tasks to complete
       CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
       allOf.join(); // This ensures all tasks have completed

       if(SmsSendSuccessCount.get()>0) {
       service.updateSmsSuccessCount(SmsTrackingId, SmsSendSuccessCount.get(), "D");
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
    
    @Scheduled(cron = "0 10 7 * * ?")
    public void myDailyCommitteSmsSend() {
      logger.info(new Date() + " Inside CONTROLLER myDailyCommitteSmsSend ");
      try {
          long CommitteSmsTrackingId = 0;
          long CommitteSmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          AtomicInteger SmsSendSuccessCount = new AtomicInteger(0);

          long DailyCommitteSmSendInitiation = service.GetCommitteSMSInitiatedCount("D");
          if (DailyCommitteSmSendInitiation == 0) {
        	  CommitteSmsTrackingId = service.InsertCommitteSmsTrackInitiator("D");
          }
          
          final long effectivelyFinalSmsTrackingId = CommitteSmsTrackingId;

            //the list of daily pending reply details
              List<Object[]> CommitteEmpsDetailstoSendSms = service.GetCommitteEmpsDetailstoSendSms();
             if (CommitteSmsTrackingId > 0 && CommitteEmpsDetailstoSendSms != null && CommitteEmpsDetailstoSendSms.size() > 0) {
            	 CommitteSmsTrackingInsightsId = service.InsertDailyCommitteSmsInsights(CommitteSmsTrackingId);
              	   
              	   if(CommitteSmsTrackingInsightsId > 0) {
                  
                           for (Object[] obj : CommitteEmpsDetailstoSendSms) {
                               String MobileNo = null;
                               if(obj[1] != null && !obj[1].toString().trim().isEmpty()) {
                            	   MobileNo = obj[1].toString();
                               }

                            if (MobileNo != null && !MobileNo.equalsIgnoreCase("0") && MobileNo.trim().length()>0 && MobileNo.trim().length()==10) {
                            	 long empId = Long.parseLong(obj[0].toString());
                            	 String message="";
                            	 List<Object[]> committedata=service.getCommittedata(empId);
                            	 
                					for(Object[] str:committedata) {
                						LocalTime time = LocalTime.parse(str[6].toString());
                				        
                				        // Format the time as "HH:mm Hrs"
                				        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm 'Hrs'");
                				        String formattedTime = time.format(formatter);
                						if(str[7]!=null && str[7].toString().equalsIgnoreCase("P")) {
                							message+="Good Morning,\n Today Status: P"+str[1].toString()+" - "+str[2].toString() +" at " +formattedTime+"\n";
                						}else {
                							message+="Good Morning,\n Today Status: NP - "+str[2].toString() +" at " +formattedTime+"\n";
                						}
                						
                					}
                					message+="\n-PMS Team.";
                					
                                 // Create and format the Sms content
                                       // Send the Sms asynchronously within the loop
                					   String finalmsg=message;
                					   System.out.println("message"+finalmsg);
                                       String sendResult = proxyRequest(finalmsg,MobileNo);
                                       CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> sendResult);
                                // Chain actions once the Sms sending is complete
                                       future.thenAcceptAsync(result -> {
                                    	    if ("1".equals(result)) {
                                    	        // Successfully sent
                                    	      try {
												 service.UpdateParticularCommitteEmpSmsStatus("D", "S", empId, effectivelyFinalSmsTrackingId,finalmsg);
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
                                    	        System.out.println("Success");
                                    	        SmsSendSuccessCount.incrementAndGet(); // Increment success count atomically
                                    	    } else {
                                    	        // Failed to send
                                    	        try {
													service.UpdateParticularCommitteEmpSmsStatus("D", "N", empId, effectivelyFinalSmsTrackingId,"");
												} catch (Exception e) {
													// TODO Auto-generated catch block
													e.printStackTrace();
												}
                                    	        System.out.println("Failure");
                                    	    }
                                    	}).exceptionally(ex -> {
                                    	    System.out.println("Exception occurred: " + ex.getMessage());
                                    	    return null;
                                    	});

                                    	// Wait for completion if needed
                                    	future.join();
                      }
                  }
                  // After the loop, update the count in your table with the success count
                  // You can call a service method to perform the update
                  // Wait for all asynchronous Sms tasks to complete
                  CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
                  allOf.join(); // This ensures all tasks have completed

                  if(SmsSendSuccessCount.get()>0) {
                  service.updateCommitteSmsSuccessCount(CommitteSmsTrackingId, SmsSendSuccessCount.get(), "D");
                  }
              
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
