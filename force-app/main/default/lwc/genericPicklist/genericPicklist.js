import { LightningElement, api, track, wire } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class genericPicklist extends LightningElement {
    
    @api objectApiName;
    @api fieldApiName;
    @track options;
    @track value;
    recordTypeId;
    fieldLabel;


    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    objectInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;

            // Retrieving the picklist field label to Show on UI
            if (data.fields && data.fields[this.fieldApiName]) {
                this.fieldLabel = data.fields[this.fieldApiName].label;
            }

        } else if (error) {
            console.error('Error fetching object info:', error);
        }
    }


    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: '$getFieldApi' })
    picklistValues({ error, data }) {
        if (data) {
            this.options = data.values.map(picklistValue => ({
                label: picklistValue.label,
                value: picklistValue.value
            }));
        } else if (error) {
            console.error('Error fetching picklist values: ', error);
        }
    }

    handleChange(event) {
        this.value = event.detail.value;
        const picklistChangeEvent = new CustomEvent('picklistchange', {
            detail: {
                value: this.value
            }
        });
        this.dispatchEvent(picklistChangeEvent);
    }

    get getFieldApi() {
        return this.objectApiName && this.fieldApiName ? `${this.objectApiName}.${this.fieldApiName}` : null;
    }
}