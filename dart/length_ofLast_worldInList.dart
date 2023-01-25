class Solution {
  int lengthOfLastWord(String s) {
List temp=s.split(" ");
String a=temp[temp.length-1];
int count=temp.length-1;
while(a==""){
    count--;
    a=temp[count];
}
return a.length;
  }
}
