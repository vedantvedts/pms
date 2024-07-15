<%@page import="org.apache.xpath.operations.Plus"%>
<%@page import="org.jfree.chart.axis.MonthDateFormat"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Meeting Reports</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}

th ,td {
	border: 1px solid black;
}


</style>
</head>
 
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  SimpleDateFormat sdf1=fc.getSqlDateFormat();
		  
 
  String rtype=(String)request.getAttribute("rtype");
  String empid=(String)request.getAttribute("empid");
  
  LocalDate fromdate=(LocalDate)request.getAttribute("fromdate");
  LocalDate todate=(LocalDate)request.getAttribute("todate");
  
  List<Object[]> employeeList=(List<Object[]>) request.getAttribute("employeeList");
  List<Object[]> employeeScheduleList=(List<Object[]>) request.getAttribute("employeeScheduleList");
  
  
 %>



<% String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
 if(ses1!=null){%>
		<div align="left" class="alert alert-danger" role="alert" >
        	<%=ses1 %>
        </div>
	<%}if(ses!=null){ %>
		<div align="left"  class="alert alert-success" role="alert"  >
        	<%=ses %>
        </div>
    <%} %>

  
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  
						<div class="row">
							<h4 class="col-md-3">Schedule Reports</h4>  
							
			   			</div>	   							
					</div>
					<div class="card-body">
					
					<div class="row" >
						<div class="col-md-12">
							<form method="post" action="EmployeeScheduleReports.htm" >
							<table style="margin-bottom: 10px;" >
								<tr>
									<td style="border: 0px;"><label class="control-label" style="font-size: 17px;margin-right : 20px ">Employee: </label></td>
					                <td style="border: 0px;">
					                	<select class="form-control selectdee" name="empid" id="empid" required="required" onchange="this.form.submit();"  >
											<%for(Object[] obj :employeeList){ %>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(empid)){ %>selected="selected" <%} %>  ><%=obj[1] %>, <%=obj[2] %></option>
											<%} %>
										 </select>
									</td>	
						   			<td style="border: 0px;"><label class="control-label" style="font-size: 17px;margin-left: 10px;margin-right:15px;" >Type: </label></td>
						            <td style="border: 0px;">
						            	<select class="form-control select2" name="rtype" id="rtype" style="width: 100%;"    onchange="reportTypeChange();"  required="required">
											<option value="D" <%if("D".equalsIgnoreCase(rtype)){ %> selected="selected" <%} %>>Daily</option>	
											<option value="W" <%if("W".equalsIgnoreCase(rtype)){ %> selected="selected" <%} %>>Weekly</option>	
											<option value="M" <%if("M".equalsIgnoreCase(rtype)){ %> selected="selected" <%} %> >Monthly</option>		
										</select>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</td>
						
							<!-- --------------------------------------------- -->		
									<%if(rtype.equalsIgnoreCase("D")){ %>
									<td class = "daily"  style="border: 0px;"><label class="control-label " style="font-size: 17px;margin :0px 20px; ">Date: </label></td>
				                    <td class = "daily" style="border: 0px;">
				                    	<input  class="form-control"  data-date-format="dd/mm/yyyy" id="dfromdate" name="dfromdate"  value=" <%=sdf.format(sdf1.parse(fromdate.toString()))%> " required="required" readonly="readonly">
									</td>
									<%}else { %>
									<td class = "daily"  style="border: 0px;"><label class="control-label " style="font-size: 17px;margin :0px 20px; ">Date: </label></td>
				                    <td class = "daily" style="border: 0px;">
				                    	<input  class="form-control"  data-date-format="dd/mm/yyyy" id="dfromdate" name="dfromdate"  value=" <%=sdf.format(sdf1.parse(LocalDate.now().toString()))%> "  required="required" readonly="readonly">
									</td>
									<%} %>
							<!-- --------------------------------------------- -->		
									<%if(rtype.equalsIgnoreCase("W")){ %>
									<td class = "weekly"  style="border: 0px;"><label class="control-label " style="font-size: 17px;margin :0px 10px; ">From: </label></td>
				                    <td class = "weekly" style="border: 0px;">
				                    	<input  class="form-control"  data-date-format="dd/mm/yyyy" id="wfromdate" name="wfromdate"  value=" <%=sdf.format(sdf1.parse(fromdate.toString()))%> " onchange ="todatechangew()" required="required" readonly="readonly">
									</td>
									<td class = "weekly" style="border: 0px;"><label class="control-label" style="font-size: 17px;margin :0px 10px; ">To:</label></td>
				                    <td class = "weekly" style="border: 0px;">
				                    	<input  class="form-control"  data-date-format="dd/mm/yyyy" id="wtodate" name="wtodate"  required="required" readonly="readonly" onchange ="todatechangew()" value=" <%=sdf.format(sdf1.parse(todate.toString()))%>">
									</td>
									<%}else {  %>
									<td class = "weekly"  style="border: 0px;"><label class="control-label " style="font-size: 17px;margin :0px 10px; ">From: </label></td>
				                    <td class = "weekly" style="border: 0px;">
				                    	<input  class="form-control"  data-date-format="dd/mm/yyyy" id="wfromdate" name="wfromdate"  value=" <%=sdf.format(sdf1.parse(LocalDate.now().toString()))%> " onchange ="todatechangew()" required="required" readonly="readonly">
									</td>
									<td class = "weekly" style="border: 0px;"><label class="control-label" style="font-size: 17px;margin :0px 10px; ">To:</label></td>
				                    <td class = "weekly" style="border: 0px;">
				                    	<input  class="form-control"  data-date-format="dd/mm/yyyy" id="wtodate" name="wtodate"  required="required" readonly="readonly" onchange="todatechangew()" value=" <%=sdf.format(sdf1.parse(LocalDate.now().plusWeeks(1).toString()))%>">
									</td>
									
									
									<%} %>
									
							<!-- --------------------------------------------- -->		
									<%String month=fromdate.getMonth().toString().substring(0, 1).toUpperCase()+ fromdate.getMonth().toString().substring(1).toLowerCase(); %>
									<%if(rtype.equalsIgnoreCase("M")){ %>
									<td class = "monthly"  style="border: 0px;"><label class="control-label " style="font-size: 17px;margin :0px 20px; ">Month: </label></td>
				                    <td class = "monthly" style="border: 0px;">
				                    	<input  class="form-control"  id="mfromdate" name="mfromdate"  value="<%=month %>-<%=fromdate.getYear() %>" required="required" readonly="readonly">
									</td>
									<%}else{ %>
									<% month=LocalDate.now().getMonth().toString().substring(0, 1).toUpperCase()+ LocalDate.now().getMonth().toString().substring(1).toLowerCase(); %>
									<td class = "monthly"  style="border: 0px;"><label class="control-label " style="font-size: 17px;margin :0px 20px; ">Month: </label></td>
				                    <td class = "monthly" style="border: 0px;">
				                    	<input  class="form-control"  id="mfromdate" name="mfromdate"  value="<%=month %>-<%=LocalDate.now().getYear() %>" required="required" readonly="readonly">
									</td>
									<%} %>	
							<!-- --------------------------------------------- -->
									<td style="border: 0px;">
										<button type="submit" class="btn btn-sm btn-primary submit" style="margin-left: 10px;" >SUBMIT</button>
									</td>
								
								</tr>
							</table>
							</form>
							
							
						</div>
						
					</div> 

					</div>			
				</div>
			</div>
		</div>	
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-body">
					
						<div class="row">
							<div class="col-md-11">
								<% if(rtype.equalsIgnoreCase("D"))
								{ %>	
									<b style="padding-left: 4rem; font-size: 2rem;">	
										<%=fromdate.getDayOfWeek() %>,
										<%=fromdate.getMonth() %>
										<%=fromdate.getDayOfMonth() %>,
										<%=fromdate.getYear() %>
									</b>								
								<%} 
								else if(rtype.equalsIgnoreCase("W"))
								{ %>	
									<b style="padding-left: 4rem; font-size: 2rem;">	
										<%=sdf.format(sdf1.parse(fromdate.toString()))%> &nbsp;-&nbsp; <%=sdf.format(sdf1.parse(todate.toString()))%>
									</b>
								<%}else if(rtype.equalsIgnoreCase("M"))
								{ %>
									<b style="padding-left: 4rem; font-size: 2rem;">	
										<%=fromdate.getMonth() %>,&nbsp;<%=fromdate.getYear() %>
									</b>							
								<%} %>
							</div>
							<div class="col-md-1">
							
								
								
								<form method="post" action="EmployeeScheduleReportDownload.htm" target="_blank" > 
									<button type="submit" class="btn  btn-sm view" style="background-color: white;" >
										<i class="fa fa-download fa-2x" aria-hidden="true" ></i>
									</button>
								
									<input type="hidden" name="empid" value="<%=empid%>">
									<input type="hidden" name="rtype" value="<%=rtype%>">
									<%if(rtype.equalsIgnoreCase("M")){ %>
									<input type="hidden" name="<%=rtype.toLowerCase()%>fromdate" value="<%=month %>-<%=fromdate.getYear() %>">
									<%}else{ %>
									<input type="hidden" name="<%=rtype.toLowerCase()%>fromdate" value="<%=sdf.format(sdf1.parse(fromdate.toString()))%>">
									<%} %>
									<input type="hidden" name="<%=rtype.toLowerCase()%>todate" value="<%=sdf.format(sdf1.parse(todate.toString()))%>">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</form>
							</div>
						</div> 
<!-- ---------------------------------------------daily report ------------------------------------------- -->
					<% if(rtype.equalsIgnoreCase("D")){ %>						
						<div class="row">
							<div class="col-md-12">	
									<table style=" border-collapse: collapse;max-width:88rem; ">
										<tr>
											<th style="width : 8rem;text-align: center;" >
												Time slot
											</th>
											<th style="text-align: center; width: 80rem;" >
												Meeting
											</th>
										</tr>
										<%
										LocalTime starttime=LocalTime.parse( "08:00:00" );
										LocalTime endtime=LocalTime.parse( "09:00:00" );
										for(int i=8;i<17;i++)
										{ 
										%>
										<tr>
											<td style="padding: 15px 0px;" align="center">
												<%=starttime %> - <%=endtime %> 
											</td>
											<td style="padding-left: 15px;padding-top: 5px;padding-bottom: 5px;" >
												<%for(Object[] obj:employeeScheduleList){ 
													LocalTime target = LocalTime.parse( obj[3].toString()) ;
													if (( target.isAfter( starttime ) || target.equals( starttime )  )  &&   target.isBefore( endtime ) ) 
													{ %>	
													
														<%=obj[4] %> &nbsp;-&nbsp; <%=obj[1] %> &nbsp;-&nbsp; <%=target %> 	&nbsp;-&nbsp; <%=obj[6] %> 	<br>
																												
													<%}%>
												<%} %>
											</td>
										</tr>
										<%	starttime=starttime.plusHours(1);
											endtime=endtime.plusHours(1);
										} %>
										
									</table>
								
							</div>						
						</div>					
						<%} %>
<!-- --------------------------------------------- daily report ------------------------------------------- -->
<!-- --------------------------------------------- weekly report ------------------------------------------- -->
						<% if(rtype.equalsIgnoreCase("W")){ %>						
						<div class="row">
							<div class="col-md-12">	
								
									<table style=" border-collapse: collapse;max-width:88rem; ">
										<tr>
											<th style="min-width : 8rem;text-align: center;" >
												Time slot
											</th>
											<% LocalDate fromdate1=LocalDate.parse(fromdate.toString());
												LocalDate todate1=LocalDate.parse(todate.toString());
											for(;fromdate1.isBefore(todate)||fromdate1.isEqual(todate);fromdate1=fromdate1.plusDays(1) ){ %>
											<th style="text-align: center;min-width : 10rem; max-width: 10rem;" >
												
													<%=fromdate1.getDayOfMonth() %>,
													<%=fromdate1.getDayOfWeek()%>
												
											</th>
											<%} %>
										</tr>
										<% 	LocalTime starttime=LocalTime.parse( "08:00:00" );
											LocalTime endtime=LocalTime.parse( "09:00:00" );
											for(int i=8;i<17;i++)
											{ %>
										
										<tr>
											<td style="padding: 15px 0px;" align="center">
												<%=starttime %> - <%=endtime %> 
											</td>
											<%  fromdate1=LocalDate.parse(fromdate.toString());
												todate1=LocalDate.parse(todate.toString());
											for(;fromdate1.isBefore(todate)||fromdate1.isEqual(todate);fromdate1=fromdate1.plusDays(1) ){ %>
											<td style="padding-left: 15px;padding-top: 5px;padding-bottom: 5px; word-wrap:break-word;" >
											
												<%  for(Object[] obj:employeeScheduleList){ 
													LocalTime targettime = LocalTime.parse( obj[3].toString()) ;
													LocalDate targetdate = LocalDate.parse( obj[2].toString()) ;
													if (( targettime.isAfter( starttime ) || targettime.equals( starttime )  )  &&   targettime.isBefore( endtime ) && targetdate.equals(fromdate1) ) 
													{ %>	
													
														<%=obj[4] %> &nbsp;-&nbsp; <%=targettime%> 	<br>
																												
													<%}%>
												<%} %>
											</td>
											<%} %>
										</tr>
										<%	starttime=starttime.plusHours(1);
											endtime=endtime.plusHours(1);
										} %>
										
									</table>
								</div>						
							</div>					
							<%} %>
<!-- --------------------------------------------- weekly report ------------------------------------------- -->			
<!-- --------------------------------------------- monthly report ------------------------------------------- -->
							
							<% if(rtype.equalsIgnoreCase("M")){
								ArrayList<LocalDate> monthdays=(ArrayList<LocalDate>) request.getAttribute("monthdays");
								List<String> daysOfWeek = Arrays.asList("SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY")  ;  
							%>			
							
							<div class="row">
								<div class="col-md-12">	
										<table style=" border-collapse: collapse;max-width:88rem; ">
											<tr>
												<th style="width: 180px;text-align: center;">Sunday</th>
												<th style="width: 180px;text-align: center;">Monday</th>
												<th style="width: 180px;text-align: center;">Tuesday</th>
												<th style="width: 180px;text-align: center;">Wednesday</th>
												<th style="width: 180px;text-align: center;">Thursday</th>
												<th style="width: 180px;text-align: center;">Friday</th>
												<th style="width: 180px;text-align: center;">Saturday</th>
											</tr>
											<%int  temp=0,count=0;
											for(int j=1;j<7;j++){ %>
												<%if(temp<monthdays.size() ){ %>
												<tr style=" height:120px; ">	
													<%for(int i=0;i<7;i++){ %>
														<td style="padding: 5px; text-align:center;word-wrap:break-word;vertical-align: top; " > 
															<%if(count==1 && temp<monthdays.size() ){ %>
																	<b><%=sdf.format(sdf1.parse(monthdays.get(temp).toString())) %></b>
																	
																	<%for(int k=0;k<employeeScheduleList.size();k++)
																	{ Object[] obj=employeeScheduleList.get(k);
																		if(LocalDate.parse(obj[2].toString()).isEqual(monthdays.get(temp)))
																		{%>
																			<br><%=obj[4] %> &nbsp;-&nbsp;  <%=obj[3] %> 
																	<%	
																		}
																	}%>
															<% temp++;
															}else if( temp<monthdays.size() && daysOfWeek.get(i).trim().equalsIgnoreCase(monthdays.get(temp).getDayOfWeek().toString().trim())) 
															{ 
																count=1; %>
																<b><%=sdf.format(sdf1.parse(monthdays.get(temp).toString())) %></b><br>
																	
																	<%for(int k=0;k<employeeScheduleList.size();k++)
																	{ Object[] obj=employeeScheduleList.get(k);
																		if(LocalDate.parse(obj[2].toString()).isEqual(monthdays.get(temp)))
																		{%>
																			<br><%=obj[4] %> &nbsp;-&nbsp;  <%=obj[3] %> 
																	<%	
																		}
																	}%>
															<%temp++; 
															} %>
														</td>
													<%  } %>
												</tr>
												<%} %>
											<%} %>						
										</table>
									</div>						
								</div>					
								<%} %>
<!-- --------------------------------------------- monthly report ------------------------------------------- -->						
					</div>
				</div>
			</div>
		</div>
	</div>

					
<script type="text/javascript">

$( document ).ready( reportTypeChange() );

function reportTypeChange()
{
	var $rtype= $('#rtype').val();
	
	if($rtype==='D')
	{
		$('.daily').show();
		$('.weekly').hide();
		$('.monthly').hide();
		

		$('#dfromdate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
		
		
	}
	else if($rtype==='W')
	{ 
		$('.weekly').show();
		$('.daily').hide();
		$('.monthly').hide();
		
		$('#wfromdate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
		
		
	}
	else if($rtype==='M')
	{
		$('.monthly').show();
		$('.daily').hide();
		$('.weekly').hide();
		
		$("#mfromdate").datepicker( {
		    format: "MM-yyyy",
		    startView: "months", 
		    minViewMode: "months"
		    
		});
	}
}


function todatechangew()
{
	
	var $fromdate= $('#wfromdate').val();
	var $fromdate1=$fromdate.split("-").reverse().join("/");	
	var $now = new Date($fromdate1);
	
		$now.setDate($now.getDate() + 6);
	
		$('#wtodate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"cancelClass" : "btn-default",
			"startDate" :  $now ,
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

} 
</script>


</body>
</html>