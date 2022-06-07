# 🔥Kyoujurou🔥
燃烧的炼狱杏寿郎，Generative art by Processing.



之前玩Processing搞出了很像火焰的效果，就很想给大哥做个艺术生成画。但是本人太懒，放了好一段时间，这几天终于在Python作业ddl的淫威下把它赶出来了（但其实先写的Java版本再转成Python😄）。

<table>
    <tr>
        <td>
            <img src="README/renderings.png" alt="renderings" style="width: 50%;" />
        </td>
        <td>
            <img src="README/Kyoujurou.png" alt="Kyoujurou"  style="zoom: 100%;"/>
        </td>
    </tr>
</table>

<!--more-->

>**说在前面**
>
>原图是我在Google上识图找的，侵删！
>
>首先要非常感谢[おかず](https://note.com/outburst)大佬的开源代码，代码思路其实大部分都是来自于这位大佬。他还做了很多别的艺术生成画，大都很有趣也很好看，推荐去看看！（不过上note网需>要一些魔法←_←）
>
>我的代码可以在[仓库](https://github.com/Taz-dingo/Burning-Kyoujurou)看，包括Java版和Python版。

## 原理

### 特殊效果

效果的核心就是是noise()噪声函数 + 粒子轨迹。

noise()其实就是一个“自然”的随机数（区别于 random() ），它的返回值是趋于正态分布的，看起来更“自然”、更漂亮（类似斐波那契数列，也是自然好看。也许自然界的生物就是会觉得“自然”的好看？感觉好神奇0.0）。把noise()和粒子的一些属性（位移、颜色等等）绑在一起，配上合适的参数，粒子运动轨迹就可以产生一些有意思和好看的图形。

此处就用noise()操控了粒子的位移属性：

```java
//根据noise()计算偏移角度
angle = noise(pos.x/noiseScale, pos.y/noiseScale) * noiseStrength;
//粒子位置根据angle值变化
pos.x += cos(angle) * step; 
pos.y += sin(angle) * step;
```

### 让指定区域产生效果

“刺绣法”。因为效果其实就是粒子的轨迹，所以想要只在指定区域产生效果只需要让粒子就生成在指定区域就行了。“刺绣法”用人话说就是拿来一张底图，根据它的图形来规定粒子的生成位置。

## 代码实现

### 导入图片

用的是Processing自带的库函数loadImage，用法官方文档讲的最清楚，就不多说了。

### 定义粒子类

粒子对象被创建时会根据传入参数被赋予坐标（传入参数在下面的“刺绣法”里算出）。

```java
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
}
```

### 明度“刺绣法”生成粒子

此处利用的是像素的明度来“刺绣”（也就是确定范围）[^1]。每帧遍历画布里的每个像素，明度低于某阈值的像素处可以生成粒子。

```java
//遍历整个画面
for(int j = 0;j < height;j++){
    for(int i = 0;i < width;i++){
        color c = get(i,j);  //获取像素点的颜色
        if(brightness(c) < bright){  //如果像素点的明度小于bright
            particles.add(new Particle(i,j));  //那么粒子容器加入一个新粒子（粒子坐标为此处）
        }
    }
}
```

### 粒子移动

粒子类加入move方法

```java
void move() {
    //angle = noise(pos.x/noiseScale, pos.y/noiseScale, count) * noiseStrength;
    angle = noise(pos.x/noiseScale, pos.y/noiseScale) * noiseStrength;
   //粒子位置变化
   pos.x += cos(angle) * step; 
   pos.y += sin(angle) * step;
   count += noiseZ ;  //重点！随时间变化了，所以线路不那么固定
   //step += 0.005;
}
```



大致思路是这样，其他不好懂的就是Processing内库的函数了，可以直接到[官方文档](https://processing.org/reference)哪里不会查哪里。



[^1]: おかず.[Generative Art #126](https://note.com/outburst/n/nf4643a27cd7e)

