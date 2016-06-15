import antclass

# ant = None
# pg = createGraphics(400, 400)
# build = None

w = 250
h = w
W = w*3
H = h*3
# escape_rad = min(w, h)/2
escape_rad = 50
max_iterations = 100

def setup():
    size(W, H, P2D)
    colorMode(RGB, 255, 255, 255, 1.0)
    global pg
    # pg = createGraphics(w, h)
    global buf
    buf = createGraphics(W, H)
    global ants
    ants = [antclass.antClass(W/2, H/2) for i in range(100)]
    buf.beginDraw()
    buf.background(0)
    buf.endDraw()
    # build()
    
# def markov_ant():
#     ant = antclass.antClass()
#     ant.place(w/2, h/2)

def build():
    ant = antclass.antClass(100,100)
    ant.set_bounds(0, 0, w, h, escape_rad)
    
    pg.beginDraw()
    startx = w/2
    starty = h/2
    black = color(0)
    white = color(255)
    for y in range(0, h):
        for x in range(0, w):
            ant.place(x, y)
            i = 0
            escaped = False
            while i < max_iterations:
                ant.move()
                if ant.escaped(w/2, h/2):#x, y):
                    escaped = True
                    break
                i += 1
            # c = color(100 + 155.0*float(i)/float(max_iterations), 100, 200)
            # pg.set(x, y, c)
            if escaped == True:          # Didn't escape
                # c = color(100 + 155.0*float(i)/float(max_iterations), 0, 100)
               c = color(255 - 155.0*float(i)/float(max_iterations), 100, 200)
               pg.set(x, y, c)
            else:                                  # Escaped
               # pg.set(x, y, color(100+155.0*float(i)/float(max_iterations), 0, 100))
               
               pg.set(x, y, black)
    pg.endDraw()

def draw():
    print frameRate
    buf.beginDraw()
    for j in range(10):
        for i in range(len(ants)):
            ants[i].move()
            buf.set(ants[i].x, ants[i].y, color(127 + 127*float(i)/len(ants), 0, 0, 0.3))
    buf.endDraw()
    image(buf, 0, 0, W, H)
    # image(pg, 0, 0, W, H)
    if  mousePressed:
        buf.beginDraw()
        buf.background(0)
        buf.endDraw()
        for i in range(len(ants)):
            ants[i].reset(W/2, H/2)
    if keyPressed:
        if key in [str(i) for i in range(1,10)]:
            val = int(key)
            if val in range(1, 10):
                buf.beginDraw()
                buf.background(0)
                buf.endDraw()
                for i in range(len(ants)):
                    ants[i].reset(W/2, H/2)
                    ants[i].Markov.create_balanced(float(val)/10.0, 3)