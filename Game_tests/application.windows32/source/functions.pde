

public float XConvertIntervalToCanvas(float x)
{
return (x);
}

public float YConvertIntervalToCanvas(float y)
{
return (height - y);
}


public void plotLine(float x1, float y1, float x2, float y2)
{
line(XConvertIntervalToCanvas(x1),
     YConvertIntervalToCanvas(y1),
     XConvertIntervalToCanvas(x2),
     YConvertIntervalToCanvas(y2));
}
