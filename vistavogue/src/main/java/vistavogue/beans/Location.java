package vistavogue.beans;

public class Location {
	private int id;
private String  name;
private String description;
private double latitude;
private double longitude;

public Location() {
	super();
}
public Location(String name, String description, double latitude, double longitude) {
	super();
	this.name = name;
	this.description = description;
	this.latitude = latitude;
	this.longitude = longitude;
}
public void setId(int id) {
	this.id=id;
}
public int getId() {
	return id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
public double getLatitude() {
	return latitude;
}
public void setLatitude(double latitude) {
	this.latitude = latitude;
}
public double getLongitude() {
	return longitude;
}
public void setLongitude(double longitude) {
	this.longitude = longitude;
}

}
