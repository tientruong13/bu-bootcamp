import java.util.*;

public class ContactManager {

    public static void main(String[] args) {

        HashMap<String, Contact> contacts = new HashMap<>();

        // Add five contacts
        contacts.put("Ada Lovelace",
                new Contact("Ada Lovelace", "+1 714 555 0101"));

        contacts.put("Grace Hopper",
                new Contact("Grace Hopper", "+1 714 555 0102"));

        contacts.put("Alan Turing",
                new Contact("Alan Turing", "+1 714 555 0103"));

        contacts.put("John Smith",
                new Contact("John Smith", "+1 714 555 0104"));

        contacts.put("Sarah Johnson",
                new Contact("Sarah Johnson", "+1 714 555 0105"));

        // Look up a known contact
        Contact found = contacts.get("Ada Lovelace");

        System.out.println("=== Contact Lookup ===");

        if (found != null) {
            System.out.println(found);
        } else {
            System.out.println("Contact not found.");
        }

        // Test an unknown contact
        Contact unknown = contacts.get("Michael Brown");

        if (unknown != null) {
            System.out.println(unknown);
        } else {
            System.out.println("Contact not found: Michael Brown");
        }

        // Create and sort the contact list
        ArrayList<Contact> sorted =
                new ArrayList<>(contacts.values());

        sorted.sort((a, b) ->
                a.getName().compareTo(b.getName()));

        System.out.println();
        System.out.println("=== All Contacts ===");

        for (Contact contact : sorted) {
            System.out.println(contact);
        }
    }
}