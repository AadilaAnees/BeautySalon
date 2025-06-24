package com.salonbooking.full.repository;

import com.salonbooking.full.model.Service;
import com.salonbooking.full.util.FileUtil;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class ServiceRepository {
    private static final String SERVICES_FILE = "services.txt";

    public Service save(Service service) throws IOException {
        if (service.getId() == null || service.getId().isEmpty()) {
            // Generate a simple numeric ID
            List<Service> existingServices = findAll();

            int maxId = 0;
            for (Service existingService : existingServices) {
                try {
                    int id = Integer.parseInt(existingService.getId());
                    if (id > maxId) {
                        maxId = id;
                    }
                } catch (NumberFormatException e) {
                    // Skip non-numeric IDs
                }
            }

            service.setId(String.valueOf(maxId + 1));
        }

        List<Service> services = findAll();

        // Remove existing service if updating
        services = services.stream()
                .filter(s -> !s.getId().equals(service.getId()))
                .collect(Collectors.toList());

        // Add the new/updated service
        services.add(service);

        // Save all services back to file
        FileUtil.writeToFile(SERVICES_FILE, services.stream()
                .map(Service::toString)
                .collect(Collectors.toList()));

        return service;
    }

    public List<Service> findAll() throws IOException {
        List<String> lines = FileUtil.readFromFile(SERVICES_FILE);

        return lines.stream()
                .map(this::parseService)
                .collect(Collectors.toList());
    }

    public Optional<Service> findById(String id) throws IOException {
        return findAll().stream()
                .filter(service -> service.getId().equals(id))
                .findFirst();
    }

    public List<Service> findByCategory(String category) throws IOException {
        return findAll().stream()
                .filter(service -> service.getCategory().equalsIgnoreCase(category))
                .collect(Collectors.toList());
    }

    public void deleteById(String id) throws IOException {
        List<Service> services = findAll();

        // Remove the service with the given ID
        services = services.stream()
                .filter(s -> !s.getId().equals(id))
                .collect(Collectors.toList());

        // Save the updated list back to file
        FileUtil.writeToFile(SERVICES_FILE, services.stream()
                .map(Service::toString)
                .collect(Collectors.toList()));
    }

    private Service parseService(String line) {
        // Handle escaped commas in description
        String[] parts = line.split(",(?=(?:[^\\\\]|[^\\\\]\\\\\\\\)*$)");
        return new Service(
                parts[0],
                parts[1],
                Double.parseDouble(parts[2]),
                Integer.parseInt(parts[3]),
                parts[4].replace("\\,", ","),
                parts[5]
        );
    }
}
