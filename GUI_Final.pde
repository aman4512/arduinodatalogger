import processing.serial.*;
import controlP5.*;
import java.util.*;
import java.io.BufferedWriter;
import java.io.FileWriter;

ControlP5 cp5;
Serial myPort;

PrintWriter output; 
float lightave=0, tempave=0, tempc=0;
String so,val;
int lightsum=0, tempsum=0, b=0, lf=10, lightint=0, prevLightint;

IntList datal;
FloatList datat;

int[] lightarr = {0};
float[] temparr = {0};

int s;  // Values from 0 - 59
int m;  // Values from 0 - 59
int h;    // Values from 0 - 23
float prevTempc=tempc;

List l = Arrays.asList("00-1", "1-2", "2-3", "3-4", "4-5", "5-6", "6-7", "7-8", "8-9", "9-10", "10-11", "11-12", "12-13", "13-14", "14-15", "15-16", "16-17", "17-18", "18-19", "19-20", "20-21", "21-22", "22-23", "23-00");

int mil1, mil2;

Table table;

public class data
{
    IntList hr;
    IntList datalight;
    FloatList datatemp;
}

data sept11 = new data();

void setup()
{
    size(500, 500);
    
    //parseFile();
    
    table = loadTable("data.csv", "header");
    for (TableRow row : table.rows()) 
    {
        int hour = row.getInt("hours");
        float temperature  = row.getFloat("temperature");
        int light = row.getInt("light");
        
        println(hour + " " + temperature + " " + light);
    }
    
    sept11.hr = new IntList();
    sept11.datalight = new IntList();
    sept11.datatemp = new FloatList();
    
    for (TableRow row : table.rows())
    {
        sept11.hr.append(row.getInt("hours"));
        sept11.datatemp.append(row.getInt("temperature"));
        sept11.datalight.append(row.getInt("light"));
    }
    
    cp5 = new ControlP5(this);
    
    CallbackListener toFront = new CallbackListener() 
    {
        public void controlEvent(CallbackEvent theEvent) 
        {
            theEvent.getController().bringToFront();
            ((ScrollableList)theEvent.getController()).open();
        }
    };

    CallbackListener close = new CallbackListener() 
    {
        public void controlEvent(CallbackEvent theEvent) 
        {
            ((ScrollableList)theEvent.getController()).close();
        }
    };

    cp5.addScrollableList("TIMESLOT")
        .setPosition(75, 240)
        .setSize(75, 100)
        .setBarHeight(20)
        .onEnter(toFront)
        .onLeave(close)
        .setItemHeight(20)
        .addItems(l)
        .setOpen(false)
        ;
        
    println((Object[])Serial.list());
    String portName = Serial.list()[2];
    myPort = new Serial(this, portName, 9600);
    myPort.bufferUntil(lf);
    
    //output = createWriter("data.csv"); 
        
    delay(1000);
}

void controlEvent(ControlEvent theEvent)
{
    so = cp5.getController("TIMESLOT").getLabel(); 
    
    b = sept11.datalight.size();
    switch(so)
    {
        case("00-1"):
        {
            average(0);
            break;
        }
        
        case("1-2"):
        {
            average(1);
            break;
        }
    
        case("2-3"):
        {
            average(2);
            break;
        }
       
        case("3-4"):
        {
            average(3);
            break;
        }
    
        case("4-5"):
        {
            average(4);
            break;
        }
        
        case("5-6"):
        {
            average(5);
            break;
        }
        
        case("6-7"):
        {
            average(6);
            break;
        }
        
        case("7-8"):
        {
            average(7);
            break;
        }
        
        case("8-9"):
        {
            average(8);
            break;
        }
        
        case("9-10"):
        {
            average(9);
            break;
        }
        
        case("10-11"):
        {
            average(10);
            break;
        }
        
        case("11-12"):
        {
            average(11);
            break;
        }
        
        case("12-13"):
        {
            average(12);
            break;
        }
        
        case("13-14"):
        {
            average(13);
            break;
        }
    
        case("14-15"):
        {
            average(14);
            break;
        }
       
        case("15-16"):
        {
            average(15);
            break;
        }
    
        case("16-17"):
        {
            average(16);
            break;
        }
        
        case("17-18"):
        {
            average(17);
            break;
        }
        
        case("18-19"):
        {
            average(18);
            break;
        }
        
        case("19-20"):
        {
            average(19);
            break;
        }
        
        case("20-21"):
        {
            average(20);
            break;
        }
        
        case("21-22"):
        {
            average(21);
            break;
        }
        
        case("22-23"):
        {
            average(22);
            break;
        }
        
        case("23-00"):
        {
            average(23);
            break;
        }                       
    }    
}

void draw()
{                 
    background(255);
    mil1 = millis();
   
    //current time
    h=hour();
    m=minute();
    s=second();
    text(h, 400, 15);
    text(":", 410, 15);
    text(m, 430, 15);
    text(":", 440, 15);
    text(s, 460, 15);
    
    //title
    fill(0);
    textAlign(CENTER, TOP);
    textSize(25);
    text("ESD PROJECT 1", width/2, 30);
    
    //Real Time Data
    textAlign(LEFT, TOP);
    textSize(20);
    text("Real time data", 50, 80);
    textSize(16);
    text("Temperature:", 75, 120);
    text("Light:", 75, 140);
    text(tempc, 300, 120);
    text(lightint, 300, 140);
 
    //Averaged data
    textSize(20);
    text("Averaged data", 50, 180);
    textSize(16);
    text("Choose timeslot", 75, 210);
    text(lightave, 75, 300);
    text(tempave, 75, 350);
    
//    if (mil1 - mil2 >= 2000)
//    {
//        mil2 = mil1;
//        output.println(h + "," + m + "," + s + "," + tempc + "," + lightint);
//        println("y");
//    }

    //output.println(h + "," + m + "," + s + "," + tempc + "," + lightint); //<>//
}

void serialEvent(Serial myPort)
{   
    try
    {
        val = myPort.readStringUntil(lf);
        if (val != null) 
        {
            val = trim(val);
            
            String sensorData[] = split(val,',');
            h=hour();
            m=minute();
            s=second();
            prevLightint = lightint;
            lightint = int(sensorData[0]);
            sept11.hr.append(h);
            sept11.datalight.append(lightint);           
            //println(sept11.datalight);
            prevTempc=tempc;
            tempc = float(sensorData[1]);
            sept11.datatemp.append(tempc);
            
            maketable();
            //println(datat);
        }
    }
    
    catch (Exception e)
    {
        println("Error");
        e.printStackTrace();
    }
}

void keyPressed() 
{
    //output.flush();
    //output.close();
    
    exit();
}

void average(int time)
{
    float count=0;
    float lightaverage=0,tempaverage=0;
    for (int a=1; a<b; a++)
    {        
        if(sept11.hr.get(a) == time)      
        {   
            lightsum+=sept11.datalight.get(a);
            tempsum+=sept11.datatemp.get(a);        
        }
        count=(float) a;                  
    }
    lightaverage = lightsum/count;
    tempaverage = tempsum/count;
    so = "";
    lightsum=0;
    tempsum=0;
    lightave = lightaverage;
    tempave = tempaverage;
}

//void parseFile() 
//{
//  // Open the file from the createWriter() example
//  BufferedReader reader = createReader("data.csv");
//  String line = null;
//  try {
//    while ((line = reader.readLine()) != null) {
//      String[] pieces = split(line, '\t');
//      hr1 = int(pieces[0]);
//      int temp1 = int(pieces[3]);
//      int temp2 = int(pieces[4]);
//      println(hr1, temp1, temp2);
//    }
//    reader.close();
//  } catch (IOException e) {
//    e.printStackTrace();
//  }
//} 

void maketable()
{
    TableRow newRow = table.addRow();
    newRow.setInt("hours", hour());
    newRow.setFloat("temperature", tempc);
    newRow.setInt("light", lightint);
    saveTable(table, "data.csv");
    println("working");
  
}
