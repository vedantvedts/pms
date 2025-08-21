<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<title>Schedule Report</title>
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
  
  String employeedata=null;
  for(Object[] obj : employeeList){
	if(obj[0].toString().equalsIgnoreCase(empid)){
		employeedata = obj[1]+" ("+obj[2]+")";
	}
  }
  
 %>
<style type="text/css">

p{
  text-align: justify;
  text-justify: inter-word;
}



.break
	{
		page-break-after: always;
	} 
              
 
@page {             
          size: landscape ;
          margin-top: 40px;
          margin-left: 30px;
          margin-right: 30px;
          margin-buttom: 40px; 	
          border: 1px solid black;    
          
         @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 10px;
             margin-right: 10px;
           }
         @top-left {
          	margin-top: 10px;
            margin-left: 10px;
            content: "Schedule Report";
          }   
          
         @top-right {          		
             margin-top: 10px;
             margin-right: 10px;
             <%if(rtype.equalsIgnoreCase("D"))
             {%>
             content: "<%=sdf.format(sdf1.parse(fromdate.toString()))%>";
             <%}
             else 
             {%>
             content: "<%=sdf.format(sdf1.parse(fromdate.toString()))%> - <%=sdf.format(sdf1.parse(todate.toString()))%>";
             <%}%>
          }                  
          
        
 }

 .sth
 {
 	   font-size: 16px;
 	   border: 1px solid black;
 }
 
 .std
 {
 	text-align: center;
 	border: 1px solid black;
 }
 

label{
font-weight: bold;
  font-size: 13px;
}


th ,td {
	border: 1px solid black;
}

table {

 }

</style>
</head>
 
<body>
 
			<div id="pageborder" class="firstpage" id="firstpage">
<!-- ---------------------------------------------daily report ------------------------------------------- -->
					<% if(rtype.equalsIgnoreCase("D")){ %>						
						<div style="margin-left: 15px;">
									<div align="left" style="margin-top: 15px;margin-bottom: 10px;">
										<b style="padding-left: 100px; font-size: 32px;">	
											<%=employeedata!=null?StringEscapeUtils.escapeHtml4(employeedata): " - " %> &nbsp;&nbsp;  - &nbsp;&nbsp;
											<%=sdf.format(sdf1.parse(fromdate.toString())) %>
										</b>
									</div>
									<table style=" border-collapse: collapse;max-width:1030px;max-height : 650px;"  >
										<tr>
											<th style="min-width : 100px;text-align: center;" >
												Time slot
											</th>
											<th style="text-align: center;min-width: 930px;max-width: 930px;" >
												Meeting
											</th>
										</tr>
										<%
										LocalTime starttime=LocalTime.parse( "08:00:00" );
										LocalTime endtime=LocalTime.parse( "09:00:00" );
										for(int i=8;i<18;i++)
										{ 
										%>
										<tr>
											<td style="padding: 15px 0px;" >
												<%=starttime %> - <%=endtime %> 
											</td>
											<td style="padding-left: 5px;padding-top: 5px;padding-bottom: 5px;" >
												<%for(Object[] obj:employeeScheduleList){ 
													LocalTime target = LocalTime.parse( obj[3].toString()) ;
													if (( target.isAfter( starttime ) || target.equals( starttime )  )  &&   target.isBefore( endtime ) ) 
													{ %>	
													
														<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %> &nbsp;-&nbsp; <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %> &nbsp;-&nbsp; <%=target %> 	&nbsp;-&nbsp; <%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%> 	<br>
																												
													<%}%>
												<%} %>
											</td>
										</tr>
										<%	starttime=starttime.plusHours(1);
											endtime=endtime.plusHours(1);
										} %>
										
									</table>
								</div>
											
						<%} %>
<!-- --------------------------------------------- daily report ------------------------------------------- -->
<!-- --------------------------------------------- weekly report ------------------------------------------- -->
						<% if(rtype.equalsIgnoreCase("W")){ %>						
						<div style="margin-left: 15px;">
									<div align="left" style="margin-top: 15px;margin-bottom: 10px;">
										<b style="padding-left: 100px; font-size: 32px;">	
											<%=employeedata!=null?StringEscapeUtils.escapeHtml4(employeedata): " - " %> &nbsp;&nbsp;  - &nbsp;&nbsp;
											<%=sdf.format(sdf1.parse(fromdate.toString()))%> &nbsp;to&nbsp; <%=sdf.format(sdf1.parse(todate.toString()))%>
										</b>
									</div>
									
									<table style=" border-collapse: collapse;max-width:1030px;max-height : 650px;"  >
										<tr>
											<th style="max-width : 100px;text-align: center;" >
												Time slot
											</th>
											<% LocalDate fromdate1=LocalDate.parse(fromdate.toString());
												LocalDate todate1=LocalDate.parse(todate.toString());
											for(;fromdate1.isBefore(todate)||fromdate1.isEqual(todate);fromdate1=fromdate1.plusDays(1) ){ %>
											<th style="text-align: center;min-width : 130px; max-width: 130px;" >
												
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
											<td style="padding: 5px; word-wrap:break-word;" >
											
												<%  for(Object[] obj:employeeScheduleList){ 
													LocalTime targettime = LocalTime.parse( obj[3].toString()) ;
													LocalDate targetdate = LocalDate.parse( obj[2].toString()) ;
													if (( targettime.isAfter( starttime ) || targettime.equals( starttime )  )  &&   targettime.isBefore( endtime ) && targetdate.equals(fromdate1) ) 
													{ %>	
													
														<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %> &nbsp;-&nbsp; <%=targettime%> 	<br>
																												
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
							<%} %>
<!-- --------------------------------------------- weekly report ------------------------------------------- -->			
<!-- --------------------------------------------- monthly report ------------------------------------------- -->
							<% if(rtype.equalsIgnoreCase("M")){
								ArrayList<LocalDate> monthdays=(ArrayList<LocalDate>) request.getAttribute("monthdays");
								List<String> daysOfWeek = Arrays.asList("SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY")  ;  
							%>						
							<div style="margin-left: 15px;">
										<div align="left" style="margin-top: 15px;margin-bottom: 10px;">
										<b style="padding-left: 100px; font-size: 32px;">	
												<%=employeedata!=null?StringEscapeUtils.escapeHtml4(employeedata): " - " %> &nbsp;&nbsp;  - &nbsp;&nbsp;
											<%=fromdate.getMonth() %>,&nbsp;<%=fromdate.getYear() %>
										</b>
									</div>
										<table style=" border-collapse: collapse;max-width:1030px;max-height : 650px;"  >
											<tr>
												<th style="width: 145px;text-align: center;">Sunday</th>
												<th style="width: 145px;text-align: center;">Monday</th>
												<th style="width: 145px;text-align: center;">Tuesday</th>
												<th style="width: 145px;text-align: center;">Wednesday</th>
												<th style="width: 145px;text-align: center;">Thursday</th>
												<th style="width: 145px;text-align: center;">Friday</th>
												<th style="width: 145px;text-align: center;">Saturday</th>
											</tr>
											<%int  temp=0,count=0;
											for(int j=1;j<7;j++){ %>
											<%if(temp<monthdays.size() ){ %>
												<tr style=" min-height:120px; ">	
													<%for(int i=0;i<7;i++){ %>
														<td style="padding: 5px; word-wrap:break-word; vertical-align: top;" >
															<%if(count==1 && temp<monthdays.size()){ %>
																	<b><%=sdf.format(sdf1.parse(monthdays.get(temp).toString())) %></b>
																	
																	<%for(int k=0;k<employeeScheduleList.size();k++)
																	{ Object[] obj=employeeScheduleList.get(k);
																		if(LocalDate.parse(obj[2].toString()).isEqual(monthdays.get(temp)))
																		{%>
																			<br><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %> &nbsp;-&nbsp;  <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %> 
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
																			<br><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %> &nbsp;-&nbsp;  <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %> 
																	<%	
																		}
																	}%>
															<%temp++; 
															} %>
														</td>
													<% } %>
												</tr>	
												<%} %>
											<%} %>						
										</table>
														
										</div>	
								<%} %>
<!-- --------------------------------------------- monthly report ------------------------------------------- -->						
						</div>	

</body>
</html>