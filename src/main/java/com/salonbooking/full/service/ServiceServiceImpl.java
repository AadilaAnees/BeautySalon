package com.salonbooking.full.service;


import com.salonbooking.full.model.Service;
import com.salonbooking.full.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service

public class ServiceServiceImpl implements ServiceService {

    private final ServiceRepository serviceRepository;

    @Autowired
    public ServiceServiceImpl(ServiceRepository serviceRepository) {
        this.serviceRepository = serviceRepository;
    }

    @Override
    public Service saveService(Service service) throws IOException {
        return serviceRepository.save(service);
    }

    @Override
    public List<Service> getAllServices() throws IOException {
        return serviceRepository.findAll();
    }

    @Override
    public Optional<Service> getServiceById(String id) throws IOException {
        return serviceRepository.findById(id);
    }

    @Override
    public List<Service> getServicesByCategory(String category) throws IOException {
        return serviceRepository.findByCategory(category);
    }

    @Override
    public void deleteService(String id) throws IOException {
        serviceRepository.deleteById(id);
    }

}
