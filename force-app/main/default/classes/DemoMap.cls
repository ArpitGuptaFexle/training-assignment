/**
 *   Description       :This class is used to demonstrate the use of Map and its operations
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11//2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass1
 * 
**/
public class DemoMap {

    public static void valueInMap(){
    
        Map<string, List<string>> mp =new Map<string,List<string>>();

        mp.put('IT Department' ,new List<string>{'Arpit','Suresh','Ramesh'});
        mp.put('HR Department' ,new List<string>{'Charlie','Keshav','Samay'});
        mp.put('Sales Department' ,new List<string>{'Abhishek','Puneet','Deepak'});
        
        System.debug('Map is: '+ mp);
    }
}
//xcx