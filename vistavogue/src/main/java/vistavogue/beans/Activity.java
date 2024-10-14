package vistavogue.beans;

public class Activity {
private int id;
private int locationid;
private String activityname;
private String description;
public Activity() {
	super();
}
public Activity(int id, int locationid, String activityname, String description) {
	super();
	this.id = id;
	this.locationid = locationid;
	this.activityname = activityname;
	this.description = description;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getLocationid() {
	return locationid;
}
public void setLocationid(int locationid) {
	this.locationid = locationid;
}
public String getActivityname() {
	return activityname;
}
public void setActivityname(String activityname) {
	this.activityname = activityname;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}


}
