package vistavogue.beans;

public class User {
	
	private String Username;
	private String password;
	private String email;
	private String place;
	private String role;
	public User() {
	
		super();
		this.role="user";
	}
	public User(String username, String password, String email, String place, String role) {
		super();
		Username = username;
		this.password = password;
		this.email = email;
		this.place = place;
		this.role = role;
	}
	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
}
