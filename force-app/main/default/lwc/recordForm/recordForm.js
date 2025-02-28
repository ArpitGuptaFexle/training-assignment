import { LightningElement ,api } from 'lwc';
import ACCOUNT_FIELD from '@salesforce/schema/Account';

export default class RecordForm extends LightningElement {

    fields = [ACCOUNT_FIELD];

    @api recordId;
    @api objectApiName;
}