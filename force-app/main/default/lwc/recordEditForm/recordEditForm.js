import { api, LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import  { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordEditForm extends LightningElement {
    @api recordId; 
    @api objectApiName = ACCOUNT_OBJECT.objectApiName; 

    handleSuccess(event) {
      
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Record updated successfully!',
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
    }

    handleError(event) {
        
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'Error occurred while updating record',
            variant: 'error'
        });
        this.dispatchEvent(toastEvent);
    }

    handleCancel() {
       
    }
}