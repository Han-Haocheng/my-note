```c++
void CTestView::EllipsePoint(double x, double y,CDC *pDC) 
{ 
	CP2 pc=CP2((p0.x+p1.x)/2.0,(p0.y+p1.y)/2.0); // 椭圆中心点 
	COLORREF clr=RGB(0,0,255); // 蓝色 
	// 一次画 4 个对称点！！！ 
	pDC->SetPixelV(Round(x+pc.x), Round(y+pc.y), clr); 
	pDC->SetPixelV(Round(-x+pc.x), Round(y+pc.y), clr); 
	pDC->SetPixelV(Round(x+pc.x), Round(-y+pc.y), clr); 
	pDC->SetPixelV(Round(-x+pc.x), Round(-y+pc.y), clr); 
}


void CTestView::MBEllipse(CDC *pDC) 
{ 
	double x,y,d1,d2,a,b; 
	a=fabs(p1.x-p0.x)/2; // 椭圆长/短半轴：水平方向半径
	b=fabs(p1.y-p0.y)/2; // 垂直方向半径 
	x=0; y=b; // 起点：椭圆最上方的点 (0, b)
	d1=b*b+a*a*(-b+0.25); // 第一段决策参数（和直线 d 一模一样作用）
	EllipsePoint(x,y,pDC); // 画当前点（并自动画对称的另外3个点）
	
	while(b*b*(x+1) < a*a*(y-0.5)) // 上半段条件 
	{ 
		if (d1 < 0) // 决策判断：d1 是裁判 
		{
			d1 += b*b*(2*x+3); // 只更新 d，y 不动 
		} 
		else 
		{ 
			d1 += b*b*(2*x+3)+a*a*(-2*y+2); 
			y--; // y 往下走一格 
			} 
		x++; // x 永远向右走 
		EllipsePoint(x,y,pDC); // 画点 
	}
	
	d2 = b*b*(x+0.5)*(x+0.5) + a*a*(y-1)*(y-1) - a*a*b*b; 
	while(y>0) // 画到最下面为止             
	{ 
		if (d2 < 0) 
		{ 
			d2 += b*b*(2*x+2)+a*a*(-2*y+3); 
			x++; // x 向右走 
		} 
		else 
		{ 
			d2 += a*a*(-2*y+3); 
		} 
		y--; // y 永远向下走 
		EllipsePoint(x,y,pDC); 
	}
	

```