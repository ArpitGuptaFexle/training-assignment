import { api, LightningElement } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import WEBSITE_NAME from '@salesforce/schema/Account.Website';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class AccountDisplay extends LightningElement {
    nameField = ACCOUNT_NAME;
    websiteField = WEBSITE_NAME;
    phoneField = PHONE_FIELD;

    isClicked = false;

    @api recordId; 
    @api objectApiName; 

    handleClick() {
        this.isClicked = !this.isClicked; 
    }
}