<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Map"%>
<%@page import="com.vts.pfms.master.model.Employee"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Employee Report</title>

<style >
@charset "UTF-8";
@page {             
    size: 1120px 790px;
     margin-top: 30px;
     margin-left: 39px;
     margin-right: 39px;
     margin-buttom: 49px; 	 
}
.report-font{
		 font-family: Arial, Helvetica, sans-serif!important;
}
</style>
<%
List<Object[]> employeeList = (List<Object[]>)request.getAttribute("roleWiseEmployeeList");
List<Employee> allEmpList = (List<Employee>) request.getAttribute("allEmployeeList");

String empIad = (String)request.getAttribute("empId");
String[] empIds = (String[])request.getAttribute("empIds");
String fromDate = (String)request.getAttribute("fromDate");
String toDate = (String)request.getAttribute("toDate");

Map<String,List<Object[]>> allEmpReportList = (Map<String,List<Object[]>>)request.getAttribute("allEmpReportList");

String viewFlag = (String)request.getAttribute("viewFlag");
viewFlag = viewFlag == null? "W":viewFlag;

FormatConverter fc = new FormatConverter();

String fromDateR = fc.sdfTordf(fromDate);
String toDateR = fc.sdfTordf(toDate);
%>
</head>
<body>
	<div class="container-fluid report-font">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div align="center">
                    <h4>All Employee Report</h4>
                </div>
                <div align="right">
                	<p><b>From :</b> <%= fromDateR %> <b style="padding-left: 20px;">To :</b> <%= toDateR %></p>
                	
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table " style="border:1px solid black; border-collapse: collapse;">
                            <thead > 
                                <tr>
                                    <th style="border:1px solid black; padding: 10px;width: 5%; background: #2983c0; color:white;">SN</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Date</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Activity No</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Activity Type</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Project</th>
                                    <th style="border:1px solid black; padding: 10px;width: 15%; background: #2983c0; color:white;">Assigner</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Keywords</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Work Done</th>
                                    <th style="border:1px solid black; padding: 10px;width: 10%; background: #2983c0; color:white;">Work Done on</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (allEmpReportList != null && !allEmpReportList.isEmpty()) {
                                    int slno = 0;
                                    for (Map.Entry<String, List<Object[]>> map : allEmpReportList.entrySet()) {
                                        String empId = map.getKey();
                                        List<Object[]> values = map.getValue();
                                        
                                        Map<String,List<Object[]>> valuesbasedonId = values.stream().collect(Collectors.groupingBy(obj -> obj[0].toString(),LinkedHashMap::new,Collectors.toList()));
							            
                                        Object[] emp = employeeList.stream()
                                            .filter(e -> empId.equalsIgnoreCase(String.valueOf(e[0])))
                                            .findFirst().orElse(null);
                                %>
                                <!-- Employee Header -->
                                <tr  class="table-secondary text-center">
                                    <td colspan="9" align="center" style="border:1px solid black; padding: 15px; background: #c8e0fb;">
                                        <%= emp != null ? 
                                            ((emp[1] != null ? emp[1] : "") + " " + 
                                             (emp[5] != null ? emp[5] : "") + ", " + 
                                             (emp[6] != null ? emp[6] : "")) 
                                            : "-" %>
                                    </td>
                                </tr>
                                <% if (values == null || values.isEmpty()) { %>
                                    <tr>
                                        <td colspan="9" align="center" style="border:1px solid black; padding: 10px;">No Data Available</td>
                                    </tr>
                                <% } else {
                                	for(Map.Entry<String,List<Object[]>> map2 : valuesbasedonId.entrySet()){
						            	
							            List<Object[]> values2 = map2.getValue();
						           int i=0;
                                    for (Object[] obj : values2) {
                                %>
                                <tr>
                                	<%if(i==0) {%>
										<td rowspan="<%=values2.size() %>" align="center" style="border:1px solid black; padding: 10px;"><%=++slno%></td>
							    		<td rowspan="<%=values2.size() %>" align="center" style="border:1px solid black; padding: 10px;"><%=obj[2]!=null?fc.sdfTordf(obj[2].toString()):"" %></td>
       								<%} %>
                                    <%-- <td align="center" style="border:1px solid black; padding: 10px;"><%= ++slno %></td>
                                    <td align="center" style="border:1px solid black; padding: 10px;"><%= obj[2] != null ? fc.sdfTordf(obj[2].toString()) : "" %></td> --%>
                                    <td align="center" style="border:1px solid black; padding: 10px;"><%= obj[16] != null ? obj[16] : "-" %></td>
                                    <td style="border:1px solid black; padding: 10px;"><%= obj[5] != null ? obj[5] : "-" %></td>
                                    <td align="center" style="border:1px solid black; padding: 10px;"><%= obj[8] != null ? obj[8] : "-" %></td>
                                    <td style="border:1px solid black; padding: 10px;"><%= obj[10] != null ? obj[10] + ", " + (obj[11] != null ? obj[11] : "-") : "Not Available" %></td>
                                    <td align="center" style="border:1px solid black; padding: 10px;"><%= obj[13] != null ? obj[13] : "-" %></td>
                                    <td style="border:1px solid black; padding: 10px;"><%= obj[14] != null ? obj[14].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") : "-" %></td>
                                    <td align="center" style="border:1px solid black; padding: 10px;"><%= obj[15] != null ? 
                                        ("A".equalsIgnoreCase(obj[15].toString()) ? "AN" :
                                        "F".equalsIgnoreCase(obj[15].toString()) ? "FN" : "Full day") : "-" %></td>
                                </tr>
                                <% i++;} } } } }else { %>
                                <tr>
                                    <td colspan="9" align="center" style="border:1px solid black; padding: 10px;">No Data Available</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>