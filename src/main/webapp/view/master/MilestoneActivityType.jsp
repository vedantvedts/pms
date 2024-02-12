
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Milestone Activity Master</title>
<jsp:include page="../static/header.jsp"></jsp:include>
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
th,td{
text-align:center;
}
</style>

</head>
<body>
  <%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>
    <br />
  <% List<Object[]> MilestoneActivityType=(List<Object[]>) request.getAttribute("activitylist");
  %>
   
 
  <div class="container-fluid">
      <div class="col-md-12">
        <div class="card">
      
           <div class="card-header">
			<div class="row">
				<div class="col-md-10"><h4>Activity Master</h4></div>
				<div class="col-md-2">		      
					<a class="btn btn-info btn-sm  back"  style="margin-left: 4.2rem; margin-top: -5px;"   href="MainDashBoard.htm">Back</a>
				</div> 
			</div>
		</div>
		
		<div class="row" style="margin-top: 10px;">
		 <div class="col-md-8">
		  <div style="margin-top: 0px;">
            <div class="card " >
             <form action="ActivityMaster.htm" method="POST" name="frm1">
		 <div class="card-body shadow-nohover">
	    <div class="row" style="margin-top: 20px;">
	      <div class="container-fluid">                                  
	        <div class="col-lg-12 col-md-10 col-sm-6 col-xs-6">
	          <div class="sparkline13-list"> 
	            <div class="sparkline13-graph">
	              <div class="datatable-dashv1-list custom-datatable-overright">
	         <table class="table table-bordered table-hover table-striped table-condensed " id="myTable">
	           <thead>
	            <tr>
	              <th>Select</th>
	               <th>ActivityType</th> 
	            </tr>
	           </thead>
	            <tbody>
	              <%for(Object[] obj:MilestoneActivityType) { %> 
	               <tr>
	                 <td><input type="radio" name="Did" value=<%=obj[0] %>></td>
	                  <td > <%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %>
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
	     </div>
	     </form>
		</div>
         </div>
         </div>
<div class="col-md-4">
<div style="margin-top: 0px;">

<div class="card " >
		  	
     <div class="card-body  shadow-nohover" >
  <form action="ActivityAddSubmit.htm" method="POST"  id="addcheck" >
     <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
    <div class="table-responsive" >
	   <table class="table table-bordered table-hover table-striped table-condensed"  > 
	   <thead style = "background-color: #055C9D; color: white;">
	   <tr>
	   <th colspan="4">Add Activity  Type</th>
	  </tr>
	 </thead>
    <tbody>
	    <tr><td colspan="4">
			<input class="form-control" type="text" id="activitytype" name="activitytype" >	
	    </td>
	    </tr>
	    </tbody>
</table>
</div>
<div style="text-align: center;">
 <button type="button" class="btn btn-success btn-sm add " name="sub" value="edit" onclick="return AddActivityCheck('addcheck');" >ADD</button>

</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      </div>
      </div>
      </form>
      </div>
      </div>
</div>
</div> 
         
      </div>
      </div>
    </div>
 </div>
  
  <script type='text/javascript'>
  
    $(document).ready(function(){
    	$('#LogInId').select2();
    	
    });
  
  </script>
<script type="text/javascript">
   
   function AddActivityCheck(myfrm){
	   var count=0;
		var atype=$('#activitytype').val().trim();
	    if(atype.length==0){
	    	alert("Please fill the type !");
	    	return false;
	    }
	    else{
		
        $.ajax({
        	
         	   type:"GET",
         	   url:"AddActivityCheck.htm",
         	   
         	  data:{
         		    activitytype:atype.trim(),
         	  },
         	datatype:'json',
         	success:function(result){
         	var ajaxresult = JSON.parse(result);
         		
	         if(ajaxresult[0]==1)
	         {
	        	 alert("Activity type already exists");
	        	 return false;
	         }
         		 
         		
         		if(ajaxresult[0]==0 && confirm('Are you Sure to Submit ?')){
         			
         			$('#'+myfrm).submit();
         			return true;
         			
         		}else{
         			return false;
         		}
         
         		
         	 }
        });  
	    }
   } 
</script>
 <script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
		 "pageLength": 5
});

  });
  

</script>
</body>
</html>