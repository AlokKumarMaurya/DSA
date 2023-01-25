class Solution {
  List<int> plusOne(List<int> digits) {
String temp="";
String a="";
List test=[];
List<int> re=List<int>.empty(growable:true);
for(int i=0;i<digits.length;i++){
    temp=temp+digits[i].toString();
}
a=(BigInt.parse(temp)+BigInt.parse("1")).toString();
test=a.split("");
for(String ss in test){
    re.add(int.parse(ss));
}
return re;
  }
}
