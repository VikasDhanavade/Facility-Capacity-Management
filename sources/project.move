 module MyModule::FacilityCapacityManagement {

    use aptos_framework::signer;

    /// Struct representing a facility with limited capacity.
    struct Facility has store, key {
        current: u64,   // Current number of users booked
        capacity: u64,  // Maximum allowed capacity
    }

    /// Function to create a new facility with a given capacity.
    public fun create_facility(owner: &signer, capacity: u64) {
        let facility = Facility {
            current: 0,
            capacity,
        };
        move_to(owner, facility);
    }

    /// Function for a user to book a spot in the facility.
    public fun book_spot(user: &signer, facility_owner: address) acquires Facility {
        let facility = borrow_global_mut<Facility>(facility_owner);
        assert!(facility.current < facility.capacity, 1); // Ensure not full
        facility.current = facility.current + 1;
    }
}
