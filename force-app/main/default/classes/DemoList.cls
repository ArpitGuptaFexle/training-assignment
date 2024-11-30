/**
 *   Description       : This class is used to demonstrate the use of List and Sorting in it
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/27/2024
 *
 *   Revision Logs     : V_1.0 - Created - <Ticket no>
 * 
**/
public class DemoList {
   
    public static void sortInList(){

     	List<Integer> demoL = new List<Integer>();

        DemoL.add(100);
        DemoL.add(2);
        DemoL.add(24);
        DemoL.add(34);
        DemoL.add(90);
        DemoL.add(45);
        DemoL.add(30);

        System.debug(DemoL);
        //DemoL.sort();

        for(Integer i=0;i<DemoL.Size();i++){

            for(Integer j=i+1;j<7;j++){

            	if(DemoL[i]>DemoL[j]){

                	Integer temp=DemoL[i];
                	DemoL[i]=DemoL[i+1];
                	DemoL[i+1]=temp;
            	 }
            }
        }
        
        System.debug(DemoL);
    }
}