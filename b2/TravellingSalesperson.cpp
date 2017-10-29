#include <iostream>
#include <omp.h>
#include <ctime>
using namespace std;

#define f(i,n)  for(int i=0;i<n;++i)
#define rf(i,n)  for(int i=n-1;i>=0;--i)
#define fab(i,a,b)	for(int i=a;i<=b;++i)
#define finc(i,a,b,in)	for(int i=a;i<=b;i+=in)
#define ll  long long
#define li long

//map<string,bool>m;

class TSP
{
public:
	string s;
	int n;
	int cost;
	int **a;
	int *tsp_path;

	void input()
	{
		cout<<"Enter the number of nodes:\t";
		cin>>n;

		a=new int*[n];
		tsp_path=new int[n];
		f(i,n)	a[i]=new int[n];

		cout<<"Enter the Cost matrix as "<<n<<"*"<<n<<"\n";

		f(i,n)	f(j,n)	cin>>a[i][j];

	}

	void tsp()
	{
		cost=1e6;
		this->s="";

		f(i,n)	s+=char('0'+i);
		perm("",0);
	}

	void tsp_parallel()
	{
		cost=1e6;
		this->s="";

		f(i,n)	s+=char('0'+i);
		perm_parallel("",0);
	}

	void calculate(string path)
	{
		int sum=0;
		f(i,n)	sum+=a[path[i]-'0'][path[(i+1)%n]-'0'];
		if(sum<cost){
			cost=sum;
			f(i,n)	tsp_path[i]=path[i]-'0';
		}
	}

//	unsigned int count=0;
	void perm_parallel(string toP,unsigned int i)
	{
		if(i==s.size()){
//			count++;
//			cout<<toP<<"\n";
			calculate(toP);
			return;
		}
		string tt=toP;

		#pragma omp parallel for
			for(unsigned int j=0;j<=i;j++){
				tt=toP;
				tt.insert(tt.begin()+j,s[i]);
				perm_parallel(tt,i+1);
			}
	}

	void perm(string toP,unsigned int i)
	{
		if(i==s.size()){
//			count++;
//			cout<<toP<<"\n";
			calculate(toP);
			return;
		}
		string tt=toP;

			for(unsigned int j=0;j<=i;j++){
				tt=toP;
				tt.insert(tt.begin()+j,s[i]);
				perm(tt,i+1);
			}
	}
	void print()
	{
		cout<<"\nPath is:\n";
		f(i,n)	cout<<tsp_path[i]<<" -> ";
		cout<<tsp_path[0]<<"\n";
		cout<<"Cost is:\t"<<cost;
	}

};

int main()
{
	TSP tsp;
	tsp.input();
	clock_t s1=clock();
	tsp.tsp();
	clock_t s2=clock();
	tsp.print();

	cout<<"\n";

	clock_t p1=clock();
	tsp.tsp_parallel();
	clock_t p2=clock();
	tsp.print();

	cout<<"\n\nTime for sequential = "<<(s2-s1)<<"\n";
	cout<<"Time for Parallel = "<<(p2-p1)<<"\n";
}

