public with sharing class InternalCommentHandler {

    public static void forbidLongBody(List<Internal_Comment__c> comments) {
        for (Internal_Comment__c ic : comments) {
            if(ic.Body__c == null)
                continue;
            for (String row : ic.Body__c.split('\n'))
                if(row.length() > 40){
                    ic.addError('Row out of boundary of 40 characters');
                    break;
                }
        }
    }
}