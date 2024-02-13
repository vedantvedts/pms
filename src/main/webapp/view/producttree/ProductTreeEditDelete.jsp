<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Milestone List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 14px;
}
.table thead tr,tbody tr{
    font-size: 14px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}
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
  width: 120px;
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
	width:210px !important;
}
.bootstrap-select {
  width: 400px !important;
}
input[type=checkbox] {
	accent-color: green;
}
</style>
</head>
 
<body>
  <%
  

  
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  
  
 %>




<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){	%>
	<div align="center">
		<div class="alert alert-danger" role="alert" >
	    <%=ses1 %>
	     <br />
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert"  >
	    	<%=ses %>
	    	 <br />
	    </div>
	</div>
<%} %>

   
   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				
				<div class="card shadow-nohover" style="margin-top: -0px;">
			
		
				<div class="row card-header">
			     <div class="col-md-11">
					<h5 ><%if(ProjectId!=null){
						Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
						%>
						<%=ProjectDetail[2] %> ( <%=ProjectDetail[1] %> ) 
					<%} %>
					</h5>
					</div>
					<form>
					      <input type="submit" class="btn btn-primary btn-sm back " id="sub" value="Back" name="sub" onclick="SubmitBack()"  formaction="ProductTree.htm"> 
					</form>
					 </div>
				
					<div class="card-body">
                        <div class="table-responsive"> 
									<table class="table  table-hover table-bordered">
													<thead>

														<tr>
															<th>Expand</th>
															
															<th style="text-align: left;">Level </th> 
															<th style="text-align: left;max-width: 200px;">Level Name</th>
															
																											
														 	<th style="max-width: 200px;" >Action</th>
														 		
														 	
														</tr>
													</thead>
													<tbody>
														<% int  count=1;
															
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level1: ProductTreeList){
																 if(level1[2].toString().equalsIgnoreCase("1")) { %>	
																
														<tr>
															<td style="width:2% !important;" class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td>
															
															<td style="">Level-1</td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level1[3] %></td>
															
															
															<td  style="width:20% !important; text-align: center;">		
																	
																	
															
		                                                              <button  class="editable-click" name="sub" value="E" onclick="EditModal('<%=level1[0]%>','<%=level1[3]%>','<%=level1[6]%>','<%=level1[7]%>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													             
													           <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													               <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																    <input type="hidden" name="Action" value="D"/>
													                  <button  class="editable-click" name="Mainid" value="<%=level1[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')">
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button> 
													               </form>
													                 
		                                                   	 
															 	
															</td>
														</tr>
														
														  <tr class="collapse row<%=count %>" style="font-weight: bold;">
                                                         <td></td>
                                                         <td>Sub</td>
                                                         <td>Level Name</td>
                                                         <td>Action</td>
                                                         
                                                         </tr>
                                                         
                                                         <% int countA=1;
                                                          
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level2: ProductTreeList){
																 if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString())){%>
	
																
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> A-<%=countA%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level2[3] %></td>
														 	<td class="width-30px" style="text-align: center;">
														 	
														 	
														 	 <button class="editable-click" name="sub" value="E" onclick="EditModal('<%=level2[0]%>','<%=level2[3]%>','<%=level2[6]%>','<%=level2[7]%>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													             </button> 
													                  
													            <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																    <input type="hidden" name="Action" value="D"/>
													                  <button class="editable-click" name="Mainid" value="<%=level2[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
													                  
													               </form>
														 	
														 	
														 	
														 	
														 	</td>
                                                         </tr>
                                                         <% int countB=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level3: ProductTreeList){
																  if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) ){
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;B-<%=countB%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level3[3] %></td>
															
															<td class="width-30px"  style="text-align: center;">
															
															
															 <button  class="editable-click" name="sub" value="E" onclick="EditModal('<%=level3[0]%>','<%=level3[3]%>','<%=level3[6]%>','<%=level3[7]%>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  
													             <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																    <input type="hidden" name="Action" value="D"/>
													                 <button class="editable-click" name="Mainid" value="<%=level3[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															     </form>
															
															
															</td>
															
                                                         </tr>
                                                         <% int countC=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level4: ProductTreeList){
																  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) {
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level4[3] %></td>
															
															<td class="width-30px"  style="text-align: center;">
															
															
														 <button  class="editable-click" name="sub" value="E" onclick="EditModal('<%=level4[0]%>','<%=level4[3]%>','<%=level4[6]%>','<%=level4[7]%>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													              <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																    <input type="hidden" name="Action" value="D"/>
													                 <button class="editable-click" name="Mainid" value="<%=level4[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															      </form>
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countD=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level5: ProductTreeList){
															if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) ){%>
	
																
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
														
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level5[3] %></td>
															
															
																<td class="width-30px">
															
															
																 <button  class="editable-click" name="sub" value="E" onclick="EditModal('<%=level5[0]%>','<%=level5[3]%>','<%=level5[6]%>','<%=level5[7]%>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
														
													                  
													                  
													               <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                  <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																      <input type="hidden" name="Action" value="D"/>
													                  <button class="editable-click" name="Mainid" value="<%=level5[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
													                </form>
															
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countE=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level6: ProductTreeList){ 
																if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString())) {
																	
																%>
															
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level6[3] %></td>
															
														    <td class="width-30px">
															
															
																 <button  class="editable-click" name="sub" value="E" onclick="EditModal('<%=level6[0]%>','<%=level6[3]%>','<%=level6[6]%>','<%=level6[7]%>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
														
													                  
													                  
													              <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																    <input type="hidden" name="Action" value="D"/>
													                 <button class="editable-click" name="Mainid" value="<%=level6[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															     </form>
															
															
															
															</td>
															
															
                                                         </tr>
												<% countE++;} }}%>
												<% countD++;} }}%>
												<% countC++;} }}%>
												<% countB++;} }}%>
												<% countA++;} }}else{%>
												<tr class="collapse row<%=count %>">
													<td colspan="9" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
												<%} %> 
												<% count++; }} }else{%>
												<tr >
													<td colspan="9" style="text-align: center" class="center">No List Found</td>
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



<div class="modal" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Level Name</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="" method="get">
        	<table style="width: 100%;">
        		<tr>
        			<th>Level Name : &nbsp; </th>
        			<td><input type="text" class="form-control" name="LevelName" id="levelname" required></td>
        		</tr>
        		
        		
        		<tr>
        			<th >Stage : &nbsp; </th>
        			<td >
        			
        			<select class="form select selectdee " name="Stage"  id="stage" style="width:100%;">
        			
        			        <option value="Design">Design</option>
		      				<option value="Realisation">Realisation</option>
		      				<option value="Testing & Evaluation">Testing & Evaluation</option>
		      				<option value="Ready for Closure">Ready for Closure</option>
        			
        			</select>
        			
        			</td>
        		</tr>
        		
        		
        			<tr>
        			     <th >Module : &nbsp; </th>
        			<td >
        			
        			<select class="form select selectdee" id="Module" name="Module"  style="width:100%;">
        			
        			        <option value="In-House-Development">In-House-Development</option>
		      				<option value="BTP">BTP</option>
		      				<option value="BTS">BTS</option>
		      				<option value="COTS">COTS</option>
        			
        			</select>
        			
        			</td>
        		</tr>
        		
        		
        		<tr>
        			<td colspan="2" style="text-align: center;">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
        			</td>
        		</tr>
        	</table>
        	
        	<input type="hidden" id="Mainid" name="Mainid" value="" >
        	<input type="hidden" id="" name="Action" value="E" >
        	<input type="hidden" id="" name="ProjectId" value="<%=ProjectId %>" >
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
        </form>
      </div>
     
    </div>
  </div>
</div>




	
<script type="text/javascript">

function EditModal(mainid,levelname,stage,module)
{
	$('#Mainid').val(mainid);			
	$('#levelname').val(levelname);
	//$('#stage').val(stage);
	//$('#module').val(module);

	
	
var selectedstage=stage	
 var selectedModule = module;



$('#EditModal').modal('toggle');
	
	
	
var s='';
$('#stage').html("");


	
	 if (selectedstage =='Design') {
		 
		 
		    s +='<option value="Design" selected="selected">Design</option>';
			s +='<option value="Realisation" >Realisation</option>';
			s +='<option value="Testing & Evaluation">Testing & Evaluation</option>';
			s +='<option value="Ready for Closure">Ready for Closure</option>'; 
		 
	       
    }  if (selectedstage == 'Realisation') {
		
		
		 
    	    s +='<option value="Design" >Design</option>';
			s +='<option value="Realisation" selected="selected">Realisation</option>';
			s +='<option value="Testing & Evaluation">Testing & Evaluation</option>';
			s +='<option value="Ready for Closure">Ready for Closure</option>'; 
      
       
    }   if (selectedstage == 'Testing & Evaluation') {
        
        
    	    s +='<option value="Design" >Design</option>';
			s +='<option value="Realisation" >Realisation</option>';
			s +='<option value="Testing & Evaluation" selected="selected" >Testing & Evaluation</option>';
			s +='<option value="Ready for Closure">Ready for Closure</option>'; 
       
    }  if (selectedstage == 'Ready for Closure') {
       
        
           
    	    s +='<option value="Design" >Design</option>';
			s +='<option value="Realisation" >Realisation</option>';
			s +='<option value="Testing & Evaluation"  >Testing & Evaluation</option>';
			s +='<option value="Ready for Closure" selected="selected" >Ready for Closure</option>'; 
       
    } 
    
    
    
    if (selectedstage == 'null') {
        
        
        
	    s +='<option value="Design" >Design</option>';
		s +='<option value="Realisation" >Realisation</option>';
		s +='<option value="Testing & Evaluation"  >Testing & Evaluation</option>';
		s +='<option value="Ready for Closure" >Ready for Closure</option>'; 
   
} 
	
	 $('#stage').html(s);		
	
	
	
	
	
	
var p='';
$('#Module').html("");


	
	 if (selectedModule =='In-House Development') {
		 
		    p +='<option value="In-House Development" selected="selected">In-House Development</option>';
			p +='<option value="BTP" >BTP</option>';
			p +='<option value="BTS">BTS</option>';
			p +='<option value="COTS">COTS</option>'; 
		 
	       
    }  if (selectedModule == 'BTP') {
		
		
		 
		p +='<option value="In-House Development">In-House Development</option>';
		p +='<option value="BTP" selected="selected">BTP</option>';
		p +='<option value="BTS">BTS</option>';
		p +='<option value="COTS">COTS</option>';
		
      
       
    }   if (selectedModule == 'BTS') {
        
        
    	p +='<option value="In-House Development">In-House Development</option>';
		p +='<option value="BTP">BTP</option>';
		p +='<option value="BTS" selected="selected" >BTS</option>';
		p +='<option value="COTS" >COTS</option>';
       
    }  if (selectedModule == 'COTS') {
       
        
           
    	p +='<option value="In-House Development">In-House Development</option>';
		p +='<option value="BTP">BTP</option>';
		p +='<option value="BTS">BTS</option>';
		p +='<option value="COTS" selected="selected" >COTS</option>';
       
    } 
    
    if (selectedModule == 'null') {
        
        
        
    	p +='<option value="In-House Development">In-House Development</option>';
		p +='<option value="BTP">BTP</option>';
		p +='<option value="BTS">BTS</option>';
		p +='<option value="COTS" >COTS</option>';
   
     } 
	
	 $('#Module').html(p);	
	 

}


	
function ChangeButton(id) {
	console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
    }
}




</script>  





</body>
</html>