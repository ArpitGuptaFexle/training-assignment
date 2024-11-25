public class DemoList {
   
    public static void L1(){
     	List<Integer> DemoL = new List<Integer>();
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