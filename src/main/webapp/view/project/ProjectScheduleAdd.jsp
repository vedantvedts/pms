<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT COST  ADD</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

b{
	font-family: 'Lato',sans-serif;
}

.fa-trash{
	color: #ec0101;
}

.fa-pencil-square-o{
	color:orange;
}

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}


</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
Integer ProjectScheduleMonth=(Integer) request.getAttribute("ProjectScheduleMonth");
List<Object[]>MilestoneTotalMonth=(List<Object[]>)request.getAttribute("MilestoneTotalMonth");
Integer ScheduleTotalMonths=(Integer) request.getAttribute("ScheduleTotalMonths");

FormatConverter fc = new FormatConverter();
%>


<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>







    <div class="container">
<div class="row" style="">

<div class="col-md-12">

 <div class="card shadow-nohover" >
  <div class="card-header">
 <div class="row" >


<div class="col-md-4" ><h3> Schedule</h3></div>
<div class="col-md-8" >
 <b style="color: green; float: right;">Title :&nbsp;<%=ProjectDetailes[7]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()): " - " %> (<%=ProjectDetailes[6]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()): " - " %>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;&nbsp;Total Months :&nbsp;<%=ProjectDetailes[9]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[9].toString()): " - " %>	</b>
 </div>

 
 	
 	</div>
  </div>
        
        <div class="card-body">
        
         
                        <table  class="table table-bordered table-hover table-striped table-condensed ">
                                    
                                    <%if(ScheduleList.size()!=0){ %>    
                                        <thead>
                                         
                                            <tr>
                                                <th>Milestone</th>
                                                <th>Milestone Activity</th>
                                                <th>Started from</th>
                                                <th>Period</th>
                                                <th>Milestone Month</th>
                                                <th>Remarks</th>
                                              	<th>
                                              		<form action="ProjectScheduleAllPeriodsEditSubmit.htm" method="get">
                                              			<input type="hidden" name="IntiationId" value="<%=IntiationId %>">
                                              			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
                                              			Link&emsp;<button type="submit" class="fa fa-pencil-square-o btn " type="submit"  onclick="return confirm('Are You Sure To Edit All Schedules Periods?');"></button>
                                              		</form>
                                              	</th> 
                                            </tr>
                                        </thead>
                                       <%} %>
                                        
	    	<tbody>
									    <%int count=0;
									    for(Object[] 	obj:ScheduleList){ count++;%>
								<form action="ProjectScheduleEditSubmit.htm" method="POST"  >
									<tr>
								
				                    		
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
				                     <input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
				                      <input type="hidden" name="initiationscheduleid" value="<%=obj[3] %>" /> 	
				                      	
									 	<td><input type="hidden" name="milestoneno" value="<%=obj[0] %>" /> 	MIL-<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td> 
									 	<td style="width: 300px;"><input type="text" class="form-control" name="MilestoneActivityEdit"  required="required" value="<%=obj[1] %>" placeholder="Maximum 4000 Chararcters" maxlength="4000"></td> 
									 	<td >
										<%--  	<select class="form-control selectdee"  name="MilestoneFrom">
											 	<option <%if(obj[5]!=null) %> selected="selected" value="0"><%="0"%></option>
												 	<%for(Object[]obje:ScheduleList){ %>
												 		<%if(obje[0].toString().equalsIgnoreCase(obj[0].toString()))break;
													 		else  { %>
													 		<option value="<%=obje[0] %>" <%if(obj[5].toString().equalsIgnoreCase(obje[0].toString()) ){ %> selected="selected" <%} %>> <%=obje[0] %></option>
												 	<%}} %>
										 	</select>  --%>
										 	 MIL-<%=obj[5] %> 
									 		 <input type="hidden" name="MilestoneFrom" value="<%=obj[5]%>"> 
									 	</td>
									 	<td>
									 		<%=obj[7]!=null?fc.SqlToRegularDate(obj[7].toString()):"" %>
									 		-
									 		<%=obj[8]!=null?fc.SqlToRegularDate(obj[8].toString()):"" %>
									 	</td>
									   	<td style="width: 200px;"><input type="number" class="form-control " name="MilestoneMonthEdit" min="0" required="required" value="<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>"></td>
									   	<td><input type="text" class="form-control " name="MilestoneRemarkEdit"  required="required" value="<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>"></td>
									    <td  style="width: 150px;">
							
									  <button class="fa fa-pencil-square-o btn " type="submit"  onclick="return confirm('Are You Sure To Edit this Schedule?');"></button>
										
										<%if(count==ScheduleList.size()){ %> 
										&nbsp;
										<button class="fa fa-trash btn " type="submit" formaction="ProjectScheduleDeleteSubmit.htm" onclick="return confirm('Are You Sure To Delete this Schedule?');"></button>
										<%} %>										
									</td>
								 	</tr>
</form>
									    <%} %>
									    </tbody>
	    
                                    </table>
        
				
				
				
 	
        
        
        
        
        
        <form action="ProjectScheduleAddSubmit.htm" method="POST" name="myfrm1" id="myfrm1" >
      

		<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
													<thead>  
													<tr>
													<th style="width: 400px; "><div align="center">Milestone Activity</div></th>
													<th><div>Started From</div></th>
													<th style="width: 146px;"><div style="">Milestone Month</div></th>
													<th align="center"><div align="center">Remarks</div></th>
													</tr>
													<input type="hidden"  id="MilestoneAdd" value="1" />
													<tr>
														<td style="width: 300px;"><input type="text" class="form-control form-control" name="MilestoneActivity" id="MilestoneActivity0" required="required" placeholder="Maximum 4000 Chararcters" maxlength="4000"></td>                               	
														<td style="width: 150px;">
														<select class="form-control selectdee" name="Milestonestarted" id="Milestonestarted0">
														<option value="0 0 <%=LocalDate.now() %>"  selected="selected"	hidden="true">MIL-0</option>
												 	    <%if(MilestoneTotalMonth.size()!=0){ %>
														<%for(Object []obj:MilestoneTotalMonth) {%>
															<option value="<%=obj[0]+" "+obj[1]%>">MIL-<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></option>
														<%}}%>
														</select>
														</td>
		
														<td style="width: 100px;"><input type="number" class="form-control form-control" name="MilestoneMonth" id="MilestoneMonth0" min="0" required="required"></td>
														<td style="width: 300px;">	<input type="text" class="form-control form-control" name="MilestoneRemark" id="MilestoneRemark0"  required="required" placeholder="Maximum 250 Chararcters" maxlength="250"></td>
													</tr>
													</thead>
													</table>


          
         <hr>
         
        <div class="form-group">
<center>

 <input type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub" onclick="return confirm('Are You Sure To Add New Schedule(s) ?');">
 <input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
</center>
</div>

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				
		<input type="hidden" name="IntiationId"
				value="<%=IntiationId %>" /> 		
				
 	</form>
        
     </div>`     
   
        </div>
</div>
</div>




	
<script type="text/javascript">

var ProjectScheduleMonth="<%=ProjectScheduleMonth%>";










var TotalMilestoneMonth="<%=ProjectDetailes[9]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[9].toString()): " - " %>";


function MilestoneAdd(){
	 
	 var $MilestoneAdd = $("#MilestoneAdd").val(); 
	 $("#myTable20").append("<tr id="+$MilestoneAdd+"><td style='background-color:#f9fae1;'><input type='text' class='form-control form-control' name='MilestoneActivity' id='MilestoneActivity"+$MilestoneAdd+"' required='required'></td><td style='background-color:#f9fae1;'><input type='number' class='form-control form-control' name='MilestoneMonth' id='MilestoneMonth"+$MilestoneAdd+"' min='0'  required='required'></td><td style='background-color:#f9fae1;'><input type='text' class='form-control form-control' name='MilestoneRemark' id='MilestoneRemark"+$MilestoneAdd+"' required='required'></td></tr>");	
	
	 
	 FimRowId=$MilestoneAdd+1;
	 $("#MilestoneAdd").val($MilestoneAdd+1); 
	 

	 
}


function MilestoneSub(rowcount){
	 
	  var rowcountid="#"+rowcount;

	 $(rowcountid).remove();
}



/* function Add(myfrm1){

    
    var fieldvalues = $("input[name='MilestoneMonth']")
  .map(function(){return $(this).val();}).get();
    
    var MilestoneMonth=0;
    for (var i = 0; i < fieldvalues.length; i++) {
    	MilestoneMonth=Number(MilestoneMonth)+Number(fieldvalues[i]);
    } 
var TotalMilestoneMonthadd=Number(ProjectScheduleMonth)+Number(MilestoneMonth);


    if(TotalMilestoneMonth>=TotalMilestoneMonthadd){
    	
    	
    }else{
    	 alert("Total Month Should Be "+TotalMilestoneMonth);	   
		 event.preventDefault();
			return false;
    }
    
  return true;
} */



</script>
</body>
</html>