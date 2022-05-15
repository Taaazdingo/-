PImage img;  //图像变量
ArrayList<Particle> particles;
float noiseScale = 80;
float noiseStrength = 9;
float step = 1;
float noiseZ = 0.001;
float bright = 30;

void setup(){
  size(1292,1428);
  colorMode(HSB, 360, 100, 100, 100);
  //img = loadImage("Kyoujurou1.png");  
  img = loadImage("Kyoujurou.png");  //大小是646x714
  noStroke();
  initialize();
}

void draw(){
    for(Particle p :  particles){
      p.show();
      p.move();
    }
}

void newParticles(){
  particles = new ArrayList<Particle>();
  blendMode(SCREEN);
  //遍历整个画面
  for(int j = 0;j < height;j++){
    for(int i = 0;i < width;i++){
      color c = get(i,j);  //获取像素点的颜色
      if(brightness(c) < bright){  //如果像素点的明度小于10
        particles.add(new Particle(i,j));  //那么在该点生成一个粒子
      }
    }
  }
}

void initialize(){
  blendMode(BLEND);
  noiseSeed(frameCount);
  image(img,0,0,width,height);  //把图片打印出来
  newParticles();  //在指定区域生成粒子
}

void mousePressed(){
  initialize();
}

void keyPressed(){
  if(key == 's')
    saveFrame("####.png");  //保存的格式是"####.png"
}

//-------------------------------------------------------------------

class Particle {
 PVector pos;  //向量pos
 float angle;  //角度
 float count; //计次数
 //构造器
 Particle(float x,float y) {
   pos = new PVector(x, y);  //随机位置
   angle = random(10);
   count = 0;
 }

 void show() {

   //fill(map(noise(angle), 0, 1, 0, 360), 60, 60, 15);
   //fill(map(noise(angle), 0, 1, 140, 300), 60, 60, 15);
   fill(map(random(10), 0, 10, 0, 10), 89, 95, 15); //大哥配色
     //fill(map(noise(angle), 0, 1, 0, 300), 60, 60, 15);
     //fill(map(noise(angle), 0, 1, 0, 100), 60, 60, 15);
     //fill(map(noise(angle), 0, 1, 210, 360), 60, 60, 15);
   circle(pos.x, pos.y,1);
 }

//移动
 void move() {
    //angle = noise(pos.x/noiseScale, pos.y/noiseScale, count) * noiseStrength;
    angle = noise(pos.x/noiseScale, pos.y/noiseScale) * noiseStrength;
   //粒子位置变化
   pos.x += cos(angle) * step; 
   pos.y += sin(angle) * step;
   count += noiseZ ;  //重点！随时间变化了，所以线路不那么固定
   //step += 0.005;
 }
}
