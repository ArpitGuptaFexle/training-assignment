import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {

     greeting='';

    handelGreetingChange(event){

        this.greeting = event.target.value;
    }

}