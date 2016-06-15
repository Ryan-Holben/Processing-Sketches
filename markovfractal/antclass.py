import markov

class antClass:
    def __init__(self, x = 0, y = 0):
        self.place(x, y)
        self.Markov = markov.Markov()
        self.direction = int(random(4))
        
    def reset(self, x, y):
        self.place(x, y)
        self.Markov.state = int(random(self.Markov.num_states))
        self.direction = int(random(4))
    
    def place(self, x, y):
        self.x = x
        self.y = y
        
    def move(self):
        # Increment Markov chain
        self.Markov.step()
        # Use Markov result to continue straight, turn right, or turn left
        if self.Markov.state == 0:
            self.direction = self.direction
        elif self.Markov.state == 1:
            self.direction = (self.direction + 1) % 4
        elif self.Markov.state == 2:
            self.direction = (self.direction - 1) % 4
            
        
        if self.direction == 0:
            self.x -= 1
        elif self.direction == 1:
            self.x += 1
        elif self.direction == 2:
            self.y -= 1
        elif self.direction == 3:
            self.y += 1
    
    def escaped(self, startx, starty):
        return (1.0*self.x - 1.0*startx)**2 + (1.0*self.y - 1.0*starty)**2 > self.radsquared
        
    def set_bounds(self, minx, miny, maxx, maxy, rad):
        self.radsquared = 1.0*rad**2