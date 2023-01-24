class Solution {
  int searchInsert(List<int> nums, int target) {
int temp=(nums.length/2).toInt(),index=-1;
print(temp);
if(nums[temp]<target){
for(int i=temp;i<nums.length;i++){
    if(nums[i]==target){
        index=i;
        break;
    }else if(nums[i]>target){
        index=i;
        break;
    }else{
        index=i+1;
    }
}
}else{
    for(int i=temp;i>=0;i--){
        if(nums[i]==target){
            index=i;
            break;
        }else if(nums[i]<target){
            index=i+1;
             break;
        }else{
            index=i;
        }
    }

}
return index;
  }
}
