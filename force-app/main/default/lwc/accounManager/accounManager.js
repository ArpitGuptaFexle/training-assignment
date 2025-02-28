import { LightningElement, track } from 'lwc';
import getAccount from '@salesforce/apex/AccountManagerController.getAccount';

export default class BasicDatatable extends LightningElement {

    @track accounts;
    @track error;

    columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Website', fieldName: 'Website', type: 'url' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'Phone' },
    ];
    
    connectedCallback() {
        //console.log('@@@ccb start');
        this.fetchAccount();
        //console.log('@@@ccb end');
    }
    fetchAccount() {
       // console.log('@@@fetchAccount start');
        getAccount()
            .then(result => {
                this.accounts = result;
                this.error = undefined;
                console.log('@@@result',this.accounts);

            })
            .catch(error =>{
                this.error = error.body.message;
                this.accounts = undefined;
                console.log('@@@error',this.error);
            });
       // console.log('@@@fetchAccount end');
    }
}