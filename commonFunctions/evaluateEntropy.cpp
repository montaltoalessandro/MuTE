#include <matrix.h>
#include <mex.h>
#include <stdlib.h>
#include <math.h>
/* Definitions to keep compatibility with earlier versions of ML */
#ifndef MWSIZE_MAX
typedef int mwSize;
typedef int mwIndex;
typedef int mwSignedIndex;

#if (defined(_LP64) || defined(_WIN64)) && !defined(MX_COMPAT_32)
/* Currently 2^48 based on hardware limitations */
# define MWSIZE_MAX    281474976710655UL
# define MWINDEX_MAX   281474976710655UL
# define MWSINDEX_MAX  281474976710655L
# define MWSINDEX_MIN -281474976710655L
#else
# define MWSIZE_MAX    2147483647UL
# define MWINDEX_MAX   2147483647UL
# define MWSINDEX_MAX  2147483647L
# define MWSINDEX_MIN -2147483647L
#endif
#define MWSIZE_MIN    0UL
#define MWINDEX_MIN   0UL
#endif
#define ISREAL2DFULLDOUBLE(P) (!mxIsComplex(P) && mxGetNumberOfDimensions(P) == 2 && !mxIsSparse(P) && mxIsDouble(P)) 
#define ISREALSQUAREMATRIXDOUBLE(P) (ISREAL2DFULLDOUBLE(P) && mxGetN(P) == mxGetN(P))
#define ISREALROWVECTORDOUBLE(P) (ISREAL2DFULLDOUBLE(P) && mxGetM(P) == 1)
#define ISREALCOLUMNVECTORDOUBLE(P) (ISREAL2DFULLDOUBLE(P) && mxGetN(P) == 1)
#define ISREALSCALAR(P) (ISREAL2DFULLDOUBLE(P) && mxGetNumberOfElements(P) == 1)
/* computational subroutine */

double xlnx(double x)
{
    if(x==0.) return(x); else return(x*log(x));
}

bool confronto( double *a,double *b,int nvar)
{
    int i;
    double sum=0.;
    for(i=0; i<nvar; i++) sum+=abs(a[i]-b[i]);
    return sum==0.0;
}
void printdata( double *a,int nvar)
{
    int i;
    for(i=0; i<nvar; i++) printf("%5.2f ",a[i]);
    printf("\n");
}
void Entropy(double *A,double *TE,int nvar,int n)
{
    int *ind = new int[n];
    double *col = new double[nvar];
    int i,j,k,m,l;
    double prob;
    i=1;
    k=n;
    for(l=0;l<n;l++) ind[l]=l;
    *TE=0;
    while(k>0)
    {
        for(l=0;l<nvar;l++) col[l]=A[ind[0]*nvar+l];
        j=0;
        prob=0;
        for (m=0;m<k;m++)
        {
            if (confronto(col,&A[ind[m]*nvar],nvar)) prob++;
            else ind[j++]=ind[m];
        }
        i++;
        k=j;
//         printf("prob=%5.2f k=%d\n",prob,k);
        *TE=*TE-xlnx(prob/n);
    }
    delete[] ind;
    delete[] col;
}
/* The gateway routine. */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
//declare variables
    mxArray *H0;
    int nvar,n,m=0;
    double *A,*TE;
/* Check the number of arguments */
    if(nrhs < 1 || nrhs > 1) mexErrMsgTxt("Wrong number of input arguments.");
/* Check arguments */
    if(!ISREAL2DFULLDOUBLE(prhs[0])) mexErrMsgTxt("A must be a real 2D full double array.");
///get inputs
    A = mxGetPr(prhs[0]);
    nvar=mxGetM(prhs[0]);
    n=mxGetN(prhs[0]);
//associate outputs
    H0 = plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
//associate pointers
    TE = mxGetPr(H0);
//     printf("nvar=%d n=%d\n",nvar,n);
//     printdata(&A[m*nvar],nvar);
//     printdata(&A[nvar],nvar);
//     printf("test=%d\n",confronto(&A[m*nvar],&A[nvar],nvar));
//do entropy
    Entropy(A,TE,nvar,n);
}
