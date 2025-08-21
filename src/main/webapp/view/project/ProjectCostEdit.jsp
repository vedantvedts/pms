<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT COST  EDIT</title>
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


</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
List<Object[]> BudgetHead=(List<Object[]>)request.getAttribute("BudgetHead");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
Object[] ProjectCostEditData=(Object[])request.getAttribute("ProjectCostEditData");
Double TotalIntiationCost=(Double)request.getAttribute("TotalIntiationCost");
List<Object[]> BudgetItemList=(List<Object[]>)request.getAttribute("BudgetItemList");
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
  <b style="color: green;">TITLE:&nbsp;<%=ProjectDetailes[7]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()): " - " %>(<%=ProjectDetailes[6]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()): " - " %>)&nbsp;||&nbsp;COST:&nbsp;<%=ProjectDetailes[8]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[8].toString()): " - " %> </b>
  </div>
        
        <div class="card-body">
        
        
                    
        
        
        
        
        
        
        <form action="ProjectCostEditSubmit.htm" method="POST" name="myfrm" id="myfrm" >
      

        

                <div class="row" >
                
                     <div class="col-md-2 ">
                        <div class="form-group">
                            <label class="control-label">Budget Head </label>
 <select class="custom-select" id="BudgetHead" required="required" name="BudgetHead">
    <option disabled="true"  selected value="">Choose...</option>
    <% for (Object[] obj : BudgetHead) {%>
<option value="<%=obj[0]%>" <%if(ProjectCostEditData[2].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
<%} %>
  </select>
                        </div>
                    </div>        
                
                
                     <div class="col-md-4 ">
                        <div class="form-group">
                            <label class="control-label">Item</label>
 <select class="custom-select" id="Item" required="required" name="Item">
    <option disabled="true"  selected value="">Choose...</option>
<% for (Object[] obj : BudgetItemList) {%>
<option value="<%=obj[0]%>" <%if(ProjectCostEditData[3].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
<%} %>
  </select>
                        </div>
                    </div>  
                    
                  
           
                    
            
                    
                    
                    <div class="col-md-3 ">
                        <div class="form-group lab_count">
                            <label class="control-label">Item Detail</label>
   <input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="ItemDetail" name="ItemDetail" required="required" value="<%=ProjectCostEditData[4]!=null?StringEscapeUtils.escapeHtml4(ProjectCostEditData[4].toString()): ""%>">                      </div>
                    </div> 
          
               <div class="col-md-2 ">
                        <div class="form-group">
                            <label class="control-label">Cost</label>
  <input type="number" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="Cost" name="Cost" required="required" value="<%=ProjectCostEditData[5]!=null?StringEscapeUtils.escapeHtml4(ProjectCostEditData[5].toString()): ""%>"> 

                        </div>
                    </div> 
                                     
                </div>
          
         <hr>
         
        <div class="form-group">
<center>

 <input type="submit" class="btn btn-primary btn-sm submit" onclick="Add(myfrm)" value="SUBMIT"   name="sub" >
 <input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
</center>
</div>

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				
		<input type="hidden" name="IntiationId"
				value="<%=IntiationId %>" /> 		
		<input type="hidden" name="InitiationCostId"
				value="<%=ProjectCostEditData[0] %>" /> 	
 	</form>
        
     </div>`     
        








        </div>
</div>
</div>


  

	
<script type="text/javascript">
var TotalProjectCost="<%=ProjectDetailes[8] %>";
var TotalIntiationCost="<%=TotalIntiationCost %>";
var ProjectCostEditData="<%=ProjectCostEditData[5] %>";

function Add(myfrm){
	var newcost=0;
	var Cost = $("#Cost").val();


	newcost=Number(TotalIntiationCost)+Number(Cost)-Number(ProjectCostEditData);

	 
 	 if(TotalProjectCost<newcost){
		  bootbox.alert("Cost Is More Than Project Cost");
	 event.preventDefault();
	return false;
	} 
	  
	

		 
	
		  return true;
	 
			
	}
	













$(document)
.on(
		"change",
		"#BudgetHead",

		function() {
			
			
			
			
			
      var $BudgetHead = $("#BudgetHead").val();
     
      
      
      
			 $("#Item").find('option').remove();
			
			
			$
					.ajax({

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
							for (i = 0; i < values.length; i++) {
								s += '<option value="'+values[i][0]+'">'
										+values[i][1]
										+ '</option>';
							}
							$('#Item').html(s);
						
							
							
						}
					});

		});






</script>
</body>
</html>