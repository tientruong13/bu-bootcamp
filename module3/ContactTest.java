import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotSame;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ContactTest {

    private Contact contact;

    @BeforeEach
    public void setUp() {
        contact = new Contact("John Smith", "123-456-7890");
    }

    @Test
    public void testGetName() {
        assertEquals("John Smith", contact.getName());
    }

    @Test
    public void testGetPhone() {
        assertEquals("123-456-7890", contact.getPhone());
    }

    @Test
    public void testToString() {
        assertEquals("John Smith | 123-456-7890", contact.toString());
    }

    @Test
    public void testDifferentContact() {
        Contact secondContact = new Contact("Jane Doe", "987-654-3210");

        assertEquals("Jane Doe", secondContact.getName());
        assertEquals("987-654-3210", secondContact.getPhone());
    }

    @Test
    public void testContactsWithSameNameAreIndependent() {
        Contact firstContact = new Contact("Alex", "111-111-1111");
        Contact secondContact = new Contact("Alex", "222-222-2222");

        assertNotSame(firstContact, secondContact);
        assertEquals("111-111-1111", firstContact.getPhone());
        assertEquals("222-222-2222", secondContact.getPhone());
    }
}