#include<iostream>
#include<pthread.h>
#include<stdlib.h>
#include<sched.h>
#include<bits/stdc++.h>
using namespace std;

int N;
struct args
{
	int *a;
	int first;
	int last;
};

int pivot(int arr[],int l,int h)
{
	int pvt=arr[h];
	int i=l-1;
	for(int j=l;j<=h-1;j++)
	{
		if(arr[j]<=pvt)
		{
			i++;
			swap(arr[i],arr[j]);
		}
	}
	swap(arr[h],arr[i+1]);
	return (i+1);
}

void* quicksort(void* arg)
{
	args* ar=(args*)arg;		
	pthread_t threads[2];
	if(ar->first < ar->last)
	{
		int pi=pivot(ar->a,ar->first,ar->last);
		cout<<"Thread no executing on core "<<sched_getcpu()<<" found pivot element= "<<pi<<endl;
		args array1;
		array1.a=new int[N];
		array1.a=ar->a;
		array1.first=ar->first;
		array1.last=(pi-1);
		args* x=&array1;
		int rc=pthread_create(&threads[0],NULL,&quicksort,(void*)x);
		args array2;
		array2.a=new int[N];
		array2.a=ar->a;
		array2.first=(pi+1);
		array2.last=ar->last;
		args* y=&array2;
		int rc1=pthread_create(&threads[1],NULL,&quicksort,(void*)y);
		pthread_join(threads[0],NULL);
		pthread_join(threads[1],NULL);
	}
}

int main()
{
	cout<<"Enter no of elements: ";
	cin>>N;
	args array;
	array.a=new int[N];
	array.first=0;
	array.last=N-1;
	cout<<"Enter elements: ";
	for(int i=0;i<N;i++)
	{
		cin>>array.a[i];
	}
	quicksort(&array);
	cout<<"After performing quicksort: ";
	for(int i=0;i<N;i++) cout<<array.a[i]<<" ";
	cout<<"\n";
}
