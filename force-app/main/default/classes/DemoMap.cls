public class DemoMap {
    public static void DM(){
        Map<string, List<string>> mp =new Map<string,List<string>>();
        mp.put('IT Department' ,new List<string>{'Arpit','Suresh','Ramesh'});
        mp.put('HR Department' ,new List<string>{'Charlie','Keshav','Samay'});
        mp.put('Sales Department' ,new List<string>{'Abhishek','Puneet','Deepak'});
        
        System.debug('Map is: '+ mp);
    }
}
//xcx