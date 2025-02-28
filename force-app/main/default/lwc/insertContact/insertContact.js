import { api, LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class InsertContact extends LightningElement {
    @api accountId; 

    
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Contact created successfully!',
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
        //this.dispatchEvent(new CustomEvent('closemodal')); 
    }

    handleError(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'Error occurred while inserting record',
            variant: 'error'
        });
        this.dispatchEvent(toastEvent);
    }

    //handleClose() {
       // this.dispatchEvent(new CustomEvent('closemodal')); 
    //}
}