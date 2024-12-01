trigger InternalCommentTrigger on Internal_Comment__c (before insert, before update) {
    InternalCommentHandler.breakLongBody(Trigger.new);
}