ArrayList<Circle> circles;
boolean isMousePressed = false;
PVector center;
Interaction interaction;
int pressStartTime;
color current_c;

void setup() {
  size(800, 800);
  circles = new ArrayList<Circle>();
  center = new PVector(width / 2, height / 2);
  interaction = new Interaction();
  smooth();
}

void draw() {
  background(255);

  for (int i = circles.size() - 1; i >= 0; i--) {  // Iterate backwards to safely remove elements
    Circle c1 = circles.get(i);
    c1.move();
    c1.display();
    
    // Handle interactions between circles
    for (int j = i - 1; j >= 0; j--) {  // Iterate backwards to safely remove elements
      Circle c2 = circles.get(j);
      interaction.checkInteraction(c1, c2);
    }

    // Check for deletion conditions
    if (c1.radius > 300) {
      circles.remove(i);  // Remove circle if size is less than 5
      continue;
    }

    // Handle opacity change for more than 10 interactions
    if (c1.totalInteractions > 20) {
      c1.opacity = min(c1.opacity + 5, 255);
    }
  }

  // Handle circle creation when mouse is pressed
  if (isMousePressed) {
    float size = (millis() - pressStartTime) / 10.0; // modify size based on current time and start time
    fill(current_c, 100);
    noStroke();
    ellipse(mouseX, mouseY, size, size);
  }
}

void mousePressed() {
  isMousePressed = true;
  pressStartTime = millis(); // when mouse is pressed
  current_c = color(random(255), random(255), 255, 100);
}

void mouseReleased() {
  isMousePressed = false;
  float size = (millis() - pressStartTime) / 10.0; // growth rate
  circles.add(new Circle(mouseX, mouseY, size, current_c));
  pressStartTime = 0; // Reset pressStartTime
}
