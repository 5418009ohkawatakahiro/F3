int player = 0;
int level = 0;
int clear = 0;
float stm;
class Option {
  int col=20;
  int x = width/2;
  int y = height/2;
  void drawtitle() {
    background(0, 0, 255);
    int x2 = 20;
    int y2 = 0;
    fill(255, 255, 0);
    while (x2 <= width) {
      ellipse(x2, 20, 25, 25);
      ellipse(x2, 980, 25, 25);
      x2+= 40;
    }
    fill(255);
    ellipse(x, height/4, 600, 150);  
    fill(0, 0, 255);
    textAlign(CENTER);
    textSize(120);
    text("aun", x-300, height/8, 600, 150);
    for (int i = 0; i < 2; i++) {
      fill(255);
      rect(x-150, y+y2, 300, 70);
      fill(0, 0, 255);
      textSize(60);
      if (i == 0) {
        text("1play", x-150, y, 300, 70);
      } else {
        text("2play", x-150, y+y2, 300, 70);
      }
      y2 +=140;
    }
  }
  void selectlevel() {
    background(0, 0, 255);
    int y2 = -70;
    int x2 = 20;
    fill(255, 255, 0);
    while (x2 <= width) {
      ellipse(x2, 20, 25, 25);
      ellipse(x2, 980, 25, 25);
      x2+= 40;
    }
    fill(255);
    ellipse(x, height/4, 600, 150);  
    fill(0, 0, 255);
    textAlign(CENTER);
    textSize(120);
    text("aun", x-300, height/8, 600, 150);
    for (int i = 0; i < 3; i++) {
      fill(255);
      rect(x-150, y+y2, 300, 70);
      fill(0, 0, 255);
      textSize(60);
      if (i == 0) {
        text("easy", x-150, y+y2, 300, 70);
      } else if (i == 1) {
        text("nomal", x-150, y+y2, 300, 70);
      } else {
        text("hard", x-150, y+y2, 300, 70);
      }
      y2 += 140;
    }
  }
  void stage() {
    background(0);
  }
  void play_clear() {
    background(0);
    fill(255, 255, 0);
    fill(255);
    ellipse(x, y, 700, 600);  
    fill(0, 0, 255);
    textAlign(CENTER);
    textSize(250);
    text("clear", x-350, y-150, 700, 600);
  }
  void gameover() {
    fill(255, 0, 0, col);
    rect(0, 0, width, height);
    fill(0, 0, 0, col);
    textAlign(CENTER);
    textSize(150);
    text("Game Over", x-350, y-150, 700, 600);
    if (col<=255-20) {
      col+=3;
    }
  }
  void a() {
    if (player == 0) {
      drawtitle();
      if (mousePressed) {
        if (mouseX >= x-150 && mouseX <= x+150 && mouseY >= height/2 && mouseY <= height/2 + 70) {
          player = 1;
        } else if (mouseX >= x-150 && mouseX <= x+150 && mouseY >= height/2+140 && mouseY <= height/2+210) {
          player = 2;
        }
      }
    }
    if (player == 1 || player == 2) {
      selectlevel();
      if (mousePressed) {
        if (mouseX >= x-150 && mouseX <= x+150 && mouseY >= height/2-70 && mouseY <= height/2) {
          level = 1;
        } else if (mouseX >= x-150 && mouseX <= x+150 && mouseY >= height/2+70 && mouseY <= height/2+140) {
          level = 2;
        } else if (mouseX >= x-150 && mouseX <= x+150 && mouseY >= height/2+210 && mouseY <= height/2+280) {
          level = 3;
        }
      }
    }
    s.makeStage((level-1)*2+3);
  }
}

class Stage {
  float[] ox, oy, ow, oh, holex, holey, holew;
  float earth;
  int step, linex=width;
  float tm, temp;
  int textx=width+width/2;
  int elpsx=width+width/2;
  void makeStage(int num) {
    ox=new float[num];
    oy=new float[num];
    ow=new float[num];
    oh=new float[num];
    holex=new float[num];
    holey=new float[num];
    holew=new float[num];
    earth=50;
    step=5;
    for (int i=0; i<ox.length; i++) {
      ox[i]=width/(num)*(i+1)+width;
      int flag=int(random(2));
      if (flag==0) {
        oh[i]=int(random(height/4/2*3, (height-2*earth)/2-200));
        oh[i]=(height-earth)/3*(randomGaussian()/10+1);
        //oh[i]=(1+randomGaussian())*height/4;
        oy[i]=height-oh[i]-earth;
      } else {
        oh[i]=int(random(height/4/2*3, (height-2*earth)/2-200));
        oh[i]=(height-earth)/3*(randomGaussian()/10+1);
        oy[i]=earth;
      }
      ow[i]=int(random(50, width/10));
    }
    for (int i=0; i<holex.length; i++) {
      holex[i]=width/(num+1)*(i+1)+width;
      holey[i]=(height-earth)*int(random(2));
      holew[i]=int(random(50, width/5));
    }
  }
  void obstacle_and_hole() {
    noStroke();
    tm=millis();
    temp=tm-stm;
    if (temp<=3*1000) {
      drawcnt(temp);
      fill(115, 66, 41);
      rect(0, 0, width, earth);
      rect(0, height-earth, width, earth);
      fill(0, 200, 255);
      for (int i=0; i<holex.length; i++) {
        rect(holex[i], holey[i], holew[i], earth);
      }
      return;
    }
    fill(115, 66, 41);
    rect(0, 0, width, earth);
    rect(0, height-earth, width, earth);
    for (int i=0; i<holex.length; i++) {
      if (holex[i]+holew[i]<=0) {
        holex[i]=width;
        holey[i]=(height-earth)*int(random(2));
        holew[i]=int(random(50, width/5));
      }
      fill(0, 200, 255);
      rect(holex[i], holey[i], holew[i], earth);
      holex[i]-=step;
    }
    for (int i=0; i<ox.length; i++) {
      fill(115, 66, 41);
      if (oy[i]==earth) {
        rect(ox[i], 0, ow[i], earth);
      } else {
        rect(ox[i], height-earth, ow[i], height);
      }
      fill(255, 20, 150);
      rect(ox[i], oy[i], ow[i], oh[i]);

      if (ox[i]+ow[i]<=0) {
        ox[i]=width;
        int flag=int(random(2));
        if (flag==0) {
          oh[i]=int(random(100, (height-2*earth)/2-200));
          oy[i]=earth;
        } else {
          oh[i]=int(random(100, (height-2*earth)/2-200));
          oy[i]=height-oh[i]-earth;
        }
        ow[i]=int(random(50, width/10));
      }
      ox[i]-=step;
    }
    if (15*1000<temp) {
      fill(255, 255, 0);
      rect(linex, 0, width-linex, height);
      fill(115, 66, 41);
      rect(linex, 0, width-linex, earth);
      rect(linex, height-earth, width-linex, earth);
      fill(255);
      ellipse(elpsx, height/2, width/2, height/2);
      linex-=step;
      textSize(150);
      fill(0, 0, 255);
      text("clear", textx, height/2+height/20);
      textx-=step;
      elpsx-=step;
    }
  }
  boolean is_goal() {
    if (linex<0) {
      step = 0;
      return true;
    } else {
      return false;
    }
  }
  void drawcnt(float tm) {
    textSize(100);
    if (tm<=1*1000) {
      text("3", width/2, height/2);
    } else if (tm<=2*1000) {
      text("2", width/2, height/2);
    } else {
      text("1", width/2, height/2);
    }
  }
}

class Player {
  int x;
  float y;
  float vy = 5;
  float dy = 3;
  float ddy =1;
  boolean reverse = false;
  boolean isCrash = false;
  int a=1;
  Player(int x1, float y1) {
    x=x1;
    y=y1;
  }
  void drawAun() {

    stroke(0);
    if (a==1) {
      rect(x-15, y, 30, 50);

      ellipse(x, y-30, 60, 60);
      fill(255, 255, 0);
      ellipse(x-19, y-30, 16, 16);
      ellipse(x+19, y-30, 16, 16);   
      fill(0);
      stroke(0);
      line(x-10, y+50, x-20, y+60);
      line(x+10, y+50, x+20, y+60);
    } else {
      rect(x-15, y-50, 30, 50);
      ellipse(x, y+30, 60, 60);
      fill(255, 255, 0);
      ellipse(x-19, y+30, 16, 16);
      ellipse(x+19, y+30, 16, 16);   
      fill(0);
      stroke(0);
      line(x-20, y-60, x-10, y-50);
      line(x+20, y-60, x+10, y-50);
    }
  }
  void gravity() {
    if (y-60 < 50 && vy<=-5) {
      reverse=false;
    } else if (height-50<y+60 && 5<=vy) {
      reverse=false;
    }
    if (reverse) {
      y += vy;
    }
  }
  void crash() {
    for (int i = 0; i <s.ox.length; i++ ) {
      if (y > height/2 && a==1) {
        if (x+30 > s.ox[i] && x-30 < s.ox[i]+s.ow[i] && y+60 > s.oy[i] && y-60 < s.oy[i]+s.oh[i]) {
          isCrash = true;
        }
      } else if (y > height/2 && a==-1) {
        if (x+30 > s.ox[i] && x-30 < s.ox[i]+s.ow[i] && y+60 > s.oy[i] && y-60 < s.oy[i]+s.oh[i]) {
          isCrash = true;
        }
      } else if (y <= height/2 && a==1) {
        if (x+30 > s.ox[i] && x-30 < s.ox[i]+s.ow[i] && y+60 > s.oy[i] && y-60 < s.oy[i]+s.oh[i]) {
          isCrash = true;
        }
      } else if (y <= height/2 &&a==-1) {        
        if (x+30 > s.ox[i] && x-30 < s.ox[i]+s.ow[i] && y+60 > s.oy[i] && y-60 < s.oy[i]+s.oh[i]) {
          isCrash = true;
        }
      }
      if (y > height/2 && a == 1) {
        if (x+30 > s.holex[i] && x-30 < s.holex[i]+s.holew[i] && y+60 >= height-s.earth && s.holey[i]==height-s.earth) {
          isCrash = true;
        }
      } else if (y <= height/2  && a == -1) {
        if (x+30 > s.holex[i] && x-30 < s.holex[i]+s.holew[i] &&  y-60 <= s.earth && s.holey[i]==0) {
          isCrash = true;
        }
      }
    }
  }
  void draw_goal() {
    a=1;
    drawAun();
    if (height-s.earth<=y+60) {
      dy*=-1;
      y+=dy;
    } else {
      dy+=ddy;
      y+=dy;
    }
    x+=5;
  }
}
class Manager {
  int sum;
  boolean goal=false;
  void manage() {
    if (15*1000>=s.temp) {
      for (int i=0; i<player; i++) {
        if (p[i].isCrash==true) {
          sum++;
        }
      }
    }
    if (sum==0) {
      if (level==0) {
        o.a();
        stm=millis();
      } else {
        s.obstacle_and_hole();
        goal=s.is_goal();
        if (goal) {
          for (int i=0; i<player; i++) {
            if (i == 0) {
              fill(255, 102, 0);
            } else {
              fill(204, 255, 51);
            }
            p[i].draw_goal();
          }
          return;
        }
        for (int i=0; i<player; i++) { 
          if (i == 0) {
            fill(255, 102, 0);
          } else {
            fill(204, 255, 51);
          }
          p[i].drawAun();
          p[i].gravity();
          p[i].crash();
        }
      }
    } else {
      o.gameover();
    }
  }
}

Stage s;
Player[] p=new Player[2];
Option o;
Manager m;
void setup() {
  size(1200, 700);
  noStroke();
  s=new Stage();
  o = new Option();
  p[0]=new Player(100, height-110);
  p[1]=new Player(100, 110);
  p[1].a *= -1;
  p[1].vy *= -1;
  m=new Manager();
}

void draw() {
  background(0, 200, 255);
  m.manage();
}

void keyPressed() {
  if (key == 'a') {
    p[0].dy*=-1;
    p[0].reverse=true;
    p[0].a*=-1;
    if (p[0].vy<0) {
      p[0].vy=5.0;
    } else {
      p[0].vy=-5.0;
    }
  } else if (key == 'l') {
    p[1].reverse=true;
    p[1].dy*=-1;
    p[1].a*=-1;
    if (p[1].vy<0) {
      p[1].vy=5.0;
    } else {
      p[1].vy=-5.0;
    }
  }
}
