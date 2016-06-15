import copy
from pprint import pprint

class Markov:
    def __init__(self):
        # self.m = [[0.8, 0.1, 0.1],
        #           [0.1, 0.8, 0.1],
        #           [0.1, 0.1, 0.8]]
        self.create_balanced(.9, 3)
        self.num_states = len(self.m)
        self.state = int(random(self.num_states))
        self.convert_to_measure_matrix()
        
    def create_balanced(self, k, dim):
        """Create a matrix with k on the diagonal, and all nondiagonal entries identical."""
        j = (1.0 - k) / (dim - 1)
        self.m = []
        for index in range(dim):
            row = [j] * dim
            row[index] = k
            self.m.append(row)
        self.num_states = dim
        self.convert_to_measure_matrix()
        pprint(self.m)
        
    def convert_to_measure_matrix(self):
        """Converts a Markov matrix to a more useable form."""
        self.M = copy.deepcopy(self.m)

        for row in range(self.num_states):
            accum = 0
            for col in range(self.num_states):
                accum += self.m[row][col]
                self.M[row][col] = accum
                
        # pprint(self.m)                
        # pprint(self.M)
        
    def step(self):
        row = self.state
        rand = random(1)
        for col in range(self.num_states):
            if rand < self.M[row][col]:
                break
        self.state = col