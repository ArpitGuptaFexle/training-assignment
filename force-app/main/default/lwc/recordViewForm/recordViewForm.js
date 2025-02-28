import { api, LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';



export default class RecordViewForm extends LightningElement {

    @api recordId;
    @api objectApiName = ACCOUNT_OBJECT;
}