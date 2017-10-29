package huffman;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
public class Huffman {

	int []freq=null;
	Text head=null;
	static PrintWriter out;
	
	public Huffman(int freq[],PrintWriter out)
	{
		this.freq=freq;
		this.out=out;
	}
	
	public void Solve(int size)
	{
		ArrayList<Text> al = new ArrayList<Text>();
		
		for(int x=0 ; x<256 ; ++x)
		{
			if(freq[x]==0)	continue;
			al.add(new Text((char)(x),(double)freq[x]/size));
		}
		Sorter checker=new Sorter();
		
		Collections.sort(al,checker);
		
		while(true)
		{
			if(al.size()==1){
				head =al.get(0);
				break;
			}
			Text small=al.get(0);
			Text big=al.get(1);
			al.remove(0);
			al.remove(0);
			Text temp=new Text();
			temp.setLeft(small);
			temp.setRight(big);
			temp.setProb(small.getProb()+big.getProb());
			al.add(temp);
			Collections.sort(al,checker);
		}
		
		print(head,"");
	}
	
	public void print(Text head, String code)
	{
		head.setCode(code);
		if(head.getLeft()==null){
			out.print("<tr>");
			out.print("<td>"+head.getVal()+"</td>"+
					"<td>"+head.getProb()+"</td>"+
					"<td>"+head.getCode()+"</td>");
			out.print("</tr>");
			return;
		}
		print(head.getLeft(),head.getCode()+"0");
		print(head.getRight(),head.getCode()+"1");
	}
	
}

class Text
{
	private char val;
	private double prob;
	private Text l,r;
	private String code;
	
	public Text(char c, double fre)
	{
		val=c;
		prob=fre;
		l=null; r=null;
		setCode("");
	}
	public Text() {
		l=null; r=null;
		setCode("");
	}
	public char getVal()
	{
		return val;
	}
	public double getProb()
	{
		return prob;
	}
	public void setProb(double prob)
	{
		this.prob=prob;
	}
	public void setLeft(Text left){
		l=left;
	}
	public void setRight(Text right){
		r=right;
	}
	public Text getLeft(){
		return l;
	}
	public Text getRight(){
		return r;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}


class Sorter implements Comparator<Text>{
	public int compare(Text a, Text b)
	{
		if(a.getProb()==b.getProb())	Character.compare(a.getVal(), b.getVal());
		return Double.compare(a.getProb(), b.getProb());
	}
}
