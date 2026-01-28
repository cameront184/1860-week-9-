class VirtualPet:
    #the class represents a virtual pet with a name, energy level, and hunger level.
    #The pet can play, eat, and sleep, which affect its energy and hunger.

    def __init__(self, name, energy=10, hunger=0):

    # here i am initializing a new pet that has a name, energy level and hunger level
        self.name = name
        self.energy = energy
        self.hunger = hunger
    

    def play(self):
    # This function allows the pet to play, playing reduces the energy level
    # the pet cannot play if energy is below 2
        if self.energy < 2:
            return f"{self.name} is too tired to play!"
        else:
            self.energy -= 2
            self.hunger += 2

    def feed(self):
        # feeding function means when fed the pets hunger lvl is reduced
        # hunger cant go below 0
        self.hunger -= 3
        if self.hunger < 0:
            self.hunger = 0
            return f"{self.name} is overfed!"

    def sleep(self):
    # sleeping means that the pets energy increases
        self.energy += 10

    def __str__(self):
    # this returns a string explaining the pets current status
        return f"{self.name} has {self.energy} energy points and hunger level {self.hunger}"

    def __eq__(self, other):
     #Compares two VirtualPet objects for equality based on name, energy, and hunger
        if self.name == other.name and self.energy == other.energy and self.hunger == other.hunger:
            return True
        else:
            return False
