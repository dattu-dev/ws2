package model;

import java.sql.Date;

public class Account {
    private String account;
    private String pass;
    private String lastName;
    private String firstName;
    private Date birthday;
    private boolean gender; // true = male, false = female
    private String phone;
    private boolean isUse; // true = active, false = banned
    private int roleInSystem; // 1 = Admin, 2 = Manager, 0 = Member
    
    // Constructors
    public Account() {
    }
    
    public Account(String account, String pass, String lastName, String firstName, 
                   Date birthday, boolean gender, String phone, boolean isUse, int roleInSystem) {
        this.account = account;
        this.pass = pass;
        this.lastName = lastName;
        this.firstName = firstName;
        this.birthday = birthday;
        this.gender = gender;
        this.phone = phone;
        this.isUse = isUse;
        this.roleInSystem = roleInSystem;
    }
    
    // Getters and Setters
    public String getAccount() {
        return account;
    }
    
    public void setAccount(String account) {
        this.account = account;
    }
    
    public String getPass() {
        return pass;
    }
    
    public void setPass(String pass) {
        this.pass = pass;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public Date getBirthday() {
        return birthday;
    }
    
    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
    
    public boolean isGender() {
        return gender;
    }
    
    public void setGender(boolean gender) {
        this.gender = gender;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public boolean isUse() {
        return isUse;
    }
    
    public void setUse(boolean isUse) {
        this.isUse = isUse;
    }
    
    public int getRoleInSystem() {
        return roleInSystem;
    }
    
    public void setRoleInSystem(int roleInSystem) {
        this.roleInSystem = roleInSystem;
    }
    
    public String getFullName() {
        return lastName + " " + firstName;
    }
    
    public String getRoleName() {
        switch(roleInSystem) {
            case 1: return "Admin";
            case 2: return "Manager";
            default: return "Member";
        }
    }
}