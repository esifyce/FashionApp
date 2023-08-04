#ifndef _RECOGNISE_H
#define _RECOGNISE_H
#ifndef NOMINMAX

#ifndef max
#define max(a,b)            (((a) > (b)) ? (a) : (b))
#endif

#ifndef min
#define min(a,b)            (((a) < (b)) ? (a) : (b))
#endif

#endif  /* NOMINMAX */
#ifndef PI
#define PI 3.1415926
#endif

#define _DEBUG 1 
typedef struct
{
	float x;
	float y;
}CvPoint;

typedef enum       // the shape of drawing
{
	LINE,
	TRIANGLE,
	RECTANGLE,
	CIRCLE,
	ELLIPSE,
	DIAMOND,
    FOLDLINE,
    CURVE,
    ARROW,
    PARALLELOGRAM,
	UNKONWN,
}Shape;

typedef struct    //Triangle's output
{
	CvPoint ptA;
	CvPoint ptB;
	CvPoint ptC;
}TriangleOutput;

typedef struct      //Line output
{
	CvPoint begin;
	CvPoint end;
}LineOutput;

typedef struct		//Circle's output
{
	CvPoint center;
	int radius;
}CircleOutput;

typedef struct	  //Ellipse's output
{
	float width;
	float height;
	CvPoint center;
	double radian;
}EllipseOutput;

typedef struct    //diamond and rectangle's output
{
	CvPoint ptA;
	CvPoint ptB;
	CvPoint ptC;
	CvPoint ptD;
	double radian;	
}DiaRecOutput;

typedef struct
{
	CvPoint ptA;
	CvPoint ptB;
	CvPoint ptC;
	CvPoint ptD;
	double thetaRotating;  //
}RectangleOutPut;

typedef struct
{
    CvPoint* inflexionPoint;
    int iNumInflexionPoint;
    
} FoldLineType;

typedef struct
{
    CvPoint lineBegin;
    CvPoint lineEnd;
    CvPoint inflexionLine_1;
    CvPoint inflexionLine_2;
}ArrowType;

/*
 #### function: define the struct of curve;
      parameter: the coefficient of curve equation  
 */
typedef struct
{
    float coefficientA;
    float coefficientB;
    float coefficientC;
    float coefficientD;
    float coefficientE;
    float coefficientF;    
}CurveType;

typedef struct
{
    CvPoint pointA;
    CvPoint pointB;
    CvPoint pointC;
    CvPoint pointD;
}TypeParallelogram;

//output 
typedef struct {
	Shape shape;
    union Output {
        LineOutput          line;
        TriangleOutput      triangle;
        CircleOutput        circle;
        EllipseOutput       ellipse;
        DiaRecOutput        diarec;
        FoldLineType        foldLineOutput;
        CurveType           curveOutput;
        ArrowType           arrowOutput;
        TypeParallelogram   parallelogram;
	} output;
}OutputShape;

typedef struct{   //triangle'output and its return value
	CvPoint ptA;
	CvPoint ptB;
	CvPoint ptC;
	double area;
}Triangle_1;

typedef struct     //struct of rectangle
{
	CvPoint ptA;
	CvPoint ptB;
	CvPoint ptC;
	CvPoint ptD;
	double  area;
}RectangleMax;

typedef struct{                  //Save all points in preparation for multi-stroke recognition
    CvPoint* points;
    int      numberPoints;
} PointsSave;


extern PointsSave pointsSave[100];
extern OutputShape shapeResult[10];    //Used to save each identification results.


#endif
