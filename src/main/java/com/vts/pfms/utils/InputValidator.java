package com.vts.pfms.utils;

import java.util.regex.Pattern;

public class InputValidator {

	private static final Pattern withCaptialsAndNumeric = Pattern.compile("^[A-Z0-9]+$");
    private static final Pattern withCapitalsAndSmalls = Pattern.compile("^[A-Za-z]+$");
    private static final Pattern withCapitalsAndSmallsAndSpace = Pattern.compile("^[A-Za-z ]+$");
    private static final Pattern withCapitalsAndSmallsAndDotAndSpace = Pattern.compile("^[A-Za-z. ]+$");
    private static final Pattern withCapitalsAndSmallsAndNumeric = Pattern.compile("^[A-Za-z0-9]+$");
    private static final Pattern withCapitalsAndSmallsAndNumericAndSpace = Pattern.compile("^[A-Za-z0-9 ]+$");
    //it accepts special 3 charcaters those are -> '-', '/', '\'
    private static final Pattern withCapitalsAndSmallsAndNumericAndSymbolsAndSpace = Pattern.compile("^[A-Za-z0-9\\-/\\\\](?:[A-Za-z0-9 \\-/\\\\]*)?$"); 
    private static final Pattern withEmailPattern =Pattern.compile("^[A-Za-z0-9._-]+@[A-Za-z0-9._-]+\\.[A-Za-z]{2,}$");
    private static final Pattern withMobilePattern = Pattern.compile("^[6-9]\\d{9}$");
    private static final Pattern withPasswordPattern = Pattern.compile("^[6-9]\\d{9}$");
    private static final Pattern withHTMLTagPattern = Pattern.compile("<[a-zA-Z][^>]*>");
    private static final Pattern withNumericPattern = Pattern.compile("^[0-9]+$");
    private static final Pattern withDescriptionPattern = Pattern.compile("[a-zA-Z0-9@.,()\\-/& ]+");
    private static final Pattern withDecimalFormatPattern = Pattern.compile("^\\d+(\\.\\d{1,2})?$");


    private static boolean match(String input, Pattern pattern) {
        return input != null && pattern.matcher(input).matches();
    }
    
    public static boolean isValidCodeWithCapitalsAndNumeric(String input) {
        return match(input, withCaptialsAndNumeric);
    }

    public static boolean isValidNameWithCapitalsAndSmallLetters(String input) {
        return match(input, withCapitalsAndSmalls);
    }
    
    public static boolean isValidNameWithCapitalsAndSmallLettersAndSpace(String input) {
    	return match(input, withCapitalsAndSmallsAndSpace);
    }
    public static boolean isValidNameWithCapitalsAndSmallLettersAndDotAndSpace(String input) {
    	return match(input, withCapitalsAndSmallsAndDotAndSpace);
    }
    
    public static boolean isValidCapitalsAndSmallsAndNumeric(String input) {
    	return match(input, withCapitalsAndSmallsAndNumeric);
    }
    
    public static boolean isValidCapitalsAndSmallsAndNumericAndSpace(String input) {
    	return match(input, withCapitalsAndSmallsAndNumericAndSpace);
    }
    public static boolean isContainCapitalsSmallsNumericSymbolsSpace(String input) {
    	return match(input, withCapitalsAndSmallsAndNumericAndSymbolsAndSpace);
    }
    
    public static boolean isValidEmail(String input) {
    	return match(input, withEmailPattern);
    }
    
    public static boolean isValidMobileNo(String input) {
    	return match(input, withMobilePattern);
    }
    
    public static boolean isValidPassword(String input) {
    	return match(input, withPasswordPattern);
    }

    public static boolean isContainsHTMLTags(String input) {
        return withHTMLTagPattern.matcher(input).find();
    }
    public static boolean isContainsNumberOnly(String input) {
    	return match(input, withNumericPattern);
    }

    public static boolean isContainsDescriptionPattern(String input) {
        return  match(input, withDescriptionPattern);
    }
    
    public static boolean isDecimalFormat(String input) {
    	return match(input, withDecimalFormatPattern);

    }
}
