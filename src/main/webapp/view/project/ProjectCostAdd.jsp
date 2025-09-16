<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectModule/projectCostAdd.css" var="projectCostAdd" />
<link href="${projectCostAdd}" rel="stylesheet" />
<title>PROJECT COST  ADD</title>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
List<Object[]> ItemList=(List<Object[]>)request.getAttribute("ItemList");
List<Object[]> BudgetHead=(List<Object[]>)request.getAttribute("BudgetHead");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
Double TotalIntiationCost=(Double)request.getAttribute("TotalIntiationCost");
Map<String,List<Object[]>> BudgetItemMap=(Map<String,List<Object[]>>)request.getAttribute("BudgetItemMap");
Map<String,List<Object[]>> BudgetItemMapList=(Map<String,List<Object[]>>)request.getAttribute("BudgetItemMapList");
NFormatConvertion nfc=new NFormatConvertion();
List<Object[]> BudgetHeadList=(List<Object[]>)request.getAttribute("BudgetHeadList");
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


<div class="container-fluid">
	
	<div class="row">
		<div class="col-md-12">

 			<div class="card shadow-nohover" >
		  		
		  		<div class="card-header">
		  			<div class="row" >
		  				<div class="col-md-1"><h3>Cost </h3></div>
						<div class="col-md-11 float-right">
		 					<form action="ProjectCostAddSubmit.htm" method="POST" name="myfrm3" id="myfrm3" >
		   						<b class="text-success">Title :&nbsp;<%=ProjectDetailes[7]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()): " - " %> (<%=ProjectDetailes[6]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()): " - " %>)&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;Fe Cost :&nbsp;&#8377; <%if(ProjectDetailes[14]!=null){%><%=nfc.convert(Double.parseDouble(ProjectDetailes[14].toString())) %><%}else{%>0.00<%} %>&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;Re Cost  :&nbsp;&nbsp;&#8377;<%if(ProjectDetailes[15]!=null){%><%=nfc.convert(Double.parseDouble(ProjectDetailes[15].toString())) %><%}else{ %>0.00<%} %> &nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp; Total Cost  :&nbsp;&nbsp;&#8377; <%if(ProjectDetailes[8]!=null){%><%=nfc.convert(Double.parseDouble(ProjectDetailes[8].toString())) %><%}else{ %>0.00<%} %> 
		   
								<%--    || &nbsp;&nbsp;&nbsp;&nbsp;Cost Utilized:&nbsp;<%=nfc.convert(TotalIntiationCost) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Remaining Cost :&nbsp;<%if(ProjectDetailes[8]!=null){%><%=nfc.convert(Double.parseDouble(ProjectDetailes[8].toString())-TotalIntiationCost) %><%}else{ %><%=TotalIntiationCost %><%} %> --%>  
								 	
		  	 	 				<input type="submit" class="btn btn-primary btn-sm submit back float-right"   value="BACK"   name="sub">
		  						</b>
		  						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								<input type="hidden" name="IntiationId"	value="<%=IntiationId %>" /> 		
		 					</form>
		 				</div>
		 			</div>
		  		</div>
        
        
        		<div class="card-body">
        
               		<form action="ProjectCostAddSubmit.htm" method="POST" name="myfrm" id="myfrm" >
 
                		<div class="row" >
                
					       <div class="col-md-2 ">
					       		<div class="form-group">
					            	<label class="control-label">Budget Head </label>
										 <select class="custom-select" id="BudgetHead" required="required" name="BudgetHead">
										    <option disabled="true"  selected value="">Choose...</option>
										    <% for (Object[] obj : BudgetHeadList) {%>
										<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
										<%} %>
										  </select>
					             </div>
					       </div>        
                
                
		                  <div class="col-md-4 ">
		                        <div class="form-group">
		                            <label class="control-label">Item</label>
										 <select class="custom-select" id="Item" required="required" name="Item">
										    <option disabled="true"  selected value="">Choose...</option>
										
										  </select>
		                        </div>
		                   </div>  
                    
     
		                    <div class="col-md-3 ">
		                        <div class="form-group lab_count">
		                            <label class="control-label">Item Detail</label>
		   								<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="ItemDetail" name="ItemDetail" required="required">                      </div>
		                    </div> 
          
			               <div class="col-md-2 ">
			               		<div class="form-group">
			                            <label class="control-label">Cost</label>
			  								<input type="text" class="form-control decimal-format "  aria-describedby="inputGroup-sizing-sm" id="Cost" name="Cost" required="required" min="1">
			                     </div>
			               </div> 
                 
			              <div class="col-md-1 mt-35">
			              	 <button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub"  onclick="return confirm('Are You Sure To Add ?');"> SUBMIT</button>
 			              </div>      
                                     
                		</div>
          
         				<hr>
         				
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<input type="hidden" name="IntiationId"	value="<%=IntiationId %>" /> 		
				
 					</form> 

                    <table class="table table-bordered table-hover  table-condensed mt-2">
                    	<thead>
                        	<tr>
                            	<th >Item</th>
                                <th >Item Detail</th>
                                <th >Cost</th>
                                <th >Edit&nbsp;|&nbsp;Delete</th>
                             </tr>
                        </thead>
                                        
	    				<tbody>
	    	
				    	<%Double totalcost=0.0;
				    	for(Map.Entry<String, List<Object[]>> entry:BudgetItemMapList.entrySet()){ %>
	    	
	    					<tr>
	    						<td>
	    							<b><%=entry.getKey()!=null?StringEscapeUtils.escapeHtml4(entry.getKey()): " - "%></b>
	    						</td>
	    					</tr>
	    			    	<%Double cost=0.0;
									    for(Object[] 	obj:entry.getValue()){ 
							%>
							<!-- (obj[6].toString().equalsIgnoreCase(obj2[2].toString())) -->
								<tr>
								<form action="ProjectCostEditSubmit.htm" method="POST" name="myfrm<%=obj[0] %>" id="myfrm<%=obj[0] %>" >	
									
		 							<td class="w-400px">
		 						
		 								<select class="custom-select" id="Item" required="required" name="Item" >
									    	<option disabled="true"  selected value="">Choose...</option>
												<% for (Object[] obj2 : BudgetItemMap.get(entry.getKey())) { 
												if(obj2[3].toString().equalsIgnoreCase(ProjectDetailes[21].toString())){
												%>
												<option value="<%=obj2[0]%>" <%if((obj[3].toString().equalsIgnoreCase(obj2[1].toString()))&&(obj[6].toString().equalsIgnoreCase(obj2[2].toString())) ){ %> selected="selected" <%} %>><%=obj2[1]!=null?StringEscapeUtils.escapeHtml4(obj2[1].toString()): " - "%> (<%=obj2[2]!=null?StringEscapeUtils.escapeHtml4(obj2[2].toString()): " - "%>) (<%=obj2[4]!=null?StringEscapeUtils.escapeHtml4(obj2[4].toString()): " - "%>)</option>
												<%} }%>
	 							 		</select>
	 							 	</td>
	 							 	
									<td class="w-550px">
					   					<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="ItemDetail" name="ItemDetail" required="required" value="<%=obj[4] %>">                     
									</td>
									<td class="text-right">
										<input type="text" class="form-control decimal-format text-right"  aria-describedby="inputGroup-sizing-sm" id="Cost" name="Cost" min="1" required="required" value="<%=obj[5].toString().split("\\.")[0] %>">
									<td>
							    
							 			
							 			<button type="submit"  class="fa fa-pencil-square-o btn  " onclick="EditCost('myfrm<%=obj[0] %>')" ></button>&nbsp;&nbsp;		
									 
										<button type="submit" class="fa fa-trash btn " formaction="ProjectCostDeleteSubmit.htm" onclick="return confirm('Are You Sure To Delete? ');"></button>			    
										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
						
										<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
		          						<input type="hidden" name="InitiationCostId"	value="<%=obj[0] %>" /> 
	          						
	          	            		</td>
	          	            		</form>
								</tr>
								
							
								<% cost=cost+Double.parseDouble(obj[5].toString()) ; } %>
								
								
	    					<tr>
	    						<td colspan="2" align="right">
	    							<b class="text-success"> <%=entry.getKey()!=null?StringEscapeUtils.escapeHtml4(entry.getKey()): " - " %> Cost</b>
	    						</td>
	    						<td  align="right">
	    							<b class="text-success text-right">&#8377; <%=nfc.convert(cost) %></b>
	    						</td>
	    						<td></td>
	    					</tr>
	    	
	    				
	    						<%totalcost=totalcost+cost;} %>
	    	
							<tr>
								<td colspan="2" align="right">
									<b class="text-success"> Total Cost</b>
								</td>
								<td>
									<b class="text-success">&#8377;<%=nfc.convert(totalcost) %></b>
								</td>
								<td></td>
							</tr>
								
								
							
	    				</table>
  
    		 		</div>  <!-- card-body -->
        		</div>
			</div>
		</div>

</div>
  

	
<script type="text/javascript">


<%-- var TotalProjectCost="<%=ProjectDetailes[8] %>";
var TotalIntiationCost="<%=TotalIntiationCost %>";


function Add(myfrm){
	var newcost=0;
	var Cost = $("#Cost").val();


	newcost=Number(TotalIntiationCost)+Number(Cost)

	 
 	 if(TotalProjectCost<newcost){
		  bootbox.alert("Cost Is More Than Project Cost");
	 event.preventDefault();
	return false;
	} 
	  
	

		 
	
		  return true;
	 
			
	} --%>
	

	

	function EditCost(formn){
		
		 event.preventDefault();
			
		 var ret=confirm('Are you Sure To Update ?');
		 if(ret ){
	 		 var input= $("<input>").attr("type","hidden").attr("name","totalcost").val("<%=totalcost%>");
			 
			 $("#"+formn).append(input);
			 $("#"+formn).submit();
		 }

	}



$(document)
.on(
		"change",
		"#BudgetHead",

		function() {		
			
			
      var $BudgetHead = $("#BudgetHead").val();      
      
			 $("#Item").find('option').remove();
			
			var projecttypeid = <%=ProjectDetailes[21]%>
			console.log($BudgetHead);
			console.log(projecttypeid);
			$.ajax({

						type : "GET",
						url : "BudgetItemList.htm",
						data : {
							BudgetHead : $BudgetHead
						},
						datatype : 'json',
						success : function(result) {

							var result = JSON.parse(result);
						
							
							var values = Object.keys(result).map(function(e) {
							  return result[e]
							})
							
							var s = '';
							/* var t=''; */
							for (i = 0; i < values.length; i++) {
								
								if(values[i][3] === projecttypeid){
								s += '<option value="'+values[i][0]+'_'+values[i][2]+'">'
										+values[i][1] +'('+ values[i][2] +')' + '('+ values[i][4]+')</option>';
								/* t += '<option value="'+values[i][2]+'"></option>'; */
								}
							}
							$('#Item').html(s);
							/* $('#ReFe').html(t); */
						
							
							
						}
					});

		});






</script>
</body>
</html>