package com.salonbooking.full.controller;


import com.salonbooking.full.model.Appointment;
import com.salonbooking.full.model.Service;
import com.salonbooking.full.model.User;
import com.salonbooking.full.service.AppointmentService;
import com.salonbooking.full.service.ServiceService;
import com.salonbooking.full.service.UserService;
import com.salonbooking.full.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class AppointmentController {

    private final AppointmentService appointmentService;
    private final ServiceService serviceService;
    private final UserService userService;

    @Autowired
    public AppointmentController(AppointmentService appointmentService, ServiceService serviceService, UserService userService) {
        this.appointmentService = appointmentService;
        this.serviceService = serviceService;
        this.userService = userService;

        FileUtil.debugPrintFileContent("appointments.txt");
    }

    // Client endpoints

    @GetMapping("/client/appointments")
    public String clientAppointments(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            List<Appointment> appointments = appointmentService.getAppointmentsByUserId(client.getId());
            model.addAttribute("appointments", appointments);
            return "client/appointments";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load appointments: " + e.getMessage());
            return "client/appointments";
        }
    }

    @GetMapping("/client/appointment/book")
    public String bookAppointmentForm(@RequestParam(required = false) String serviceId,
                                      HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            // Load all services for dropdown if serviceId is not provided
            List<Service> services = serviceService.getAllServices();
            model.addAttribute("services", services);

            // If serviceId is provided, pre-select that service
            if (serviceId != null && !serviceId.isEmpty()) {
                Optional<Service> selectedService = serviceService.getServiceById(serviceId);
                if (selectedService.isPresent()) {
                    model.addAttribute("selectedService", selectedService.get());
                }
            }

            // Set minimum date to today
            model.addAttribute("minDate", LocalDate.now());

            // Create a new appointment object
            Appointment appointment = new Appointment();
            appointment.setUserId(client.getId());
            appointment.setUserName(client.getUsername());
            model.addAttribute("appointment", appointment);

            return "client/book-appointment";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load services: " + e.getMessage());
            return "client/book-appointment";
        }
    }


    private boolean isTimeSlotAvailable(LocalDate date, LocalTime time, String excludeAppointmentId) {
        try {
            List<Appointment> appointments = appointmentService.getAppointmentsByDate(date);

            // Filter out cancelled appointments and the appointment being updated if any
            appointments = appointments.stream()
                    .filter(a -> !a.getStatus().equals("CANCELLED"))
                    .filter(a -> excludeAppointmentId == null || !a.getId().equals(excludeAppointmentId))
                    .collect(Collectors.toList());

            // Check if there's any appointment at the same time
            for (Appointment appointment : appointments) {
                if (appointment.getAppointmentTime().equals(time)) {
                    return false; // Time slot is already booked
                }
            }

            return true; // Time slot is available
        } catch (IOException e) {
            // If there's an error, assume the slot is not available to be safe
            return false;
        }
    }

    @PostMapping("/client/appointment/book")
    public String bookAppointment(@RequestParam String serviceId,
                                  @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate appointmentDate,
                                  @RequestParam String appointmentTime,
                                  @RequestParam(required = false) String notes,
                                  HttpSession session, RedirectAttributes redirectAttributes) {
        User client = (User) session.getAttribute("username");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            Optional<Service> service = serviceService.getServiceById(serviceId);
            if (!service.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid service selected");
                return "redirect:/client/appointment/book";
            }

            // Convert the time string to LocalTime
            LocalTime time = LocalTime.parse(appointmentTime);

            // Check if the time slot is already booked
            boolean isAvailable = isTimeSlotAvailable(appointmentDate, time, null);
            if (!isAvailable) {
                redirectAttributes.addFlashAttribute("error", "The selected time slot is already booked. Please choose another time.");
                return "redirect:/client/appointment/book";
            }

            // Create the appointment
            Appointment appointment = new Appointment();
            appointment.setUserId(client.getId());
            appointment.setUserName(client.getUsername());
            appointment.setServiceId(serviceId);
            appointment.setServiceName(service.get().getName());
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(time);
            appointment.setPrice(service.get().getPrice());
            appointment.setNotes(notes);
            appointment.setStatus("PENDING");

            appointmentService.saveAppointment(appointment);

            redirectAttributes.addFlashAttribute("success", "Appointment booked successfully!");
            return "redirect:/client/appointments";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to book appointment: " + e.getMessage());
            return "redirect:/client/appointment/book";
        }
    }

    @GetMapping("/client/appointment/edit/{id}")
    public String editAppointmentForm(@PathVariable String id, HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
            if (!appointment.isPresent() || !appointment.get().getUserId().equals(client.getId())) {
                return "redirect:/client/appointments";
            }

            // If appointment is cancelled or completed, don't allow editing
            if ("CANCELLED".equals(appointment.get().getStatus()) || "COMPLETED".equals(appointment.get().getStatus())) {
                model.addAttribute("error", "Cancelled or completed appointments cannot be modified");
                return "redirect:/client/appointments";
            }

            // Get the service for this appointment
            Optional<Service> service = serviceService.getServiceById(appointment.get().getServiceId());
            if (service.isPresent()) {
                model.addAttribute("service", service.get());
            }

            model.addAttribute("appointment", appointment.get());

            // Set minimum date to today
            model.addAttribute("minDate", LocalDate.now());

            return "client/edit-appointment";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load appointment: " + e.getMessage());
            return "redirect:/client/appointments";
        }
    }

    @PostMapping("/client/appointment/update")
    public String updateAppointment(@RequestParam String id,
                                    @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate appointmentDate,
                                    @RequestParam String appointmentTime,
                                    @RequestParam(required = false) String notes,
                                    HttpSession session, RedirectAttributes redirectAttributes) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> optionalAppointment = appointmentService.getAppointmentById(id);
            if (!optionalAppointment.isPresent() || !optionalAppointment.get().getUserId().equals(client.getId())) {
                redirectAttributes.addFlashAttribute("error", "Invalid appointment");
                return "redirect:/client/appointments";
            }

            Appointment appointment = optionalAppointment.get();

            // If appointment is cancelled or completed, don't allow editing
            if ("CANCELLED".equals(appointment.getStatus()) || "COMPLETED".equals(appointment.getStatus())) {
                redirectAttributes.addFlashAttribute("error", "Cancelled or completed appointments cannot be modified");
                return "redirect:/client/appointments";
            }

            // Convert the time string to LocalTime
            LocalTime time = LocalTime.parse(appointmentTime);

            // Check if the time slot is already booked by another appointment
            boolean isAvailable = isTimeSlotAvailable(appointmentDate, time, id);
            if (!isAvailable) {
                redirectAttributes.addFlashAttribute("error", "The selected time slot is already booked. Please choose another time.");
                return "redirect:/client/appointment/edit/" + id;
            }

            // Update appointment
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(time);
            appointment.setNotes(notes);
            appointment.setStatus("PENDING"); // Reset to pending if date/time changed

            appointmentService.saveAppointment(appointment);

            redirectAttributes.addFlashAttribute("success", "Appointment updated successfully!");
            return "redirect:/client/appointments";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update appointment: " + e.getMessage());
            return "redirect:/client/appointments";
        }
    }

    @GetMapping("/client/appointment/cancel/{id}")
    public String cancelClientAppointment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
            if (!appointment.isPresent() || !appointment.get().getUserId().equals(client.getId())) {
                redirectAttributes.addFlashAttribute("error", "Invalid appointment");
                return "redirect:/client/appointments";
            }

            // If appointment is already cancelled or completed, don't allow cancelling
            if ("CANCELLED".equals(appointment.get().getStatus()) || "COMPLETED".equals(appointment.get().getStatus())) {
                redirectAttributes.addFlashAttribute("error", "This appointment cannot be cancelled");
                return "redirect:/client/appointments";
            }

            appointmentService.cancelAppointment(id);

            redirectAttributes.addFlashAttribute("success", "Appointment cancelled successfully!");
            return "redirect:/client/appointments";

        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel appointment: " + e.getMessage());
            return "redirect:/client/appointments";
        }
    }

    // Admin endpoints

    @GetMapping("/admin/appointments")
    public String adminAppointments(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            List<Appointment> appointments = appointmentService.getAllAppointments();
            model.addAttribute("appointments", appointments);
            return "admin/appointments";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load appointments: " + e.getMessage());
            return "admin/appointments";
        }
    }

    @GetMapping("/admin/appointment/edit/{id}")
    public String adminEditAppointmentForm(@PathVariable String id, HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
            if (!appointment.isPresent()) {
                return "redirect:/admin/appointments";
            }

            // Get the service for this appointment
            Optional<Service> service = serviceService.getServiceById(appointment.get().getServiceId());
            if (service.isPresent()) {
                model.addAttribute("service", service.get());
            }

            // Get all clients for possible reassignment
            List<User> clients = userService.getAllClients();
            model.addAttribute("clients", clients);


            model.addAttribute("appointment", appointment.get());

            // Set minimum date to today
            model.addAttribute("minDate", LocalDate.now());

            return "admin/edit-appointment";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load appointment: " + e.getMessage());
            return "redirect:/admin/appointments";
        }
    }

    @PostMapping("/admin/appointment/update")
    public String adminUpdateAppointment(@RequestParam String id,
                                         @RequestParam String userId,
                                         @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate appointmentDate,
                                         @RequestParam String appointmentTime,
                                         @RequestParam String status,
                                         @RequestParam(required = false) String notes,
                                         HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> optionalAppointment = appointmentService.getAppointmentById(id);
            if (!optionalAppointment.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid appointment");
                return "redirect:/admin/appointments";
            }

            Appointment appointment = optionalAppointment.get();

            // Check if the user exists
            Optional<User> user = userService.getUserById(userId);
            if (!user.isPresent() || !"CLIENT".equals(user.get().getRole())) {
                redirectAttributes.addFlashAttribute("error", "Invalid client selected");
                return "redirect:/admin/appointment/edit/" + id;
            }

            // Get service to check duration
            Optional<Service> service = serviceService.getServiceById(appointment.getServiceId());
            if (!service.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Service not found");
                return "redirect:/admin/appointments";
            }

            LocalTime time = LocalTime.parse(appointmentTime);
            int duration = service.get().getDurationMinutes();

            // Check if time slot is still available (excluding this appointment)
            if (!appointmentService.isTimeSlotAvailable(appointmentDate, time, duration, id)) {
                redirectAttributes.addFlashAttribute("error", "The selected time slot is not available");
                return "redirect:/admin/appointment/edit/" + id;
            }

            // Update appointment
            appointment.setUserId(userId);
            appointment.setUserName(user.get().getUsername());
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(time);
            appointment.setStatus(status);
            appointment.setNotes(notes);

            appointmentService.saveAppointment(appointment);

            redirectAttributes.addFlashAttribute("success", "Appointment updated successfully!");
            return "redirect:/admin/appointments";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update appointment: " + e.getMessage());
            return "redirect:/admin/appointments";
        }
    }

    @GetMapping("/admin/appointment/delete/{id}")
    public String deleteAppointment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            appointmentService.deleteAppointment(id);
            redirectAttributes.addFlashAttribute("success", "Appointment deleted successfully!");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete appointment: " + e.getMessage());
        }
        return "redirect:/admin/appointments";
    }

    @GetMapping("/admin/appointment/cancel/{id}")
    public String cancelAdminAppointment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
            if (!appointment.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid appointment");
                return "redirect:/admin/appointments";
            }

            // If appointment is already cancelled or completed, don't allow cancelling
            if ("CANCELLED".equals(appointment.get().getStatus()) || "COMPLETED".equals(appointment.get().getStatus())) {
                redirectAttributes.addFlashAttribute("error", "This appointment cannot be cancelled");
                return "redirect:/admin/appointments";
            }

            appointmentService.cancelAppointment(id);

            redirectAttributes.addFlashAttribute("success", "Appointment cancelled successfully!");
            return "redirect:/admin/appointments";

        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel appointment: " + e.getMessage());
            return "redirect:/admin/appointments";
        }
    }

    @GetMapping("/admin/appointment/change-status/{id}/{status}")
    public String changeAppointmentStatus(@PathVariable String id, @PathVariable String status,
                                          HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Appointment> optionalAppointment = appointmentService.getAppointmentById(id);
            if (!optionalAppointment.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid appointment");
                return "redirect:/admin/appointments";
            }

            Appointment appointment = optionalAppointment.get();

            // Validate status
            if (!status.equals("PENDING") && !status.equals("CONFIRMED") &&
                    !status.equals("COMPLETED") && !status.equals("CANCELLED")) {
                redirectAttributes.addFlashAttribute("error", "Invalid status");
                return "redirect:/admin/appointments";
            }

            // Update status
            appointment.setStatus(status);
            appointmentService.saveAppointment(appointment);

            redirectAttributes.addFlashAttribute("success", "Appointment status updated to " + status);
            return "redirect:/admin/appointments";

        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update appointment status: " + e.getMessage());
            return "redirect:/admin/appointments";
        }
    }

    // Dashboard components

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            // Get today's appointments
            LocalDate today = LocalDate.now();
            List<Appointment> todayAppointments = appointmentService.getAppointmentsByDate(today);

            // Sort by time
            todayAppointments.sort(Comparator.comparing(Appointment::getAppointmentTime,
                    Comparator.nullsLast(Comparator.naturalOrder())));

            model.addAttribute("todayAppointments", todayAppointments);

            return "admin/dashboard";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load today's appointments: " + e.getMessage());
            return "admin/dashboard";
        }
    }

    @GetMapping("/admin/dashboard/today-appointments")
    public String adminTodayAppointments(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            List<Appointment> appointments = appointmentService.getAppointmentsByDate(LocalDate.now());
            model.addAttribute("todayAppointments", appointments);
            return "admin/dashboard-today-appointments";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load today's appointments: " + e.getMessage());
            return "admin/dashboard-today-appointments";
        }
    }
}
