import { LightningElement, track , wire} from 'lwc';
import getAccount from '@salesforce/apex/AccountManagerController.getAccount';

export default class AccountManagerFetch extends LightningElement {

    columns = [
        { label: 'Id', fieldName: 'Id' ,editable: true},
        { label: 'Name', fieldName: 'Name', type: 'text' ,editable: true},
        { label: 'Website', fieldName: 'Website', type: 'url' ,editable: true},
        { label: 'Industry', fieldName: 'Industry', type: 'text' ,editable: true},
        { label: 'Phone', fieldName: 'Phone', type: 'Phone' ,editable: true},
    ];

    @track accounts;
    @track errors;

    @wire (getAccount)
     wireData({error,data}){
        if(data){
            this.accounts = data;
            
        } else{
            this.errors = error;
        }
     }
     
 
}
