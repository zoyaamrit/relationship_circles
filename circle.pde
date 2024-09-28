class Circle {
  PVector position;
  float radius;
  PVector velocity;
  color c;
  int totalInteractions;  // Track total number of interactions
  float opacity;  // Store current opacity
  boolean inInteraction;
  HashMap<Circle, Boolean> currentlyInteracting; // Track ongoing interactions

  Circle(float x, float y, float r, color col) {
    position = new PVector(x, y);
    radius = r;
    velocity = PVector.random2D();
    c = col;
    totalInteractions = 0;
    opacity = 100;
    inInteraction = false;
    currentlyInteracting = new HashMap<Circle, Boolean>();
  }

  void move() {
    position.add(velocity);

    // Keep movement within window
    if (position.x < radius || position.x > width - radius) {
      velocity.x *= -1;
    }
    if (position.y < radius || position.y > height - radius) {
      velocity.y *= -1;
    }
  }

  void display() {
    fill(c, opacity);  // Use the current opacity
    noStroke();
    ellipse(position.x, position.y, radius, radius);
  }
}
