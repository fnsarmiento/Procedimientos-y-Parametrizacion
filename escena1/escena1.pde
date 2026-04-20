float original_w = 800;
float original_h = 600;


class Element 
{
	int stroke_size = 0;
	color stroke = color(0);
	color fill = color(255);
	PVector pos = new PVector();
	float rot = 0;
	float attraction_force = 0.1;
	
	
	void display()
	{
		if (stroke_size > 0)
		{
			stroke(stroke);
			strokeWeight(stroke_size);
		} else
		{
			noStroke();
		}
	
		fill(fill);
	}
	
	void attract(float x, float y)
	{
		pos.x = lerp(pos.x, x, attraction_force);
		pos.y = lerp(pos.y, y, attraction_force);
		rot = atan2(y - pos.y, x - pos.x);
	}
}
class Rect extends Element
{
  PVector size = new PVector();

  @Override
  void display()
  {
    super.display();
    pushMatrix();
    translate(x(pos.x), y(pos.y));
    rotate(rot);
    
    rect(0, 0, x(size.x), y(size.y)); 
    popMatrix();
  }
}

// NOTE: el triangulo siempre es relativo por lo que al rotar puede no estar pegado al mouse sino a cierta distancia
class Triangle extends Element
{
  
  PVector v1 = new PVector(), v2 = new PVector(), v3 = new PVector();

  @Override
  void display()
  {
    super.display();
    pushMatrix();
    translate(x(pos.x), y(pos.y));
    rotate(rot);
    
    triangle(x(v1.x), y(v1.y), x(v2.x), y(v2.y), x(v3.x), y(v3.y));
    popMatrix();
  }
}

class Circle extends Element
{
  float radius;

  @Override
  void display()
  {
    super.display();
    
    pushMatrix();
    translate(x(pos.x), y(pos.y));
    ellipse(0, 0, x(radius), y(radius));
    popMatrix();
  }
}

class Line extends Element
{
  PVector end = new PVector();

  @Override
  void display()
  {
    super.display();
    stroke(stroke);
    strokeWeight(stroke_size);
    
    pushMatrix();
    translate(x(pos.x), y(pos.y));
    rotate(rot);
    line(0, 0, x(end.x), y(end.y));
    popMatrix();
  }
}

class Ellipse extends Element
{
  float radiusX, radiusY;

  @Override
  void display()
  {
    super.display();
    pushMatrix();
    translate(x(pos.x), y(pos.y));
    rotate(rot);
    ellipse(0, 0, x(radiusX), y(radiusY));
    popMatrix();
  }
}

Rect rect;
Triangle triangle;
Line line;
Circle circle;
Ellipse ellipse;

void setup()
{
	size(800, 600);
	windowResizable(true);
	noSmooth();
	
	rect = new Rect();
	rect.pos.x = 488;
	rect.pos.y = 238;
	rect.size.x = 209;
	rect.size.y = 230;
	rect.fill = color(230, 20, 120);

	circle = new Circle();
	circle.pos.x = 500;
	circle.pos.y = 300;
	circle.radius = 90;
	circle.fill = color(230, 255, 20);
	
	triangle = new Triangle();
	triangle.pos.x = 200;
	triangle.pos.y = 300;
	triangle.v1.x = 75;
	triangle.v1.y = 100;
	triangle.v2.x = 120;
	triangle.v2.y = -17;
	triangle.v3.x = 195;
	triangle.v3.y = 100;
	triangle.fill = color(0, 240, 120);
	
	ellipse = new Ellipse();
	ellipse.pos.x = 200;
	ellipse.pos.y = 100;
	ellipse.radiusX = 40;
	ellipse.radiusY = 80;
	ellipse.fill = color(30, 80, 200);

	line = new Line();
	line.stroke_size = 20;
	line.pos.x = 302;
	line.pos.y = 490;
	line.end.x = 18;
	line.end.y = -260;
	line.stroke = color(150, 130, 230);
}

void draw()
{
	background(140);

	rect.display();
	triangle.display();
	line.display();
	circle.display();
	ellipse.display();

	if (mousePressed && mouseButton == LEFT)
	{
	rect.attract(mouseX, mouseY);
	triangle.attract(mouseX, mouseY);
	line.attract(mouseX, mouseY);
	circle.attract(mouseX, mouseY);
	ellipse.attract(mouseX, mouseY);
	}
}

void rectR(float x, float y, float w, float h) { rect(x(x), y(y), x(w), y(h)); }
void rectR(float x, float y, float w, float h, float r) { rect(x(x), y(y), x(w), y(h), r); }
void triangleR(float x1, float y1, float x2, float y2, float x3, float y3) { triangle(x(x1), y(y1), x(x2), y(y2), x(x3), y(y3)); }
void ellipseR(float x, float y, float r1, float r2) { ellipse(x(x), y(y), x(r1), y(r2)); }
void circleR(float x, float y, float r) { ellipse(x(x), y(y), x(r), y(r)); }
void lineR(float x1, float y1, float x2, float y2) { line(x(x1), y(y1), x(x2), y(y2)); }

float x(float pos) {
	return pos * (width / original_w);
}

float y(float pos) {
	return pos * (height / original_h);
}
