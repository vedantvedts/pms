<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>P&C DO ADD</title>
<spring:url value="/resources/css/admin/Rtmddo2.css" var="rtmddo2" />
<link href="${rtmddo2}" rel="stylesheet" />
</head>
<body>
      
 <%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
List<Object[]> Rtmddo=(List<Object[]>) request.getAttribute("RtmddoList");
NFormatConvertion nfc=new NFormatConvertion();
List<Object[]> pdomtrt=(List<Object[]>)request.getAttribute("presentEmpList");
Map<Object, List<Object[]>> map=new HashMap<>(); 
if(pdomtrt!=null&&pdomtrt.size()>0){
map = pdomtrt.stream().collect(Collectors.groupingBy(c -> c[4])); 
}
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
	<div class="row">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header bg-header" >
                    <b class="text-white">P&C DO/AD</b>
        		</div>
                                   
        		<div class="card-body">
        			<div align="center" > <label >P&C DO</label></div>
        		  <form action="RtmddoSubmit.htm" method="POST" name="myfrm" id="myfrm" onsubmit="return confirm('Are you sure to submit');" > 	 						
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                 	                   		
                		<div class="row"> 
                		<div class="col-md-1"></div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Name</label>
                              		<select class="form-control selectdee" id="EmpId" required="required" name="EmpId"  ">
    									<option disabled="true"  selected="selected"  value="">Select </option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>" <%if(pdomtrt!=null&& map.get("DO-RTMD")!=null && obj[0].toString().equals(map.get("DO-RTMD").get(0)[1].toString())){%> selected="selected" <%} %> ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>,  <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid From</label>
    					            <input class="form-control " name="ValidFrom" id="DateCompletion1" required="required" <%if(pdomtrt!=null&&  map.get("DO-RTMD")!=null ){ %> value="<%=sdf.format(map.get("DO-RTMD").get(0)[2])%>"<%} %> readonly="readonly" onchange="onDate()">
                        		</div>
                    		</div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid To</label>
    					            <input class="form-control " name="ValidTo" id="DateCompletion2" <%if(pdomtrt!=null&&  map.get("DO-RTMD")!=null ){ %> value="<%=sdf.format(map.get("DO-RTMD").get(0)[3])%>"<%} %> readonly="readonly" required="required"  >
                        		</div>
                    		</div>
                    	   
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label"></label>
                            		     		<input type="hidden" name="type" value="DO-RTMD"/>
                                         <button class="btn submit m-top" type="submit">Submit</button> 
                        		</div>
                    		</div>
          
                        </div>
                        </form>
                      <br>	
                   <div align="center" > <label>AD</label></div>
        		  <form action="RtmddoSubmit.htm" method="POST" name="myfrm1" id="myfrm1"  onsubmit="return confirm('Are you sure to submit');"> 	 						
               	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                   <div class="row"> 
                		<div class="col-md-1"></div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Name</label>
                              		<select class="form-control selectdee" id="EmpId2" required="required" name="EmpId">
    									<option disabled="true"  selected="selected" value="">Select </option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>" <%if(pdomtrt!=null&& map.get("AD")!=null &&obj[0].toString().equals(map.get("AD").get(0)[1].toString())){ %> selected="selected" <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>,  <%=obj[2] !=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid From</label>
    					            <input class="form-control " name="ValidFrom" id="DateCompletion3" <%if(pdomtrt!=null&& map.get("AD")!=null){ %> value="<%=sdf.format(map.get("AD").get(0)[2])%>"<%} %> required="required" readonly="readonly"  onchange="onDate1()">
                        		</div>
                    		</div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid To</label>
    					            <input class="form-control " name="ValidTo" id="DateCompletion4" <%if(pdomtrt!=null&&map.get("AD")!=null){ %> value="<%=sdf.format(map.get("AD").get(0)[3])%>"<%} %> readonly="readonly" required="required"  >
                        		</div>
                    		</div> 
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label"></label>
                            		<input type="hidden" name="type" value="AD"/>
                                         <button class="btn submit m-top" type="submit" >Submit</button> 
                        		</div>
                    		</div>        		
                        </div>  
                        </form>      
	 		      <br>
	  </div>
	
 		
		<div class="card-footer bg-footer" >
  </div>             
</div>        
</div>
</div>
</div>
	
	
<script type="text/javascript">



$('#DateCompletion1, #DateCompletion3').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});


  
     function onDate() {
        
    	 var from = $("#DateCompletion1").val().split("-")
    	 var year=Number(from[2])+5;
  		 var f = new Date(year, from[1] - 1, from[0]);

        $('#DateCompletion2').daterangepicker({
        	"singleDatePicker" : true,
        	"linkedCalendars" : false,
        	"showCustomRangeLabel" : true,
        	"cancelClass" : "btn-default",
        	"minDate" : f,
        	"maxDate" : f,
        	showDropdowns : true,
        	locale : {
        		format : 'DD-MM-YYYY'
        	}
        });
        
    }
     
     function onDate1() {
         
    	 var from = $("#DateCompletion3").val().split("-")
    	 var year=Number(from[2])+5;
  		 var f = new Date(year, from[1] - 1, from[0]);

        $('#DateCompletion4').daterangepicker({
        	"singleDatePicker" : true,
        	"linkedCalendars" : false,
        	"showCustomRangeLabel" : true,
        	"cancelClass" : "btn-default",
        	"minDate" : f,
        	"maxDate" : f,
        	showDropdowns : true,
        	locale : {
        		format : 'DD-MM-YYYY'
        	}
        });
        
    }
     
   /* function validate(){
    	 var dortmdName=document.getElementById("EmpId").value;
    	 var adName=document.getElementById("EmpId2").value;
    	 if(dortmdName==adName){
    		 alert("Names cannot be same");
    		 return false;
    	 }
    }
    */
</script>

</body>
</html>