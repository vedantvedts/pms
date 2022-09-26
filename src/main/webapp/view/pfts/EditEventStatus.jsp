<%@page import="java.math.BigInteger"%>
<%@page import="com.vts.pfms.pfts.model.PftsFileEvents"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@page import="com.ibm.icu.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
 <style>
 tr:hover td { background-color:#c7ced2;};
</style> 
</head>
<body >



<%
	DateFormat format=new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> fileTrackingList=(List<Object[]>)request.getAttribute("fileTrackingList");
	List<PftsFileEvents> eventList=(List<PftsFileEvents>)request.getAttribute("eventList");
	String demandIdNo=(String)request.getAttribute("demandIdNo");
	String startDate=(String)request.getAttribute("eventDate");
	String currentDate=format.format(new Date());
%>


<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">

					<div class="card-header"
						style="background-color: #055C9D; margin-top:">
						<h4 style="color: white;">Edit Event Status</h4>
					</div>
					<div class="card-body">
						<div class="row" >
						<input type="hidden" id="startDate" value="<%=startDate%>">
						<input type="hidden" id="currentDate" value="<%=currentDate%>">
						<div class=" text-center col-md-4" ></div>
						<div class=" text-center col-md-4" >

	
		<div class="panel-body"  style="padding-top:5px;">		
		<%
		if(fileTrackingList!=null && fileTrackingList.size()>0){ 
			String eventDate=null;
			String event=null;
			int eventId=0;
			int fileTrackingTransactionId=0;
			String remarks=null;
			int fileTrackingId=0;
			
			
			for(Object[] obj:fileTrackingList){
				BigInteger big=(BigInteger)obj[3];
				BigInteger bigF=(BigInteger)obj[9];
				BigInteger bigFId=(BigInteger)obj[8];
				eventId=big.intValue();
				event=(String)obj[4];
				eventDate=format.format((Date)obj[5]);
				fileTrackingTransactionId=bigF.intValue();
				remarks=(String)obj[6];
				fileTrackingId=bigFId.intValue();
		}
		%>
			<input type="hidden" id="EventDate" value="<%=eventDate%>">
		<form action="editStatusEvent.htm" method="post">
			<input type="hidden" name="fileTrackingTransactionId" value="<%=fileTrackingTransactionId%>">
			<input type="hidden" name="demandIdNo" value="<%=demandIdNo%>">
			<div class="form-group">
				<label class="control-label" for="textinput"><font size="3">Event Status :</font></label>
				<select name="EventId" class="form-control selectpicker" data-live-search="true">
				<option value="<%=eventId%>"><%=event %></option>
				<%
				if(eventList!=null) {
					String filestage=null;
				for(PftsFileEvents events:eventList){
					if(events.getFileStageId().equalsIgnoreCase("D")){
			    		filestage="Demand";
			    	}else if(events.getFileStageId().equalsIgnoreCase("T")){
			    		filestage="Tender";
			    	}else if(events.getFileStageId().equalsIgnoreCase("S")){
			    		filestage="Supply Order";
			    	}else if(events.getFileStageId().equalsIgnoreCase("R")){
			    		filestage="Receipt";
			    	}else if(events.getFileStageId().equalsIgnoreCase("A")){
			    		filestage="Accounting";
			    	}else if(events.getFileStageId().equalsIgnoreCase("B")){
			    		filestage="Bill";
			    	}else if(events.getFileStageId().equalsIgnoreCase("M")){
			    		filestage="Milestone";
			    	}
				%>
				<option value="<%=events.getFileEventId()%>"><%=events.getEventName() %> (<%=filestage %>)</option>
				<%}} %>
				</select>
			</div>
			<div class="form-group">
				<label class="control-label" for="textinput"><font size="3">Event Date :</font></label>
				<input type="text" name="EventDate" id="" size="6" class="datepickerF form-control" readonly/>
			</div>
			<div class="form-group">
				<label class="control-label" for="textinput"><font size="3">Remarks :</font></label>
				<%if(remarks!=null){ %>
				<input type="text" name="remarks" id="" size="6" value="<%=remarks%>" class=" form-control" />
				<%}else{ %>
				<input type="text" name="remarks" id="" size="6" value="--" class=" form-control" />
				<%} %>
			</div>
			
			<input type="hidden" name="fileTrackingId" value="<%=fileTrackingId%>">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="form-group">
			<div class="" align="center">
        		<button type="submit" class="btn btn-primary">Submit</button>
      		</div>
			</div>
			
		</form>
		<%}%>
		</div>

	

</div>
</div></div></div></div></div></div>

 <script>
  var fromdate=$("#EventDate").val();
  var startDate=$("#startDate").val();
  var currentDate=$("#currentDate").val();
  $(function () {
  	  $(".datepickerF").datepicker({ 
  	        autoclose: true, 
  	        todayHighlight: true,
  	        format : 'dd-mm-yyyy',
  	    //Enable it 140 for event checking 
  	      	//startDate:startDate,
  	      	//endDate:currentDate
  	  }).datepicker('update', fromdate);
  	});
  $(function () {
  	  $(".datepickerT").datepicker({ 
  	        autoclose: true, 
  	        todayHighlight: true,
  	        format : 'dd-mm-yyyy'
  	  }).datepicker('update', todate);
  	});

</script>


</body>
</html>