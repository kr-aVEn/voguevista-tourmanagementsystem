package vistavogue;

import java.util.List;

import vistavogue.beans.Location;
public class DistanceUtil {
	
	    
	 
	    public static double calculateTotalDistance(List<Location> locations) {
	        double totalDistance = 0.0;
	        for (int i = 0; i < locations.size() - 1; i++) {
	            totalDistance += calculateDistance(locations.get(i), locations.get(i + 1));
	        }
	        return totalDistance;
	    }

	 
	    public static double calculateDistance(Location loc1, Location loc2) {
	        final int R = 6371; // Radius of the earth in km

	        double latDistance = Math.toRadians(loc2.getLatitude() - loc1.getLatitude());
	        double lonDistance = Math.toRadians(loc2.getLongitude() - loc1.getLongitude());
	        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
	                + Math.cos(Math.toRadians(loc1.getLatitude())) * Math.cos(Math.toRadians(loc2.getLatitude()))
	                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
	        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	        double distance = R * c; // convert to kilometers

	        return distance;
	    }

	   
	    public static double calculateDistanceFromStart(Location location, Location startLocation) {
	        return calculateDistance(startLocation, location);
	    }
	}
