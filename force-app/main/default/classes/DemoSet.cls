public class DemoSet {
    public static void Seet(){
        set<String> S1 =new set<String>();
        set<String> S2 =new set<String>();
        S1.add('Arpit');
        S1.add('Suresh');
        S1.add('Ramesh');
        S2.add('Arpit');
        S2.add('Kailash');
        S2.add('Deep');
        System.debug('S1 is: '+S1);
        System.debug('S2 is: '+S2);

        set<string> Union = new set<string>(S1);
        Union.addAll(S2);
        System.debug('Union of S1 and S2 :' + Union);
        
        set<string> Intersection = new set<string>(S1);
        Intersection.retainAll(S2);
        System.debug('Intersection of S1 and S2: '+ Intersection);

        set<string> Diffrence = new set<string>(S2);
        Diffrence.removeAll(S1);
        System.debug('Diffrence of S2 - S1 is :' + Diffrence);

    }
}