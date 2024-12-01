import { LightningElement, api, wire } from 'lwc';
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import userId from '@salesforce/user/Id';
import accountName from "@salesforce/schema/Account.Name";
import userName from "@salesforce/schema/User.Name";

export default class CreateInternalComment extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: [accountName] })
    account;
    @wire(getRecord, { recordId: userId, fields: [userName] })
    user;
    get headerCss() {
        return getFieldValue(this.account.data, accountName) == getFieldValue(this.user.data, userName) ? 'green' : '';
    }
    comment;
    get disableSave() {
        return !this.comment;
    }

    cancel() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    handleCommentChange(e) {
        this.comment = e.detail.value;
    }
    save() {
        this.template.querySelector('lightning-record-edit-form').submit({ Account__c: this.recordId, Body__c: this.comment });
    }
    handleSuccess() {
        this.cancel();
        this.dispatchEvent(new ShowToastEvent({ title: "Success", message: "Thank you for your comment", variant: "success" }));
    }
}