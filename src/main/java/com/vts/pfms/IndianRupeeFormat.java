package com.vts.pfms;

public class IndianRupeeFormat {

	public static String rupeeFormat(String value){
        value=value.replace(",","");
        char lastDigit=value.charAt(value.length()-1);
        String result = "";
        int len = value.length()-1;
        int nDigits = 0;

        for (int i = len - 1; i >= 0; i--)
        {
            result = value.charAt(i) + result;
            nDigits++;
            if (((nDigits % 2) == 0) && (i > 0))
            {
                result = "," + result;
            }
        }
        return (result+lastDigit);
    }
	
	public static String getRupeeFormat(Double amount)
	{
		String salary = String.format("%.2f", amount);
	    String[] split = salary.split("\\.");
	    salary = split[0];
        int len = salary.length()-1;
		
		char lastDigit = salary.charAt(len);
		String store="";
		String decimal=".00";
		int count=0;
		for(int i=len-1 ; i>=0 ; i--)
		{
			store = salary.charAt(i)+store;
			count++;
			if((count%2==0) && i>0)
			{
				store = ","+ store;
			}
		}
		return (store+lastDigit+decimal);
	}
}
