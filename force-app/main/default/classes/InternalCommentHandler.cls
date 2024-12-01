public with sharing class InternalCommentHandler {

    public static void breakLongBody(List<Internal_Comment__c> comments) {
        Integer rl = (Integer)Row_Limit__mdt.getInstance('Internal_Comment_c').Limit__c;
        for (Internal_Comment__c ic : comments) {
            if(ic.Body__c == null)
                continue;
            List<String> rows = new List<String>();
            for (String row : ic.Body__c.split('\n')){
                while(row.length() > rl){
                    Integer lastSpace = indexOfLastSpace(row, rl);
                    rows.add(row.substring(0, lastSpace));//you didn't what to do in case of words longer than the row limit, so I don't addError
                    row = row.substring(lastSpace + 1);//you didn't what to do in case of rows ending with space (right after the limit), so I don't addError
                }
                rows.add(row);
            }
            ic.Body__c = String.join(rows, '\n');
        }
    }

    static Integer indexOfLastSpace(String row, Integer rl){
        for (Integer i = rl; i > 0; i--)
            if(row.substring(i, i + 1) == ' ')
                return i;
        return 0;
    }
}