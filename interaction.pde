class Interaction {
  HashMap<Circle, HashMap<Circle, Integer>> pastInteractions; // Track past interactions

  Interaction() {
    pastInteractions = new HashMap<Circle, HashMap<Circle, Integer>>();
  }

  void checkInteraction(Circle c1, Circle c2) {
    float d = PVector.dist(c1.position, c2.position);
    float maxRadius = 1.5 * max(c1.radius, c2.radius);

    if (d < maxRadius) {
      color lineColor = lerpColor(c1.c, c2.c, 0.5);
      stroke(lineColor);
      strokeWeight(2);
      line(c1.position.x, c1.position.y, c2.position.x, c2.position.y);

      // Update or initialize interaction history if interaction just started
      if (!c1.currentlyInteracting.containsKey(c2) || !c1.currentlyInteracting.get(c2)) {
        c1.currentlyInteracting.put(c2, true);
        c2.currentlyInteracting.put(c1, true);

        if (!pastInteractions.containsKey(c1)) {
          pastInteractions.put(c1, new HashMap<Circle, Integer>());
        }
        if (!pastInteractions.containsKey(c2)) {
          pastInteractions.put(c2, new HashMap<Circle, Integer>());
        }
        HashMap<Circle, Integer> c1History = pastInteractions.get(c1);
        HashMap<Circle, Integer> c2History = pastInteractions.get(c2);

        if (!c1History.containsKey(c2)) {
          c1History.put(c2, 0);
        }
        if (!c2History.containsKey(c1)) {
          c2History.put(c1, 0);
        }

        // Increment interaction count only when a new interaction begins
        int previousInteractions = c1History.get(c2);
        c1History.put(c2, previousInteractions + 1);
        c2History.put(c1, previousInteractions + 1);
        c1.totalInteractions++;
        c2.totalInteractions++;

        // Determine if the interaction is cooperative or competitive
        if (previousInteractions >= 5) {
          // Cooperative interaction: Both circles grow
          c1.radius += 1;
          c2.radius += 1;
        } else {
          // Competitive interaction: Larger circle grows, smaller circle shrinks
          if (c1.radius > c2.radius) {
            c1.radius -= 1;
            c2.radius += 1;
          } else {
            c1.radius += 1;
            c2.radius -= 1;
          }
        }
      }
    } else {
      // Reset interaction status when circles move apart
      c1.currentlyInteracting.put(c2, false);
      c2.currentlyInteracting.put(c1, false);
    }
  }
}
