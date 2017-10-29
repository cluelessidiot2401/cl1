object BinarySearch{

	def binSearch_no_rec(array:Array[Int], value : Int)
	{
		var s=0;
		var e=array.length-1;
		var flag : Int=0;
		while( s <= e)
		{
			if(value==array(s)) {
				println("Element Found at position "+s);
				flag=1;
				s=s+1;
			}
			if( value == array(e) ){
				println("Element Found at position "+e);
				flag=1;
				s=s+1;
			}
			if(s==e || flag==1)	s=e+1;
			else if(value <= array((s+e)/2) )	e=(s+e)/2;
			else s=(e+s)/2+1;
		}
		if(flag==0)	println("Element not Found!");
	}
	def binSearch_with_rec( array : Array[Int], s : Int, e : Int, value : Int ) : Int =
	{
		if(value==array(s)) {
			println("Element Found at position "+s);
			return 0;
		}
		if( value == array(e) ){
			println("Element Found at position "+e);
			return 0;
		}
		if(s==e)	return -1;
		else if(value <= array((s+e)/2) ){
			val pos = binSearch_with_rec(array,s,(s+e)/2,value);
			if(pos == -1)	println("Element not Found!");
			return -2;
		}
		else
		{
			val pos = binSearch_with_rec(array,(s+e)/2+1,e,value);
			if(pos == -1)	println("Element not Found!");
			return -2;
		}
	}

	def bubbleSort(array: Array[Int])
	{
		val n=array.length;

		for(x <- 0 to n-2)
		{
			for(y <- 0 to n-x-2)
			{
				if(array(y) > array(y+1)){
					array(y) = array(y) ^ array(y+1);
					array(y+1) = array(y) ^ array(y+1);
					array(y) = array(y) ^ array(y+1);
				}
			}
		}
	}

	def main(args: Array[String]){
		println("Enter the size of the Array:\t");
		val n= Console.readInt;
		println("\nEnter the Elements of the Array:\n");
		var array=new Array[Int](n);
		for(x <- 0 to n-1){
			array(x)=Console.readInt;
		}
		bubbleSort(array);
		for(x <- 0 to n-1){
			println(array(x));
		}
		println("Enter Element to Search for:\n");
		val value=Console.readInt;
		binSearch_no_rec(array,value);
		println();
		binSearch_with_rec(array,0,n-1,value);
	}
}