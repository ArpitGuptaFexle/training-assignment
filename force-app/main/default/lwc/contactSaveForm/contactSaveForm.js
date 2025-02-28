import {LightningElement, track,api, wire } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';  
import ContactCreation from '@salesforce/apex/insertContact.ContactCreation';
import fetchData from '@salesforce/apex/searchController.fetchConData';
import {refreshApex} from '@salesforce/apex';

//search Contact
const Columns =[
    {label:'First Name',fieldName:'FirstName',type:'text'},
    {label:'Last Name',fieldName:'LastName',type:'text'},
    {label:'Email',fieldName:'Email',type:'email'},
    {label: 'Phone',fieldName:'Phone',type:'phone'}
]

export default class ContactSaveForm extends LightningElement {
    //search
    @track columns = Columns;
    @track data; 
    @track searchKey ='';
    @track error;
    noRecordsBool = false;
    handleOkay;
    @api noOfContact=0;
    

    @api accountId;
    isClicked = false;

    handelSearch(event){
        this.searchKey  = event.target.value;
    }

     //Searching Contact
    @wire(fetchData, {searchKey: '$searchKey', accountId: '$accountId'})
        wiredData(result) {
         this.wiredContactResult = result;
            //console.log('data', JSON.stringify(this.wiredContactResult));
             if (result.data) {
                 this.data = result.data;
                 this.error = undefined;
                 this.noRecordsBool = this.data.length === 0;
                 this.noOfContact= this.data.length;

                 const conValue =new CustomEvent('convalue',{
                    detail : this.noOfContact
                })
                this.dispatchEvent(conValue);
             
                console.log('@@@@@@@@@@@ wire'+ this.noOfContact);
             }
             else if (result.error) {
                 this.error = result.error;
                 this.data = undefined;
             }
        }
    
        refreshContactData() {
            refreshApex(this.wiredContactResult);
        }

    handleValidation(){
        let lNameCmp = this.template.querySelector(".lNameVal");
        let emailCmp = this.template.querySelector(".emailVal");

        if(!lNameCmp.value){
            lNameCmp.setCustomValidity("Last Name is required");
        }else{
            lNameCmp.setCustomValidity("");
        }
        lNameCmp.reportValidity();

        if(!emailCmp.value){
            emailCmp.setCustomValidity("Email is required");
        }else{
            emailCmp.setCustomValidity("");
        }
        emailCmp.reportValidity();
    }    
    //Creating a contact record using Imperative
    handleClick(){
        this.isClicked = !this.isClicked;
    }

    @track getContactRecord ={
        FirstName : '',
        LastName :'',
        Email : '' ,
        AccountId : '' 
    };
    
    fNameChange(event){
        this.getContactRecord.FirstName = event.target.value;
    }

    lNameChange(event){
        this.getContactRecord.LastName = event.target.value;
    }

    emailChange(event){
        this.getContactRecord.Email = event.target.value;
    }

    handelContactButton(){
        this.getContactRecord.AccountId = this.accountId;  
        //this.handleValidation(); 
        ContactCreation({conObj: this.getContactRecord})
            .then(result =>{
               
                this.getContactRecord ={};

                const toastEvent = new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact Created Sucessfull',
                    variant : 'success'
                });
                this.dispatchEvent(toastEvent);

                let conValue =new CustomEvent('convalue',{
                    detail : this.noOfContact
                })
                this.dispatchEvent(conValue);
                console.log('@@@@@@@@@  child' + conValue);
                
                this.refreshContactData();
            })
            .catch(error=>{
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: 'Contact Creation Failed',
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);

                
            })

    }

   
}