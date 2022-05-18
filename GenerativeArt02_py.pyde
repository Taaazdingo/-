#Powered by Tazdingo



partList = [] #粒子集合

noiseScale = 80 #噪声规模，放在分母的参数调整噪声函数的读取

noiseStrenth = 9 #噪声强度，调整噪声值变化剧烈程度（因为noise返回值为0-1）

step = 1 #坐标变化强度值，调整坐标变化的剧烈程度

bright = 25 #可生成粒子的最大明度值



def setup():

    size(646,714) #画布大小

    colorMode(HSB, 360, 100, 100, 100) #颜色模式设置为HSB，四个参数分别为H、S、B和alpha（透明度）

    noStroke()  #不要描边

    initialize()  #初始化

    

def draw():

    for p in partList:  #遍历partList里的每一个Particle粒子对象

        p.show()  #画出粒子

        p.move()  #改变粒子坐标

        

  

#重置粒子容器

def newParticles():

    del partList[:]  #清空列表

    blendMode(SCREEN);  #混色模式SCREEN

    for j in range(height):  #遍历画面中每个像素点

        for i in range(width):

            c = get(i,j)  #获取像素点的颜色

            if brightness(c) < bright: #如果像素点的明度小于bright

                partList.append(Particle(i,j)) #那么在该点生成一个粒子

    

def initialize():

    blendMode(BLEND)  #混色模式BLEND（也就是默认的模式）

    noiseSeed(frameCount) #重置噪声种子

    img = loadImage("Kyoujurou.png")  #这张图片大小是646x714

    image(img,0,0)  #把图片打印出来

    newParticles()    #生成粒子

    

def mousePressed():  #按下鼠标重置画面

    initialize()

    

def keyPressed():  #按下s键保存图片到代码目录

  if key == 's':

    saveFrame("####.png")  #保存的格式是"####.png"

    

#----------------------------分割线--------------------------------------



#粒子类

class Particle:

    pos = PVector(0,0)  #坐标

    angle = 0  #角度

    

    def __init__(self,x,y):

        self.pos = PVector(x,y)  #根据传入x、y参数设置坐标

        

    def move(self):

        self.angle = noise(self.pos.x/noiseScale , self.pos.y/noiseScale ) * noiseStrenth #角度由噪声计算

        #坐标根据角度变化

        self.pos.x += cos(self.angle) * step 

        self.pos.y += sin(self.angle) * step

        

    def show(self):  #画粒子方法

        fill(map(random(10), 0, 10, 0, 15), 89, 95, 15) #大哥的配色

        circle(self.pos.x, self.pos.y, 1)  #画圆
