import { api, LightningElement, track, wire } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import NO_OF_CONTACTS from '@salesforce/schema/Account.Contact__c';
import ACCOUNT_OWNER from '@salesforce/schema/Account.OwnerId';
import DECRIPTION_FIELD from '@salesforce/schema/Account.Description';
import {refreshApex} from '@salesforce/apex';
import {getRecordNotifyChange} from 'lightning/uiRecordApi';
import checkAccount from '@salesforce/apex/accountController.checkAccount';
import {getRecord} from 'lightning/uiRecordApi';

export default class AccountManagerWizard extends LightningElement {
    
    nameField = ACCOUNT_NAME;
    noOfContactField = NO_OF_CONTACTS;
    accountOwnerField = ACCOUNT_OWNER;
    descriptionField = DECRIPTION_FIELD;

    @api recordId;
    @api objectApiName; 
    @track conValue;

    handleContactCreated(event){
        this.conValue = event.detail;
        console.log('@@@@@@@@@@@'+ '  ' + this.conValue);
    }
    

    //Number_Of_Contacts__c
    
    /*
    nameField;
    noOfContactField;
    accountOwnerField;
    descriptionField;

 

    @track wiredAccountResult;

    @wire(checkAccount,{recordId:'$recordId'})
        wiredAccount(result){
            this.wiredAccountResult = result;
            if(result.data){
                this.nameField = result.data.Name;
                this.noOfContactField = result.data.Count_Number__c;
                this.accountOwnerField = result.data.Owner.Name;
                this.descriptionField = result.data.Description;
                this.error = undefined;
                //console.log('@@@@@@@@@@'+this.noOfContactField);
            }
            else if(result.error){
                this.error = result.error;
                this.nameField = undefined;
                this.noOfContactField = undefined;
                this.accountOwnerField = undefined;
                this.descriptionField = undefined;
            }   
        }    
    
    handleContactCreated(event){
        const accountId = event.detail.accountId;
        getRecordNotifyChange([{recordId: accountId}]);

        setTimeout(()=>{
            refreshApex(this.wiredAccountResult);
        },300);
         
    }    */

}