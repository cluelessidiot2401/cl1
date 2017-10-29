<%@page import = "huffman.*,java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>HuffMan</title>
	<script type="text/javascript" src="script.js"></script>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<table>
		<tr>
			<td><h1>Character</h1></td>
			<td><h1>Probabilty</h1></td>
			<td><h1>Code</h1></td>
		</tr>


<%
	final String[] text = request.getParameter("text").split(" ");
	int []freq=new int[256];
	int length=0;
	for(String x : text){
		length+=x.length();
		for(int y=0;y<x.length();++y)
			++freq[(int)x.charAt(y)];
	}
	
	Huffman huff=new Huffman(freq,new PrintWriter(out,true));
	huff.Solve(length);
%>

	</table>

</body>
</html>