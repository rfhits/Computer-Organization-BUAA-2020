#include <bits/stdc++.h>
 
#define REP(I,A,B) for (int I=(A),I##_END_=(B);I<=I##_END_;I++)
#define FOR(I,A,B) for (int I=(A),I##_END_=(B);I<I##_END_;I++)
#define REPD(I,A,B) for (int I=(A),I##_END_=(B);I>=I##_END_;I--)
 
int n,m;
int cnt[101];
 
using namespace std;
 
int get_id(int x,int y){
	return (x-1)*n+y;
}
 
int mark;
int a[101];
int all=0;
 
 
void dfs(int p){
	if (p==n+1)
	{
		all |= cnt[ get_id( a[n],a[1] ) ];
		return ;
	}
	else
		for (int i=1;i<=n;i++)
			if (((mark>>i)&1)==0 && cnt[ get_id( a[p-1] , i) ] )
			{
				mark ^= 1<<i;
				a[p]=i;
				dfs(p+1);
			}
}
 
int main(){
	scanf("%d%d",&n,&m);
	int x,y;
	REP(i,1,m)
	{
		scanf("%d%d",&x,&y);
		cnt[get_id(x,y)]=cnt[get_id(y,x)]=1;
	}
 
	mark=2;
	a[1]=1;
	dfs(2);
	printf("%d\n",all);
 
	return 0;
}


2
1
1
2
