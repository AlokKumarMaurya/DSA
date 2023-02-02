class Solution {
    public boolean isPalindrome(String s) {
        String temp="",old="";
        boolean testCase=true;


 for(int i=0;i<s.length();i++){
            int a=s.charAt(i);
            if((a>64 && a<91) ||(a>96 && a<123) || (a>47 && a<58)){
                            //System.out.println(s.charAt(i));
            old=old+String.valueOf(s.charAt(i)).toLowerCase();
            }

        }


        for(int i=s.length()-1;i>0;i--){
            int a=s.charAt(i);
            if((a>64 && a<91) ||(a>96 && a<123) || (a>47 && a<58)){
                            //System.out.println(s.charAt(i));
            temp=temp+String.valueOf(s.charAt(i)).toLowerCase();
            }

        }
        for(int i=0;i<temp.length();i++){
            if(old.charAt(i) != temp.charAt(i))
            {
                testCase=false;
                break;
            }else{
                testCase=true;
            }
        }
        System.out.println("value of te temp variable"+temp);
         System.out.println("value of te old variable"+old);
        return testCase;
    }
}
