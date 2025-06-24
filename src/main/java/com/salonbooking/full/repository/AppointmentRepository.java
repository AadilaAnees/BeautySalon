package com.salonbooking.full.repository;

import com.salonbooking.full.model.Appointment;
import com.salonbooking.full.util.FileUtil;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class AppointmentRepository {
    private static final String APPOINTMENTS_FILE = "appointments.txt";

    public Appointment save(Appointment appointment) throws IOException {
        if (appointment.getId() == null || appointment.getId().isEmpty()) {
            // Generate a simple numeric ID
            List<Appointment> existingAppointments = findAll();

            int maxId = 0;
            for (Appointment existingAppointment : existingAppointments) {
                try {
                    int id = Integer.parseInt(existingAppointment.getId());
                    if (id > maxId) {
                        maxId = id;
                    }
                } catch (NumberFormatException e) {
                    // Skip non-numeric IDs
                }
            }

            appointment.setId(String.valueOf(maxId + 1));
        }

        List<Appointment> appointments = findAll();

        // Remove existing appointment if updating
        appointments = appointments.stream()
                .filter(a -> !a.getId().equals(appointment.getId()))
                .collect(Collectors.toList());

        // Add the new/updated appointment
        appointments.add(appointment);

        // Save all appointments back to file
        FileUtil.writeToFile(APPOINTMENTS_FILE, appointments.stream()
                .map(Appointment::toString)
                .collect(Collectors.toList()));

        return appointment;
    }

    public List<Appointment> findAll() throws IOException {
        List<String> lines = FileUtil.readFromFile(APPOINTMENTS_FILE);
        List<Appointment> appointments = new ArrayList<>();

        for (String line : lines) {
            Appointment appointment = Appointment.fromString(line);
            if (appointment != null) {
                appointments.add(appointment);
            }
        }

        // Sort by date and time
        appointments.sort(Comparator.comparing(Appointment::getAppointmentDate, Comparator.nullsLast(Comparator.naturalOrder()))
                .thenComparing(Appointment::getAppointmentTime, Comparator.nullsLast(Comparator.naturalOrder())));

        return appointments;
    }

    public Optional<Appointment> findById(String id) throws IOException {
        return findAll().stream()
                .filter(appointment -> appointment.getId().equals(id))
                .findFirst();
    }

    public List<Appointment> findByUserId(String userId) throws IOException {
        return findAll().stream()
                .filter(appointment -> appointment.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    public List<Appointment> findByDate(LocalDate date) throws IOException {
        if (date == null) {
            return new ArrayList<>();
        }

        return findAll().stream()
                .filter(appointment ->
                        appointment.getAppointmentDate() != null &&
                                appointment.getAppointmentDate().equals(date))
                .collect(Collectors.toList());
    }

    public List<Appointment> findByStatus(String status) throws IOException {
        return findAll().stream()
                .filter(appointment -> appointment.getStatus().equals(status))
                .collect(Collectors.toList());
    }

    public List<Appointment> findUpcomingAppointments() throws IOException {
        LocalDate today = LocalDate.now();

        return findAll().stream()
                .filter(appointment ->
                        appointment.getAppointmentDate() != null &&
                                !appointment.getStatus().equals("CANCELLED") &&
                                (appointment.getAppointmentDate().equals(today) ||
                                        appointment.getAppointmentDate().isAfter(today)))
                .collect(Collectors.toList());
    }

    public void deleteById(String id) throws IOException {
        List<Appointment> appointments = findAll();

        // Remove the appointment with the given ID
        appointments = appointments.stream()
                .filter(a -> !a.getId().equals(id))
                .collect(Collectors.toList());

        // Save the updated list back to file
        FileUtil.writeToFile(APPOINTMENTS_FILE, appointments.stream()
                .map(Appointment::toString)
                .collect(Collectors.toList()));
    }
}
