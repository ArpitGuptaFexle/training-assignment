import { LightningElement, track,wire } from 'lwc';
import getAccount from '@salesforce/apex/assignmentAccountController.getAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';

export default class AssasementAccountWizard extends LightningElement {

    columns = [
        {label: 'Id',fieldName:'Id'},
        {label: 'Name', fieldName:'Name'},
        {label: 'Website', fieldName: 'Website'},
        {label: 'Phone', fieldName: 'Phone'},

    ];
    @track accounts;
    @track error;
    @track accountId;

    @track isClicked = false;
    @track isClickedContact = false;
    @track isShowModal =false;
    @wire (getAccount)
        wiredData({error, data}){
            if(data){
                this.wiredAccountResult = data;
                this.accounts = data;
            }
            else if(error){
                this.error = error;
            }
        }

        wiredAccountResult
        handleRefreshAccount(event){
            wiredAccountResult = event.detail;
            refreshApex(this.wiredAccountResult);
        }

        handelAccount(){
            this.isClicked =!this.isClicked;
        }

        handleclose(){
            this.isClicked = false;
        }

        handleAccountSuccess(event){
            const toastEvent =new ShowToastEvent({
                title   : 'Success',
                message : 'Account Created',
                variant : 'success'
            });
            this.dispatchEvent(toastEvent);
            this.accountId = event.detail.id;
        }
        handleAccountError(event){
            const toastEvent =new ShowToastEvent({
                title   :   'Error',
                message : 'Account Creation Failed',
                variant : 'error'
            });
            this.dispatchEvent(toastEvent);
        }

        handleContactSuccess(event){
            const toastEvent =new ShowToastEvent({
                title   : 'success',
                message : 'Contact Created',
                variant : 'success'
            });
            this.dispatchEvent(toastEvent);
        }

        handleContactError(event){
            const toastEvent =new ShowToastEvent({
                title   :   'Error',
                message : 'Contact Creation Failed',
                variant : 'error'
            });
            this.dispatchEvent(toastEvent);
        }

        handleContact(event){
            this.isClickedContact = !this.isClickedContact;
        }

}