<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
.table thead tr th{vertical-align:middle; text-align: center; font-size: 15px;}
.table tbody tr td{vertical-align:middle;  text-align: center; font-size: 15	px;}
</style>

<title>Demand Flow Details</title>
</head>
<body>





<%
FormatConverter fc=new FormatConverter(); 

List<Object[]>  FileTrackingFlowDetails =(List<Object[]>)request.getAttribute("FileTrackingFlowDetails");
Object[] DemandImmsMainDetailsByDemandId =(Object[])request.getAttribute("DemandImmsMainDetailsByDemandId");

%>






<div class="container-fluid" style="width: 100% !important ;" >
<div class="row">

   
   <div class="col-md-12">
	    <div class="card " style="margin-top:5px;">
		     <div class="card-heading" align="center">
<!-- 			  <i class="fa fa-file-pdf-o " style="font-size:24px"></i> -->
<!-- 			  <i class="fa fa-file-excel-o" style="font-size:24px"></i> -->
 			  <div ><b >File Tacking Full Flow Details</b> </div>    
		    </div><!-- .panel-heading -->
		
			
		   <div class="card-body"> 
		    
	        <table class="table table-condensed table-bordered"  style="width: 100% !important ;" >
	            <tr style="background-color:#bdd3ef"><td style='text-align:left;'><b>Demand For :</b><%=DemandImmsMainDetailsByDemandId[1]%></td>
                <td style='text-align:left;'><b>Demand No :</b><%=DemandImmsMainDetailsByDemandId[2]%></td></tr>
               
	           <tr  style="background-color:#cedbed"><td style='text-align:left;'><b>Demand Date :</b><%=fc.SqlToRegularDate(DemandImmsMainDetailsByDemandId[3].toString())%></td>
               <td style='text-align:left;'><b>Estimated Cost :</b><%=DemandImmsMainDetailsByDemandId[4]%></td></tr>
	        
	        </table>
            
           </div><!--// panel body -->


</div><!--// panel default -->


     

<table class="table table-hover  table-striped table-condensed table-bordered"  style="width: 100% !important ;"	> 
                              <thead> 
                                <tr style="background-color:#FDF5E6">            
                                   <th>Sr No.</th>
                                   <th>Fwd By</th>
                                   <th>Fwd To</th>
                                   <th>Fwd Date</th>
                                   <th>Ack Date</th>
                                   <th>File Stage</th>
                                   <th>Event</th>
                                   <th>Remarks</th>
                                   <th>File Hold Time</th>
                                  </tr>
                               </thead>
                               <tbody>
                                <%
                                	int count=1;
                                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                  if(FileTrackingFlowDetails!=null&&FileTrackingFlowDetails.size()>0)
                                  for(Object[] ls:FileTrackingFlowDetails){{
                                	  	String ackDate=ls[9].toString();
                                	  	String fwdDate=ls[4].toString();
                                	  	long diff = format.parse(ackDate).getTime() - format.parse(fwdDate).getTime();
                                	  	long diffSeconds = diff / 1000 % 60;
                          				long diffMinutes = diff / (60 * 1000) % 60;
                          				long diffHours = diff / (60 * 60 * 1000) % 24;
                          				long diffDays = diff / (24 * 60 * 60 * 1000);
                                  %>
                                  
                                 <tr> 
	                            
	                             <td><%=count%></td>
	                             <td style='text-align:left;'><%=ls[2]%></td>
                                 <td style='text-align:left;'><%=ls[3]%></td>
                                 <td ><%=fc.SqlToRegularDate(ls[4].toString())%></td>
                                 <%if(ls[9]!=null){ %>
                                 <td ><%=fc.SqlToRegularDate(ls[9].toString())%></td>
                                 <%}else{ %>
                                 <td>--</td>
                                 <%} %>
                                 <td><%=ls[5]%></td>
                                 <td style='text-align:left;'><%=ls[6]%></td>
                                 <td style='text-align:left;'><%=ls[7]%></td>
								 <%
								 if(ls[9]!=null && ls[4]!=null){
								 if(diffDays==0){ %>
								 <td><%=diffHours %> Hrs<%=diffMinutes %> Mins </td>
								 <%}else{ %>
								 <td><%=diffDays %> Days</td>
								 <%}}else{ %>
								 <td>--</td>
								 <%} %>

                                </tr>
                              <% ++count;}} %>
                           </tbody> 
                  </table>



</div>



</div><!-- //row -->
</div><!-- //container -->











                
</body>
</html>