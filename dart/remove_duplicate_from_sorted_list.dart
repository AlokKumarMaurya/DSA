class Solution {
  int removeElement(List<int> nums, int val) {
for(int i=0;i<nums.length;i++){
    if(nums[i]==val){
        nums.removeAt(i);
        i--;
    }
}
return nums.length;
  }
}
