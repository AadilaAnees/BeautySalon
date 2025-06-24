package com.salonbooking.full.service;

import com.salonbooking.full.model.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public interface ServiceService {
    Service saveService(Service service) throws IOException;
    List<Service> getAllServices() throws IOException;
    Optional<Service> getServiceById(String id) throws IOException;
    List<Service> getServicesByCategory(String category) throws IOException;
    void deleteService(String id) throws IOException;
}
