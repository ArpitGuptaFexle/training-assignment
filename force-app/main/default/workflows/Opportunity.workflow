<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval_Submitted</fullName>
        <description>Approval Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Discount_Request_Responses/Discount_Approval_Process</template>
    </alerts>
    <alerts>
        <fullName>Discount_Rejected</fullName>
        <description>Discount Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Discount_Request_Responses/Discount_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Discount_Approved</fullName>
        <field>Discount_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Discount Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
