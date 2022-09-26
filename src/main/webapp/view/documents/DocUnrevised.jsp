<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.vts.pfms.docs.model.PfmsDocTemplate"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Topics Layout</title>
<%Object[] docdata = (Object[])request.getAttribute("docdata"); %>
<style type="text/css">

.break
	{
		page-break-after: always;
	} 
	
 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
@page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black;  
            
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
          @top-right {
          	margin-top: 30px;
            margin-right: 10px;
            content: "Project : <%=docdata[7]%>";
          }  
      
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=docdata[6]%>";
          }            
          
}
 
 table tr td 
 {
 	word-wrap: break-word;
 	text-align: justify;
 	display: inline-block;
 }
 
 .print-table tr td 
 {
 	padding : 5px 3px 5px 3px;
 }
 
 
</style>
</head>
<body>
<%
	
	List<Object[]> itemcontentlist=(List<Object[]>)request.getAttribute("itemcontentlist");
	List<PfmsDocTemplate> itemslist=(List<PfmsDocTemplate>)request.getAttribute("itemslist");
	
	HashMap<Long, ArrayList<Object[]>> linkslistmap =(HashMap<Long, ArrayList<Object[]>> )request.getAttribute("linkslistmap");	
	int itemcount=0;
	ArrayList<Object[]> templist = new ArrayList<Object[]> ();
	
	Object[] labdetails=(Object[])request.getAttribute("labdetails");
	String lablogo=(String)request.getAttribute("lablogo");
%>



<div  align="center" style="max-width: 650px; min-width: 650px;">

			<div class="firstpage" id="firstpage">		
			<br>
			<div style="text-align: center;" ><h1>PROJECT DOCUMENT</h1></div>
			<br>
			<br>				
				
				<h2 style="margin-top: 3px">Project  : &nbsp;<%=docdata[8] %>  (<%=docdata[7]%>)</h2>
					
					<h2 style="margin-top: 3px"> <%=docdata[6]%></h2>
				
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<figure><img style="width: 4cm; height: 4cm"  src="data:image/png;base64,<%=lablogo%>"></figure>   
			<br><br><br>
			
			
			<div style="text-align: center;" ><h3><%=labdetails[2] %> (<%=labdetails[1]%>)</h3></div>
			
			<div align="center" ><h3><%=labdetails[4] %>, &nbsp;<%=labdetails[5] %>, &nbsp;<%=labdetails[6] %></h3></div>
		</div>


		 <h1 class="break"></h1> 
			<table class="index" style=" margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; min-width: 650px;font-size: 16px; border-collapse:collapse; width: 100%; "  >
				<tr>
					<th style="width: 100% ; text-align: center; " ><b style="text-decoration: underline;">INDEX</b></th>			
				</tr>
					
					<%	int count =1;
						for(PfmsDocTemplate item : itemslist)
						{ 
							if(item.getLevelNo()==1)
							{ %>
								<tr>
									<td><%=count %> )&nbsp; <%=item.getItemName() %></td>							
								</tr>	
								
								<%	int count1=1;
									for(PfmsDocTemplate item1 : itemslist){ 
									if(item1.getLevelNo()==2 && item.getTemplateItemId() ==item1.getParentLevelId())
									{ %>
										<tr>
											<td style="padding-left: 30px;"><%=count %>.<%=count1 %>)&nbsp;<%=item1.getItemName() %></td>
										</tr>
										
										<%	int count2=1;
											for(PfmsDocTemplate item2 : itemslist){ 
											if(item2.getLevelNo()==3 && item1.getTemplateItemId() ==item2.getParentLevelId())
											{ %>
												<tr>
													<td style="padding-left: 60px;"><%=count %>.<%=count1 %>.<%=count2 %>)&nbsp;<%=item2.getItemName() %></td>
												</tr>
											<% count2++;
											} %>
										<%} %>
										
										
										
									<% count1++;
									} %>
								<%} %>
												
						<%	count++;}
					}%>
			</table>
		</div>
		 <h1 class="break"></h1> 

<div  align="center" style="max-width: 650px; min-width: 650px;">
		<div  align="center" style="margin-top: 4px;">
			<span style="width: 100% ; text-align: justify;word-wrap: break-word;"><b><%=docdata[6] %></b></span>			
		</div>

		<table class="print-table" style="margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; min-width: 650px;font-size: 16px; border-collapse:collapse;"  >
			<%	count =1;
				for(Object[] item : itemcontentlist)
				{ 
					if(item[1].toString().equals("1"))
					{ %>
						<tr>
							<td><b><%=count %> ) <%=item[4] %></b></td>							
						</tr>
						<tr>
							<%if(item[5]!=null){ %>
								<td style="padding-left: 30px;"> 
								<%=item[6] %>
								<%if(linkslistmap.containsKey(Long.parseLong(item[5].toString())))
												  { itemcount =0 ;%>
													Refer  :
													<%templist =linkslistmap.get(Long.parseLong(item[5].toString()));
													for(Object[] tempitem : templist){ itemcount++;  %>
													<br>
													 <%=itemcount%> ) <%=tempitem[7] %>&nbsp;(<%=tempitem[6] %>)&nbsp;-&nbsp;<%=tempitem[3] %>										
													<%}
												 } %>	
								
								</td>
							<%}else{ %>
								<td style="padding-left: 30px;"> NIL</td>
							<%} %>
						</tr>	
						
						<%	int count1=1;
							for(Object[] item1 : itemcontentlist){ 
							if(item[0].toString().equals(item1[2].toString()))
							{ %>
								<tr>
									<td style="padding-left: 30px;"><b><%=count %>.<%=count1 %>)<%=item1[4] %></b></td>
								</tr>
								<tr>
									<%if(item1[5]!=null){ %>
										<td style="padding-left: 50px;">
										 <%=item1[6] %>
										 
										 <%if(linkslistmap.containsKey(Long.parseLong(item1[5].toString())))
										  { itemcount =0 ;%>
											Refer  :
											<%templist =linkslistmap.get(Long.parseLong(item1[5].toString()));
											for(Object[] tempitem : templist){ itemcount++;  %>
											<br>
											 <%=itemcount%> ) <%=tempitem[7] %>&nbsp;(<%=tempitem[6] %>)&nbsp;-&nbsp;<%=tempitem[3] %>										
											<%}
										 } %>	
										 
										 </td>
									<%}else{ %>
										<td style="padding-left: 50px;"> NIL</td>
									<%} %>
								</tr>	
								
								<%	int count2=1;
									for(Object[] item2 : itemcontentlist){ 
									if(item1[0].toString().equals(item2[2].toString()))
									{ %>
										<tr>
											<td style="padding-left: 30px;"><b><%=count %>.<%=count1 %>.<%=count2 %>)<%=item2[4] %></b></td>
										</tr>
										<tr>
											<%if(item2[5]!=null){ %>
												<td style="padding-left: 50px;"> 
												<%=item2[6] %>
												<%if(linkslistmap.containsKey(Long.parseLong(item2[5].toString())))
												  { itemcount =0 ;%>
													Refer  :
													<%templist =linkslistmap.get(Long.parseLong(item2[5].toString()));
													for(Object[] tempitem : templist){ itemcount++;  %>
													<br>
													 <%=itemcount%> ) <%=tempitem[7] %>&nbsp;(<%=tempitem[6] %>)&nbsp;-&nbsp;<%=tempitem[3] %>										
													<%}
												 } %>	
												</td>
											<%}else{ %>
												<td style="padding-left: 50px;"> NIL</td>
											<%} %>
										</tr>
									<% count2++;
									} %>
								<%} %>
								
							<% count1++;
							} %>
						<%} %>
										
				<%	count++;}
			}%> 
	</table>
</div>

</body>
</html>