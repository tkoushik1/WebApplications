package action;


public class Category {
    
    private String catcode, catname;

    public Category() {
    }

    public Category(String catcode, String catname) {
        this.catcode = catcode;
        this.catname = catname;
    }

    public String getCatcode() {
        return catcode;
    }

    public void setCatcode(String catcode) {
        this.catcode = catcode;
    }

    public String getCatname() {
        return catname;
    }

    public void setCatname(String catname) {
        this.catname = catname;
    }
    
}
