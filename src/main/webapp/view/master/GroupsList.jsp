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
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>GROUPS LIST</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}
.table tbody tr td  {
    vertical-align: middle;
    text-align: center;
    
    white-space: nowrap;
}

</style>
</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> groupslist=(List<Object[]>) request.getAttribute("groupslist");
String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<div align="center">
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </div>
    <%}%>
<br>	
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
		
			<div class="card shadow-nohover" >
			<div class="card-header">
			<div class="row">
			   <div class="col-md-2"><h3>Groups List</h3></div>
			   <div class="col-md-10" align="right">
				  <form action="GroupMasterExcelUpload.htm" method="post" enctype="multipart/form-data">
					  		<table>
						  		<tr>
								  	<td align="left"><h6>Download Excel: &nbsp;<button formaction="GroupMasterExcelUpload.htm" formmethod="post" formnovalidate="formnovalidate" name="Action" value="GenerateExcel"><i class="fa fa-file-excel-o" aria-hidden="true" style="color: green;"></i></button></h6></td>
									<td align="right"><h6>&nbsp;&nbsp;&nbsp;&nbsp;	Upload Excel:&nbsp;&nbsp;&nbsp;&nbsp;
									  <input type="file" id="excel_file" name="filename" required="required"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"></h6></td>						
							  		<td align="right"> </td>
							    </tr>
					  		</table>	
					     <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
				 <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true"  >
					  <div class="modal-dialog modal-lg" role="document">
					    <div class="modal-content"  >
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLongTitle">Group Master Details</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body" align="left" style="max-height: 25rem; overflow-y:auto;">
					             <table class="table table-bordered table-hover table-striped table-condensed " id="myTable1" > </table>
					      </div>
					       <div class="modal-footer" align="center">
					       	    <div align="center">
					        			<button type="submit" onclick="return confirm('Are you sure to submit?')" style="margin-left: -70px;" class="btn btn-sm add" name="Action" value="UploadExcel"> Upload</button>
					      		</div>
					       </div>
					    </div>
					  </div>
					</div>
				  </form>
				</div>
			</div></div>
				<div class="card-body"> 
		               <form action="GroupMaster.htm" method="POST" name="frm1">
					 <div class="data-table-area mg-b-15">
			            <div class="container-fluid">
			                
			                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      <thead>
			                                         
			                           	<tr >
				                            <th style=" text-align: center;" >Select</th>
				                            <th style=" text-align: center;" >LabCode  </th>
		                                    <th style=" text-align: center;" >Group Code</th>
		                                    <th style=" text-align: center;" >Group Name</th>
		                                    <th style=" text-align: center;" >Group Head Name</th>
	                                    </tr>      
			        
			                          </thead>
			                    <tbody>
	                                 <%for(Object[] obj:groupslist){ %>
	                                     <tr>
	                                         <td><input type="radio" name="groupid" value=<%=obj[0]%>  ></td> 
	                                        <td><%=obj[6] %></td>
	                                         <td><%=obj[1] %></td>
	                                         <td ><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
	                                         <td > <%if(obj[3]!=null){%><%=obj[4]%>,<%=obj[5]%><%}else{ %>-<%} %></td>
	                                     </tr>
	                                 <%} %>
	                             </tbody>
				    				
				    
			                     </table>
			                      
			                   </div>
			                 </div>
			                </div>
			             </div>
			          </div>
			        </div>
	 <div align="center">
	      <button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add">ADD</button>&nbsp;&nbsp;  
    <%if(groupslist!=null && groupslist.size()>0){ %>
          <button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;
     <%} %> 
		   <a class="btn btn-info btn-sm  back"   href="MainDashBoard.htm">Back</a>
   </div>	

 	<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
</form>

     </div>
  
        
	
	</div>

</div> 
	
</div>	
	
	</div>
	
	
<script type="text/javascript">

function Edit(myfrm){
	
	 var fields = $("input[name='groupid']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;
	}

</script>
<script type="text/javascript">
const excel_file = document.getElementById('excel_file');

excel_file.addEventListener('change', (event) => {
    var reader = new FileReader();

    reader.readAsArrayBuffer(event.target.files[0]);

    reader.onload = function(event){

        var data = new Uint8Array(reader.result);

        var work_book = XLSX.read(data, {type:'array'});

        var sheet_name = work_book.SheetNames;

        var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]], {header:1});  
    	
    	const AcSno=[];
    	const IfscNo=[];
        if(sheet_data.length > 0)
        {          
        	var table_output = ' <table class="table table-bordered table-hover table-striped table-condensed " id="myTable1" > ';
           
        	table_output+='<thead> <tr > <th style=" text-align: center;">SNo</th> <th style=" text-align: center;">LabCode</th> <th style=" text-align: center;">Group Code</th> <th style=" text-align: center;">Group Name</th> <th style=" text-align: center;">Group HeadId</th></tr> </thead><tbody>'
        	
        	
        	for(var row = 0; row < sheet_data.length; row++)
            {            	
            	  table_output += ' <tr> ';
            	 
            	  if(row>0){table_output += '<td>'+ row +'</td>';}
                for(var cell = 0; cell < 3; cell++)
                {
                	
		                	if(row>0 && cell==0){
		                		table_output += '<td>'+'<%=session.getAttribute("labcode")%>'+'</td>';
		                	}
		                	if(row>0 && cell==2){
		                		table_output += '<td>'+sheet_data[row][cell]+'</td>';
		                	}
                	
			                if(row>0 && cell==1){		
			                	table_output += '<td>'+sheet_data[row][cell]+'</td>';
								var groupcode = ""+sheet_data[row][cell]+"";
								
								 if (groupcode.trim().length > 20 ) {								     									 
									 AcSno.push(row);
								 }
							}		
                    }
                if(row>0){table_output += '<td>'+ 0 +'</td>';}
                table_output += '</tr>';
                }
            table_output += ' <tbody></table>';
            document.getElementById('myTable1').innerHTML = table_output;
            
           
             var GroupCodejsArray = [<%int i=0; for (Object[] obj:groupslist) { %>"<%= obj[1] %>"<%= i + 1 < groupslist.size() ? ",":"" %><% } %>];
                     
             var groupcode=[];
             for (var i in sheet_data) {
          	  groupcode.push(sheet_data[i][1].toString())
          	}
             const duplicates = groupcode.filter((item, index) => index !== groupcode.indexOf(item));  
             
             const indexval = []             
             for(var i in duplicates){
            	 indexval.push(groupcode.indexOf(duplicates[i]))
             }
             var dbDuplicate = [];                      
             GroupCodejsArray.forEach(function(item){
            	  var isPresent = groupcode.indexOf(item);
            	  if(isPresent !== -1){
            		  dbDuplicate.push(isPresent); 
            	  }
            	})
            	
            	if(indexval.length>0){
            		 alert("Duplicate Group Code Existed in Excel file at Serial No :"+ indexval);
   			      excel_file.value = '';
            	}else if(dbDuplicate.length>0){
            		 alert("Group Code alredy Existed at serial No :"+ dbDuplicate);
   			      excel_file.value = '';
            	}else if(AcSno.length > 0){
               	 alert("Enter valid Group Code at Serial No :"+ AcSno);
			      excel_file.value = '';
         		  }else{
         			 $('#exampleModalLong').modal('show');
         		  }
            }else{
            	alert("Please Select the Excel File!");
            	return false;
            }
        }
});


$('#exampleModalLong').on('hide.bs.modal', function(){
	 excel_file.value = '';
})
</script>
<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
 });
$(document).ready(function(){
	  $("#myTable1").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
});
</script>

<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>