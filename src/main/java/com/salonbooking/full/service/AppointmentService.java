package com.salonbooking.full.service;

import com.salonbooking.full.model.Appointment;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

public interface AppointmentService {
    Appointment saveAppointment(Appointment appointment) throws IOException;
    List<Appointment> getAllAppointments() throws IOException;
    Optional<Appointment> getAppointmentById(String id) throws IOException;
    List<Appointment> getAppointmentsByUserId(String userId) throws IOException;
    List<Appointment> getAppointmentsByDate(LocalDate date) throws IOException;
    List<Appointment> getAppointmentsByStatus(String status) throws IOException;
    List<Appointment> getUpcomingAppointments() throws IOException;
    void deleteAppointment(String id) throws IOException;
    boolean isTimeSlotAvailable(LocalDate date, LocalTime time, int durationMinutes, String appointmentIdToExclude) throws IOException;
    Appointment cancelAppointment(String id) throws IOException;
    List<String> getAvailableTimeSlots(LocalDate date, int durationMinutes) throws IOException;
}
