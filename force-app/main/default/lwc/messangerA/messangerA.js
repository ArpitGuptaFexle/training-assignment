import { LightningElement, wire } from 'lwc';
import { publish, subscribe, MessageContext } from 'lightning/messageService';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class MessangerA extends LightningElement {

    @wire(MessageContext)
    messageContext;
    
    subs =  null;
    aRecievedMessage = ' No message recieved yet';

    connectedCallback(){
        if(!this.subs){
            this.subs =subscribe(
                this.messageContext,
                MESSAGE_CHANNEL,
                (payload)=> this.handelmessageb(payload)
            );
        }
    }

    handelmessageb(payload){
        if(payload.messageb){
            this.aRecievedMessage = ' ' + payload.messageb;
        }
        
    }

    handelButtonClick() {
        const msgInput = this.template.querySelector('lightning-input').value;
        const payload = {message: msgInput};    
        publish(this.messageContext, MESSAGE_CHANNEL, payload);
        
    }

}