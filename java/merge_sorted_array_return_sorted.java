class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        List temp=new ArrayList();


        if(m>=n){
             for(int i=0;i<m;i++){
            temp.add(nums1[i]);
            if(i<n){
                temp.add(nums2[i]);
            }
        }
        }else if(m<n){
            for(int i=0;i<n;i++){
                temp.add(nums2[i]);
                if(i<m){
                    temp.add(nums1[i]);
                }
            }
        }
var test=temp.toArray();
// System.out.println(((Integer)test[0]).getClass());
 for(int i=0;i<test.length;i++){
            for(int j=i+1;j<test.length;j++){
                if((Integer)test[i] > (Integer)test[j]){
                    var te=test[i];
                    test[i]=test[j];
                    test[j]=te;
                    i=0;j=0;
                }
            }
        }



     for(int i=0;i<test.length;i++){
         nums1[i]=(Integer)test[i];
     }
       
    }
}
