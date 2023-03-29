<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.stream.Collectors, java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
#container {
  height: 400px;
}

.highcharts-figure,
.highcharts-data-table table {
  min-width: 310px;
  max-width: 800px;
  margin: 1em auto;
}

.highcharts-data-table table {
  font-family: Verdana, sans-serif;
  border-collapse: collapse;
  border: 1px solid #ebebeb;
  margin: 10px auto;
  text-align: center;
  width: 100%;
  max-width: 500px;
}

.highcharts-data-table caption {
  padding: 1em 0;
  font-size: 1.2em;
  color: #555;
}

.highcharts-data-table th {
  font-weight: 600;
  padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
  padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}

.highcharts-data-table tr:hover {
  background: #f1f7ff;
}
</style>
</head>
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
  List<Object[]> actionlist = (List<Object[]>)request.getAttribute("ActionList");
  String projectid=(String)request.getAttribute("projectid");
  List<Object[]> Actiontotal = actionlist.stream().filter(e-> e[13].toString().equalsIgnoreCase("N")).collect(Collectors.toList());
  List<Object[]> Meetingtotal = actionlist.stream().filter(e-> e[13].toString().equalsIgnoreCase("S")).collect(Collectors.toList());
  List<Object[]> Milestonestotal = actionlist.stream().filter(e-> !e[13].toString().equalsIgnoreCase("S") && !e[13].toString().equalsIgnoreCase("N")).collect(Collectors.toList());

  int Actionactive = 0;
  int ActionInprogress  = 0;
  int ActionClose  =0;

  int Meetingactive = 0;
  int MeetingInprogress  = 0;
  int MeetingClose  = 0;

  int Milestonesactive = 0;
  int MilestonesInprogress  = 0;
  int MilestonesClose  = 0;
  
   int acttotal=0;
  if(Actiontotal!=null && Actiontotal.size()>0){
	  acttotal=Actiontotal.size();
	  Actionactive = Actiontotal.stream().filter(e->e[8].toString().equalsIgnoreCase("A")).collect(Collectors.toList()).size();
	  ActionInprogress  = Actiontotal.stream().filter(e-> !e[8].toString().equalsIgnoreCase("C") && !e[8].toString().equalsIgnoreCase("A")).collect(Collectors.toList()).size();
	  ActionClose  = Actiontotal.stream().filter(e->e[8].toString().equalsIgnoreCase("C")).collect(Collectors.toList()).size();
  }
  int Meetingttl=0;
  if(Meetingtotal!=null && Meetingtotal.size()>0){
	  Meetingttl=Meetingtotal.size();
	   Meetingactive = Meetingtotal.stream().filter(e->e[8].toString().equalsIgnoreCase("A")).collect(Collectors.toList()).size();
	   MeetingInprogress  = Meetingtotal.stream().filter(e-> !e[8].toString().equalsIgnoreCase("C") && !e[8].toString().equalsIgnoreCase("A")).collect(Collectors.toList()).size();
	   MeetingClose  = Meetingtotal.stream().filter(e->e[8].toString().equalsIgnoreCase("C")).collect(Collectors.toList()).size();
  }
  int Miletotal=0;
  if(Milestonestotal!=null && Milestonestotal.size()>0){
	  Miletotal=Milestonestotal.size();
	   Milestonesactive = Milestonestotal.stream().filter(e->e[8].toString().equalsIgnoreCase("A")).collect(Collectors.toList()).size();
	   MilestonesInprogress  = Milestonestotal.stream().filter(e-> !e[8].toString().equalsIgnoreCase("C") && !e[8].toString().equalsIgnoreCase("A")).collect(Collectors.toList()).size();
	   MilestonesClose  = Milestonestotal.stream().filter(e->e[8].toString().equalsIgnoreCase("C")).collect(Collectors.toList()).size(); 
  }

 %>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  
					<div class="row">
						<h5 class="col-md-8">Action Status Reports</h5>  
							<div class="col-md-4" style="float: right; margin-top: -8px;">
							<table>
					   			<tr>
					   				<td>
					   					<label class="control-label" style="font-size: 17px;font-weight: 600; margin-bottom: .0rem;">Project : </label>
					   				</td>
					   				<td style="max-width: 500px; padding-right: 50px">
						   				<form method="post" action="ActionGraph.htm" name="ststusform" id="ststusform">
	                                         <select class="form-control selectdee " name="projectid" id="projectid" required="required"  data-live-search="true"  onchange="this.form.submit()">
	                                            <option value="A" <%if(projectid.equalsIgnoreCase("A")){ %> selected="selected" <%} %>>All</option>	
	                                             <option value="0" <%if(projectid.equalsIgnoreCase("0")){ %> selected="selected" <%} %>>General</option>	
	                                               <%for(Object[] obj:projectslist){ %>
														<option value="<%=obj[0] %>" <%if(projectid.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4] %></option>	
													<%}%>
											</select>	
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									    </form>			
									</td>
					   			</tr>
					   		</table>
					   	</div>
		   			</div>
					</div>
						<div class="card-body "> 
						<div class="row" style="margin-top: -18px;">
						<div class="col-md-6" style="float: right;" align="center">
							<figure class="highcharts-figure">
							<div id="container"></div>
							<div align="center">
								<button onclick="submitForm('M','N');" class="btn btn-sm " style="margin-right:85px;float:right; background-color: #b70000;color:white; padding: 4px 13px; "> <b><%=Miletotal%></b> </button>
		                        <button onclick="submitForm('N','N');" class="btn btn-sm " style="margin-left:-55px;margin-right:80px;background-color: #cd3a66;color:white; padding: 4px 13px; "> <b> <%=acttotal%></b> </button>
		                        <button onclick="submitForm('S','N');" class="btn btn-sm " style="margin-left:59px;margin-right: -60px; background-color: #8544b1;color:white; padding: 4px 13px; "> <b><%=Meetingttl%></b> </button>
	                      	</div>
							</figure>
						</div>
		</div></div></div></div>					
</div>
</div>
<form action="ActionReportSubmit.htm" id="submitform" method="post">
	<input type="hidden" name="Project" id="PROJECTID">
	<input type="hidden" name="Type" id="TYPE">
	<input type="hidden" name="Term" id="STATUS">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
</form>
<script type="text/javascript">
Highcharts.chart('container', {
	  chart: {
	    type: 'column'
	  },
	  title: {
	    text: 'Action Graph ',
	    align: 'center'
	  },
	  xAxis: {
	    categories: ['Action', 'Meeting', 'Milestone']
	  },
	  yAxis: {
	    min: 0,
	    title: {
	      text: 'Count of Action'
	    },
	    stackLabels: {
	      enabled: true,
	      style: {
	        fontWeight: 'bold',
	        color: ( 
	          Highcharts.defaultOptions.title.style &&
	          Highcharts.defaultOptions.title.style.color
	        ) || 'gray',
	        textOutline: 'none'
	      }
	    }
	  },
	  legend: {
	    align: 'left',
	    x: 70,
	    verticalAlign: 'top',
	    y: 70,
	    floating: true,
	    backgroundColor:
	      Highcharts.defaultOptions.legend.backgroundColor || 'white',
	    borderColor: '#CCC',
	    borderWidth: 1,
	    shadow: true
	  },
	  tooltip: {
	    headerFormat: '<b>{point.x}</b><br/>',
	    pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
	  },
	  plotOptions: {
	    column: {
	      stacking: 'normal',
	      dataLabels: {
	        enabled: true
	      }
	    }
	  },
	  series: [{
	    name: 'Active',
	    data: [<%=Actionactive%>,<%=Meetingactive%>, <%=Milestonesactive%>]
	  }, {
	    name: 'In-progress',
	    data: [<%=ActionInprogress%>, <%=MeetingInprogress%>, <%=MilestonesInprogress%>]
	  }, {
	    name: 'Closed',
	    data: [<%=ActionClose%>, <%=MeetingClose%>, <%=MilestonesClose%>]
	  }]
	});
	
function submitForm(type, status)
{ 
	var project=$("#projectid").val();
   $("#PROJECTID").val(project);
   $("#TYPE").val(type);
   $("#STATUS").val(status);
   document.getElementById('submitform').submit(); 
}
</script>
</body>
</html>