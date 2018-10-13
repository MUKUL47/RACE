boolean gameStarted=false;
String Text="Score : ";
/*____________*/
float carX=250, carY=500,speed=1;
/*________________*/
float roadX=0, roadY=0, road1X=2.1, road1Y=-1000,roadSpeed=10;
/*________________*/
PImage Road,Road1,Car;
/*________________*/
int noOfEnemies;
ArrayList<Integer> enemyX = new ArrayList<Integer>();
ArrayList<Integer> enemyY = new ArrayList<Integer>();
boolean enemyPassed=true;
String carNames[]={"car1","car2","car3"};
PImage car1,car2,car3;
/*________________*/
void setup(){
size(500,1000);
loadImages();
}

void loadImages(){
 
/*___________________*/
Road=loadImage("Road.jpg");
Road1=Road;
Car=loadImage("Car.png");
textSize(20);
}

void draw(){
background(0);frameRate(60);
Road();Car();spawnEnemies();checkGameOver();
text("SCORE : "+(roadSpeed*speed), 360, 50);
text("CONTROLS : ", 10, 100);
text("ARROW KEYS", 15, 150);
}

void Road(){
//2 same road pictures for continues loop
image(Road,roadX,roadY,500,1000);
image(Road1,road1X,road1Y,512.2,1000);
roadY+=roadSpeed*speed;
if(roadY>=0){road1Y+=roadSpeed*speed;;}
if(road1Y>0){roadY=0;road1Y=-1000;}
}

void Car(){
image(Car,carX,carY,40,75);
//CONTROLS
if(keyPressed && keyCode==UP){if(carY>=64) carY-=8; else carY=64;}
if(keyPressed && keyCode==DOWN ){if(carY<=920) carY+=4; else carY=920;}
if(keyPressed && keyCode==LEFT){if(carX>=154) carX-=8; else carX=154; }
if(keyPressed && keyCode==RIGHT){if(carX<=284) carX+=8; else carX=284;}

}
void spawnEnemies(){
if(enemyPassed){
 
noOfEnemies=round(random(0.4,3));
//Assign position to them by storing them in arrayList
for(int i=0;i<noOfEnemies;i++){
enemyX.add((int)random(154,284));
//The Y coordinate b/w 2/3 enemy car should be > Length of player car
if(i>=1){keepDistance(i);}
if(i==0){enemyY.add((int)random(-500,0));}
}
loadEnemyCars(); 
enemyPassed=false;
}
else{
//If enemies already exist[s] increment the Y coordinate  
for(int i=0;i<noOfEnemies;i++){
enemyY.set(i,enemyY.get(i)+(int)random(15+speed,25+speed));
}

updateCarPosition();
if(checkIfAllPassed()){enemyPassed=true;}
}

}

void loadEnemyCars(){
//Load enemies car
if(noOfEnemies==1){car1=loadImage(carNames[0]+".png");}

else if(noOfEnemies==2){car1=loadImage(carNames[0]+".png");car2=loadImage(carNames[1]+".png");}

else{car1=loadImage(carNames[0]+".png");car2=loadImage(carNames[1]+".png");car3=loadImage(carNames[2]+".png");}
}

boolean checkIfAllPassed(){
//Check if all car enemies passed the Y coordinate(1000)
int c=0; 
for(int i=0;i<noOfEnemies;i++){
if(enemyY.get(i)>1100){
c++;
}
}
if(c==noOfEnemies){enemyX.clear(); enemyY.clear(); speed+=.25; return true;}
return false;
}

void updateCarPosition(){//Of the car
if(enemyX.size()==1){image(car1,enemyX.get(0),enemyY.get(0),40,75);}

if(enemyX.size()==2){ image(car1,enemyX.get(0),enemyY.get(0),40,75);image(car2,enemyX.get(1),enemyY.get(1),40,75); }

if(enemyX.size()==3){image(car1,enemyX.get(0),enemyY.get(0),40,75);image(car2,enemyX.get(1),enemyY.get(1),40,75);image(car3,enemyX.get(2),enemyY.get(2),40,75);

}}

void keepDistance(int i){
//The Y coordinate b/w 2/3 enemy car should be > Length of player car
int y=(int)random(-500,0);
while(abs(enemyY.get(i-1)-y)<77){
   y=(int)random(-500,0);
}
enemyY.add(y);
}

boolean checkGameOver(){//If they collide
if(!enemyX.isEmpty()){
for(int i=0;i<noOfEnemies;i++){
if(abs(enemyY.get(i)-carY)<77 && abs(enemyX.get(i)-carX)<33){
  noLoop();text("GAMEOVER", 200, 50);
}}}
return false;
}
