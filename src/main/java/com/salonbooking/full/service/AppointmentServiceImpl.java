package com.salonbooking.full.service;

import com.salonbooking.full.model.Appointment;
import com.salonbooking.full.model.Service;
import com.salonbooking.full.model.User;
import com.salonbooking.full.repository.AppointmentRepository;
import com.salonbooking.full.repository.ServiceRepository;
import com.salonbooking.full.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@org.springframework.stereotype.Service
public class AppointmentServiceImpl implements AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final ServiceRepository serviceRepository;
    private final UserRepository userRepository;

    // Salon business hours
    private static final LocalTime OPENING_TIME = LocalTime.of(9, 0); // 9:00 AM
    private static final LocalTime CLOSING_TIME = LocalTime.of(18, 0); // 6:00 PM
    private static final int TIME_SLOT_INTERVAL = 30; // minutes

    @Autowired
    public AppointmentServiceImpl(
            AppointmentRepository appointmentRepository,
            ServiceRepository serviceRepository,
            UserRepository userRepository) {
        this.appointmentRepository = appointmentRepository;
        this.serviceRepository = serviceRepository;
        this.userRepository = userRepository;
    }

    @Override
    public Appointment saveAppointment(Appointment appointment) throws IOException {
        // If it's a new appointment, set the status to PENDING
        if (appointment.getId() == null || appointment.getId().isEmpty()) {
            appointment.setStatus("PENDING");

            // Set service name and price if it's not already set
            if (appointment.getServiceName() == null || appointment.getServiceName().isEmpty()) {
                Optional<Service> service = serviceRepository.findById(appointment.getServiceId());
                if (service.isPresent()) {
                    appointment.setServiceName(service.get().getName());
                    appointment.setPrice(service.get().getPrice());
                }
            }

            // Set user name if it's not already set
            if (appointment.getUserName() == null || appointment.getUserName().isEmpty()) {
                Optional<User> user = userRepository.findById(appointment.getUserId());
                if (user.isPresent()) {
                    appointment.setUserName(user.get().getUsername());
                }
            }
        }

        return appointmentRepository.save(appointment);
    }

    @Override
    public List<Appointment> getAllAppointments() throws IOException {
        return appointmentRepository.findAll();
    }

    @Override
    public Optional<Appointment> getAppointmentById(String id) throws IOException {
        return appointmentRepository.findById(id);
    }

    @Override
    public List<Appointment> getAppointmentsByUserId(String userId) throws IOException {
        return appointmentRepository.findByUserId(userId);
    }

    @Override
    public List<Appointment> getAppointmentsByDate(LocalDate date) throws IOException {
        return appointmentRepository.findByDate(date);
    }

    @Override
    public List<Appointment> getAppointmentsByStatus(String status) throws IOException {
        return appointmentRepository.findByStatus(status);
    }

    @Override
    public List<Appointment> getUpcomingAppointments() throws IOException {
        return appointmentRepository.findUpcomingAppointments();
    }

    @Override
    public void deleteAppointment(String id) throws IOException {
        appointmentRepository.deleteById(id);
    }

    @Override
    public boolean isTimeSlotAvailable(LocalDate date, LocalTime startTime, int durationMinutes, String appointmentIdToExclude) throws IOException {
        // Check if the requested time is within business hours
        if (startTime.isBefore(OPENING_TIME) || startTime.plusMinutes(durationMinutes).isAfter(CLOSING_TIME)) {
            return false;
        }

        // Get all appointments for the date
        List<Appointment> appointments = appointmentRepository.findByDate(date);

        // Filter out cancelled appointments and the appointment being updated if any
        appointments = appointments.stream()
                .filter(a -> !a.getStatus().equals("CANCELLED"))
                .filter(a -> appointmentIdToExclude == null || !a.getId().equals(appointmentIdToExclude))
                .collect(Collectors.toList());

        // Check for conflicts
        LocalTime endTime = startTime.plusMinutes(durationMinutes);

        for (Appointment appointment : appointments) {
            LocalTime existingStartTime = appointment.getAppointmentTime();

            // Get the service to find its duration
            Optional<Service> service = serviceRepository.findById(appointment.getServiceId());
            if (!service.isPresent()) {
                continue;
            }

            int existingDuration = service.get().getDurationMinutes();
            LocalTime existingEndTime = existingStartTime.plusMinutes(existingDuration);

            // Check if there's an overlap
            if (!(endTime.isBefore(existingStartTime) || startTime.isAfter(existingEndTime))) {
                return false; // Conflict found
            }
        }

        return true; // No conflicts
    }

    @Override
    public Appointment cancelAppointment(String id) throws IOException {
        Optional<Appointment> optionalAppointment = appointmentRepository.findById(id);
        if (optionalAppointment.isPresent()) {
            Appointment appointment = optionalAppointment.get();
            appointment.setStatus("CANCELLED");
            return appointmentRepository.save(appointment);
        }
        return null;
    }

    @Override
    public List<String> getAvailableTimeSlots(LocalDate date, int durationMinutes) throws IOException {
        List<String> availableSlots = new ArrayList<>();

        // Generate time slots at the specified interval
        LocalTime currentTime = OPENING_TIME;
        while (currentTime.plusMinutes(durationMinutes).isBefore(CLOSING_TIME) ||
                currentTime.plusMinutes(durationMinutes).equals(CLOSING_TIME)) {

            if (isTimeSlotAvailable(date, currentTime, durationMinutes, null)) {
                availableSlots.add(currentTime.toString());
            }

            currentTime = currentTime.plusMinutes(TIME_SLOT_INTERVAL);
        }

        return availableSlots;
    }
}
