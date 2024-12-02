/**
 *   Description       : This class is used to demonstrate the use of List and Sorting in it
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/27/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass1
 * 
**/
public class DemoList {
   
    public static void sortInList(){

     	List<Integer> demoL = new List<Integer>();

        demoL.add(100);
        demoL.add(2);
        demoL.add(24);
        demoL.add(34);
        demoL.add(90);
        demoL.add(45);
        demoL.add(30);

        System.debug(demoL);
        //DemoL.sort();

        for(Integer i=0;i<demoL.Size();i++){

            for(Integer j=i+1;j<7;j++){

            	if(demoL[i]>demoL[j]){

                	Integer temp=demoL[i];
                	demoL[i]=demoL[i+1];
                	demoL[i+1]=temp;
            	 }
            }
        }
        
        System.debug(demoL);
    }
}